-- =====================================================================
--  HOOK N' QUEUE · Fondo del tablón elegido por cada jugador
--  Pegá TODO en Supabase > SQL Editor > New query > Run
--  Se puede correr más de una vez sin problema.
--
--  Agrega al perfil el campeón que cada uno quiere ver de fondo en el
--  muelle del tablón (detrás del nombre del server). Vacío = Thresh.
--  Cada uno solo puede cambiar el suyo (ya lo cubre la regla
--  "editar mi perfil").
-- =====================================================================

alter table public.profiles add column if not exists bg_champ text;

alter table public.profiles drop constraint if exists profiles_bg_champ_len;
alter table public.profiles add constraint profiles_bg_champ_len
  check (bg_champ is null or char_length(bg_champ) between 1 and 40);
