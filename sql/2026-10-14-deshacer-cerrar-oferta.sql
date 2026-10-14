-- =====================================================================
--  HOOK N' QUEUE · "Deshacer" después de "Ya encontré"
--  Pegá TODO en Supabase > SQL Editor > New query > Run
--  Se puede correr más de una vez sin problema.
--
--  - La hora de cierre la pone la base (no el navegador).
--  - Reabrir una oferta solo se puede hasta 2 minutos después de cerrarla,
--    y sin pasar el máximo de 5 ofertas activas.
--  - Al reabrir, los chats que había terminado ese cierre vuelven a estar activos
--    (se frena la cuenta de 24 hs).
-- =====================================================================

-- ---------- Control antes de cerrar o reabrir ----------
create or replace function public.hnq_offer_close_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.closed_at is not null and old.closed_at is null then
    new.closed_at := now();                       -- cerrar: hora de la base
  elsif new.closed_at is null and old.closed_at is not null then
    if old.closed_at < now() - interval '2 minutes' then
      raise exception 'HNQ_REOPEN_LATE';          -- "Deshacer" solo por 2 minutos
    end if;
    if (select count(*) from offers
         where user_id = new.user_id and closed_at is null
           and created_at > now() - interval '15 days') >= 5 then
      raise exception 'HNQ_LIMIT_OFFERS';         -- máximo 5 ofertas activas
    end if;
  end if;
  return new;
end $$;
drop trigger if exists hnq_offer_close_guard on public.offers;
create trigger hnq_offer_close_guard before update on public.offers
  for each row execute function public.hnq_offer_close_guard();

-- ---------- Al cerrar, los chats arrancan la cuenta de 24 hs; al reabrir, se frena ----------
create or replace function public.on_offer_closed()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.closed_at is not null and old.closed_at is null then
    update chats set ended_at = now() where offer_id = new.id and ended_at is null;
  elsif new.closed_at is null and old.closed_at is not null then
    -- "Deshacer": vuelven los chats que terminó este cierre
    update chats set ended_at = null where offer_id = new.id and ended_at >= old.closed_at;
  end if;
  return new;
end $$;
drop trigger if exists offer_closed on public.offers;
create trigger offer_closed after update on public.offers
  for each row execute function public.on_offer_closed();
