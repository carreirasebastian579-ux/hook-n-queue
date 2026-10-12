-- =====================================================================
--  HOOK N' QUEUE · Un solo mail cuando alguien te escribe por primera vez
--  Pegá TODO en Supabase > SQL Editor > New query > Run
--  Se puede correr más de una vez sin problema.
--
--  Antes: al crear el chat se mandaba "X quiere jugar con vos" (sin texto)
--         y después, por cada mensaje, "Nuevo mensaje de X".
--  Ahora: el chat nace con el primer mensaje, así que el aviso de "chat nuevo"
--         sale con ese primer mensaje adentro. Crear un chat ya no avisa.
-- =====================================================================

-- ---------- Crear un chat ya no manda mail ----------
create or replace function public.hnq_on_new_chat()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  return new;  -- el aviso sale con el primer mensaje (ver hnq_on_new_message)
end $$;
drop trigger if exists hnq_new_chat on public.chats;

-- ---------- Te mandaron un mensaje ----------
create or replace function public.hnq_on_new_message()
returns trigger language plpgsql security definer set search_path = public as $$
declare c record; recipient uuid; last_at timestamptz; first_msg boolean;
begin
  select * into c from chats where id = new.chat_id;
  if c is null then return new; end if;
  if new.sender_id = c.owner_id then recipient := c.guest_id; last_at := c.guest_notified_at;
  else recipient := c.owner_id; last_at := c.owner_notified_at; end if;
  -- ¿es el primer mensaje del chat? (el trigger corre después de guardarlo)
  first_msg := not exists (select 1 from messages where chat_id = c.id and id <> new.id);
  -- como máximo un mail por chat cada hora
  -- (también evita un mail doble si el chat lo abrió una versión vieja de la página)
  if last_at is not null and last_at > now() - interval '1 hour' then return new; end if;
  -- si la otra persona escribió hace menos de 10 minutos, está chateando: no molestar
  if exists (select 1 from messages where chat_id = c.id and sender_id = recipient
             and created_at > now() - interval '10 minutes') then return new; end if;
  if recipient = c.owner_id then update chats set owner_notified_at = now() where id = c.id;
  else update chats set guest_notified_at = now() where id = c.id; end if;
  perform hnq_send(recipient, new.sender_id,
                   case when first_msg then 'new_chat' else 'message' end,
                   c.offer_title, new.body);
  return new;
end $$;
drop trigger if exists hnq_new_message on public.messages;
create trigger hnq_new_message after insert on public.messages
  for each row execute function public.hnq_on_new_message();
