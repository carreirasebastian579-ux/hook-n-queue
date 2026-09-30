-- =====================================================================
--  HOOK N' QUEUE · Base de datos
--  Pegá TODO este archivo en Supabase > SQL Editor > New query > Run
-- =====================================================================

-- ---------- PERFILES ----------
create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  nick        text not null check (char_length(nick) between 3 and 16),
  tag         text not null check (tag ~ '^[A-Z0-9]{3,5}$'),
  server      text not null check (server in ('LAS','LAN','BR','NA','EUW','EUNE','KR','OCE')),
  color       text default '#3F6FD8',
  photo_url   text,
  created_at  timestamptz not null default now(),
  unique (nick, tag)
);

-- ---------- OFERTAS ----------
create table if not exists public.offers (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references public.profiles(id) on delete cascade,
  server      text not null check (server in ('LAS','LAN','BR','NA','EUW','EUNE','KR','OCE')),
  titulo      text not null check (char_length(titulo) between 5 and 80),
  modos       text[] not null check (cardinality(modos) > 0),
  roles       text[] not null check (cardinality(roles) > 0),
  busca       text[] not null check (cardinality(busca) > 0),
  rango       text not null,
  rango_min   text,
  rango_max   text,
  horarios    text[] not null check (cardinality(horarios) > 0),
  mic         text[] not null default '{}',
  onda        text[] not null default '{}',
  closed_at   timestamptz,
  created_at  timestamptz not null default now()
);
create index if not exists offers_server_idx on public.offers (server, created_at desc);

-- ---------- CHATS ----------
create table if not exists public.chats (
  id           uuid primary key default gen_random_uuid(),
  offer_id     uuid references public.offers(id) on delete set null,
  offer_title  text not null,
  owner_id     uuid not null references public.profiles(id) on delete cascade, -- quien publicó
  guest_id     uuid not null references public.profiles(id) on delete cascade, -- quien escribió
  ended_at     timestamptz,
  created_at   timestamptz not null default now(),
  unique (offer_id, guest_id),
  check (owner_id <> guest_id)
);

-- ---------- MENSAJES ----------
create table if not exists public.messages (
  id          bigint generated always as identity primary key,
  chat_id     uuid not null references public.chats(id) on delete cascade,
  sender_id   uuid not null references public.profiles(id) on delete cascade,
  body        text not null check (char_length(body) between 1 and 500),
  created_at  timestamptz not null default now()
);
create index if not exists messages_chat_idx on public.messages (chat_id, created_at);

-- ---------- BLOQUEOS Y REPORTES ----------
create table if not exists public.blocks (
  blocker_id  uuid not null references public.profiles(id) on delete cascade,
  blocked_id  uuid not null references public.profiles(id) on delete cascade,
  created_at  timestamptz not null default now(),
  primary key (blocker_id, blocked_id)
);

create table if not exists public.reports (
  id           bigint generated always as identity primary key,
  reporter_id  uuid not null references public.profiles(id) on delete cascade,
  reported_id  uuid not null references public.profiles(id) on delete cascade,
  reason       text,
  created_at   timestamptz not null default now()
);

-- =====================================================================
--  FUNCIONES DE AYUDA
-- =====================================================================
create or replace function public.is_chat_member(c uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from chats where id = c and auth.uid() in (owner_id, guest_id));
$$;

create or replace function public.is_blocked_between(a uuid, b uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from blocks
    where (blocker_id = a and blocked_id = b) or (blocker_id = b and blocked_id = a));
$$;

-- Cuando alguien cierra su oferta ("Ya encontré"), sus chats arrancan la cuenta de 24 hs
create or replace function public.on_offer_closed()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.closed_at is not null and old.closed_at is null then
    update chats set ended_at = now() where offer_id = new.id and ended_at is null;
  end if;
  return new;
end $$;

drop trigger if exists offer_closed on public.offers;
create trigger offer_closed after update on public.offers
  for each row execute function public.on_offer_closed();

-- =====================================================================
--  SEGURIDAD (RLS): quién puede ver y tocar qué
-- =====================================================================
alter table public.profiles enable row level security;
alter table public.offers   enable row level security;
alter table public.chats    enable row level security;
alter table public.messages enable row level security;
alter table public.blocks   enable row level security;
alter table public.reports  enable row level security;

-- Perfiles: todos los usuarios logueados los ven; cada uno edita solo el suyo
drop policy if exists "ver perfiles" on public.profiles;
create policy "ver perfiles" on public.profiles for select to authenticated using (true);
drop policy if exists "crear mi perfil" on public.profiles;
create policy "crear mi perfil" on public.profiles for insert to authenticated with check (id = auth.uid());
drop policy if exists "editar mi perfil" on public.profiles;
create policy "editar mi perfil" on public.profiles for update to authenticated using (id = auth.uid()) with check (id = auth.uid());

-- Ofertas: se ven las abiertas y de menos de 15 días (las tuyas siempre)
drop policy if exists "ver ofertas" on public.offers;
create policy "ver ofertas" on public.offers for select to authenticated
  using (user_id = auth.uid() or (closed_at is null and created_at > now() - interval '15 days'));
