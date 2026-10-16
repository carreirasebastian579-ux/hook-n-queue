-- =====================================================================
--  HOOK N' QUEUE · Tablón público (mirar ofertas sin iniciar sesión)
--  Pegá TODO en Supabase > SQL Editor > Run. Se puede correr más de una vez.
--
--  No abre las tablas: las políticas de offers y profiles siguen siendo
--  solo para usuarios logueados. Esta función entrega una copia recortada:
--  ofertas abiertas de los últimos 15 días + nick, tag, color, foto, mains
--  y server de quien publicó. Nada de mails, chats, bloqueos ni reportes.
-- =====================================================================

create or replace function public.hnq_public_board()
returns setof json
language sql
stable
security definer
set search_path = public
as $$
  select json_build_object(
    'id', o.id, 'user_id', o.user_id, 'server', o.server, 'titulo', o.titulo,
    'modos', o.modos, 'roles', o.roles, 'busca', o.busca,
    'rango', o.rango, 'rango_min', o.rango_min, 'rango_max', o.rango_max,
    'horarios', o.horarios, 'mic', o.mic, 'onda', o.onda,
    'like_champs', o.like_champs, 'avoid_champs', o.avoid_champs,
    'created_at', o.created_at,
    'profiles', json_build_object(
      'nick', p.nick, 'tag', p.tag, 'color', p.color,
      'photo_url', p.photo_url, 'mains', p.mains, 'server', p.server))
  from public.offers o
  join public.profiles p on p.id = o.user_id
  where o.closed_at is null
    and o.created_at > now() - interval '15 days'
    and not exists (select 1 from public.banned b where b.user_id = o.user_id)
  order by o.created_at desc
  limit 500;
$$;

revoke all on function public.hnq_public_board() from public;
grant execute on function public.hnq_public_board() to anon, authenticated;
