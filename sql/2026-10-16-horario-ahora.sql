-- =====================================================================
--  HOOK N' QUEUE · Suma "Ahora" a los horarios permitidos en las ofertas
--  Pegá TODO en Supabase > SQL Editor > Run. Se puede correr más de una vez.
--
--  Toma el control "hnq_offer_values" tal como está y solo agrega 'Ahora'
--  al lado de 'Madrugada'. Todo lo demás del control queda igual.
--  Al final muestra cómo quedó el control.
-- =====================================================================

do $$
declare
  def text;
  nuevo text;
begin
  select pg_get_constraintdef(oid) into def
  from pg_constraint
  where conname = 'hnq_offer_values' and conrelid = 'public.offers'::regclass;

  if def is null then
    raise exception 'No encontré el control hnq_offer_values';
  end if;

  if position('''Ahora''' in def) > 0 then
    return; -- ya estaba
  end if;

  nuevo := replace(def, '''Madrugada''::text', '''Madrugada''::text, ''Ahora''::text');
  if nuevo = def then
    raise exception 'No encontré dónde sumar Ahora. Control actual: %', def;
  end if;

  alter table public.offers drop constraint hnq_offer_values;
  execute 'alter table public.offers add constraint hnq_offer_values ' || nuevo;
end $$;

select pg_get_constraintdef(oid) as control_actual
from pg_constraint
where conname = 'hnq_offer_values' and conrelid = 'public.offers'::regclass;