drop policy if exists "publicar oferta" on public.offers;
create policy "publicar oferta" on public.offers for insert to authenticated with check (user_id = auth.uid());
drop policy if exists "cerrar mi oferta" on public.offers;
create policy "cerrar mi oferta" on public.offers for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
drop policy if exists "borrar mi oferta" on public.offers;
create policy "borrar mi oferta" on public.offers for delete to authenticated using (user_id = auth.uid());

-- Chats: solo los dos participantes los ven; lo abre quien escribe a una oferta ajena y abierta
drop policy if exists "ver mis chats" on public.chats;
create policy "ver mis chats" on public.chats for select to authenticated
  using (auth.uid() in (owner_id, guest_id));
drop policy if exists "abrir chat" on public.chats;
create policy "abrir chat" on public.chats for insert to authenticated
  with check (
    guest_id = auth.uid()
    and not public.is_blocked_between(owner_id, guest_id)
    and exists (select 1 from public.offers o
                where o.id = offer_id and o.user_id = owner_id and o.closed_at is null
                  and o.created_at > now() - interval '15 days')
  );

-- Mensajes: solo participantes, sin bloqueos, y hasta 24 hs después de terminada la oferta
drop policy if exists "ver mensajes" on public.messages;
create policy "ver mensajes" on public.messages for select to authenticated
  using (public.is_chat_member(chat_id));
drop policy if exists "mandar mensaje" on public.messages;
create policy "mandar mensaje" on public.messages for insert to authenticated
  with check (
    sender_id = auth.uid()
    and exists (select 1 from public.chats c
                where c.id = chat_id
                  and auth.uid() in (c.owner_id, c.guest_id)
                  and (c.ended_at is null or c.ended_at > now() - interval '24 hours')
                  and not public.is_blocked_between(c.owner_id, c.guest_id))
  );

-- Bloqueos: cada uno maneja los suyos
drop policy if exists "mis bloqueos" on public.blocks;
create policy "mis bloqueos" on public.blocks for all to authenticated
  using (blocker_id = auth.uid()) with check (blocker_id = auth.uid());

-- Reportes: cualquiera puede reportar, nadie los lee desde la app
drop policy if exists "reportar" on public.reports;
create policy "reportar" on public.reports for insert to authenticated with check (reporter_id = auth.uid());

-- Permisos de acceso (porque desactivamos "exponer tablas automáticamente")
grant usage on schema public to authenticated;
grant select, insert, update on public.profiles to authenticated;
grant select, insert, update, delete on public.offers to authenticated;
grant select, insert on public.chats to authenticated;
grant select, insert on public.messages to authenticated;
grant select, insert, delete on public.blocks to authenticated;
grant insert on public.reports to authenticated;
grant execute on function public.is_chat_member(uuid) to authenticated;
grant execute on function public.is_blocked_between(uuid, uuid) to authenticated;

-- =====================================================================
--  CHAT EN VIVO (Realtime)
-- =====================================================================
do $$ begin
  begin alter publication supabase_realtime add table public.messages; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.chats;    exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table public.offers;   exception when duplicate_object then null; end;
end $$;

-- =====================================================================
--  FOTOS DE PERFIL (Storage)
-- =====================================================================
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do nothing;

drop policy if exists "ver avatares" on storage.objects;
create policy "ver avatares" on storage.objects for select using (bucket_id = 'avatars');
drop policy if exists "subir mi avatar" on storage.objects;
create policy "subir mi avatar" on storage.objects for insert to authenticated
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "cambiar mi avatar" on storage.objects;
create policy "cambiar mi avatar" on storage.objects for update to authenticated
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
drop policy if exists "borrar mi avatar" on storage.objects;
create policy "borrar mi avatar" on storage.objects for delete to authenticated
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

-- =====================================================================
--  LIMPIEZA AUTOMÁTICA (cada hora)
-- =====================================================================
create extension if not exists pg_cron;

create or replace function public.limpieza()
returns void language plpgsql security definer set search_path = public as $$
begin
  -- ofertas vencidas (15 días): sus chats arrancan la cuenta de 24 hs
  update chats c set ended_at = now()
    from offers o
   where c.offer_id = o.id and c.ended_at is null
     and o.created_at < now() - interval '15 days';
  -- chats terminados hace más de 24 hs: se borran (con sus mensajes)
  delete from chats where ended_at < now() - interval '24 hours';
  -- ofertas vencidas o cerradas hace más de 24 hs: se borran
  delete from offers
   where created_at < now() - interval '15 days' - interval '24 hours'
      or closed_at  < now() - interval '24 hours';
end $$;

do $$ begin
  perform cron.unschedule('hnq-limpieza') where exists (select 1 from cron.job where jobname = 'hnq-limpieza');
end $$;
select cron.schedule('hnq-limpieza', '0 * * * *', 'select public.limpieza()');
