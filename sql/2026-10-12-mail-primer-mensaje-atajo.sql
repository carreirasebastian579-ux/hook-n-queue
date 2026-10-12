-- =====================================================================
--  HOOK N' QUEUE · ATAJO TEMPORAL: el primer mensaje avisa como 'message'
--  Pegá TODO en Supabase > SQL Editor > New query > Run
--  Se puede correr más de una vez sin problema.
--
--  Por qué: Supabase no deja publicar la Edge Function "notificar" nueva
--  (error 500 al deployar). La versión publicada (v4) solo muestra el texto
--  en los mails de tipo 'message'; en 'new_chat' dice "te abrió un chat"
--  sin el mensaje. Mientras tanto, el primer mensaje se avisa como 'message'
--  para que el mail traiga el texto.
--
--  PARA VOLVER ATRÁS cuando se publique mails/notificar.ts (la que maneja
--  'new_chat' con mensaje): en la línea marcada con «ATAJO», cambiá
--  'message' por 'new_chat' y volvé a correr este archivo
--  (o corré de nuevo sql/2026-10-12-mail-primer-mensaje.sql).
--
--  Requiere haber corrido antes sql/2026-10-12-mail-primer-mensaje.sql
--  (que saca el aviso al crear el chat).
-- =====================================================================

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
                   case when first_msg then 'message' else 'message' end,  -- ATAJO: volver a 'new_chat' (el primero) cuando se publique notificar nueva
                   c.offer_title, new.body);
  return new;
end $$;
drop trigger if exists hnq_new_message on public.messages;
create trigger hnq_new_message after insert on public.messages
  for each row execute function public.hnq_on_new_message();
