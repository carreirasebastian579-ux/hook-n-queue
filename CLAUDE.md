# Hook n' Queue · Guía para Claude Code

Web para encontrar con quién jugar League of Legends. Online en https://hooknqueue.com.
El dueño (Sebastian) no es programador: explicale todo en español rioplatense, corto y paso a paso.

## Cómo está armado
- **Sitio estático, sin build**: todo es HTML/CSS/JS plano. No agregues frameworks, bundlers ni npm al sitio.
- `index.html`: landing + app completa en un solo archivo (CSS y JS adentro).
- `privacidad.html`, `baja.html`, `robots.txt`, `sitemap.xml`, íconos y `og.png`.
- **Hosting**: Vercel, se publica solo con cada push a `main` de GitHub.
- **Backend**: Supabase (proyecto `onidctftsskhgqdtjiib`). Base de datos, login con Google, chat en vivo (Realtime), fotos (bucket `avatars`), y una Edge Function `notificar` que manda mails con Resend.
- La clave `sb_publishable_...` que está en el HTML es pública a propósito. Está bien que esté ahí.

## Reglas importantes
- **Nunca subas secretos al repo**: claves de Resend, `service_role` de Supabase, ni el `HNQ_SECRET`. Si un archivo SQL los contiene, no lo commitees.
- **Cambios de base de datos**: no tenés acceso a Supabase. Escribí el SQL en `sql/AAAA-MM-DD-descripcion.sql`, idempotente (`if not exists`, `drop ... if exists`), y explicale a Sebastian que lo pegue en Supabase → SQL Editor → Run **antes** de pushear el HTML que lo usa.
- La seguridad real está en la base (RLS, triggers, límites). No confíes solo en validaciones del navegador.
- La tabla `offers` tiene un control `hnq_offer_values` que solo acepta ciertos valores (modos, horarios, etc.). Si sumás una opción nueva, primero el SQL que la agregue (ver `sql/2026-10-16-horario-ahora.sql`), después el HTML. La vista previa local simula la base, así que estos errores no se ven ahí.
- **Antes de pushear**, mostrale a Sebastian qué cambió y pedile confirmación. Cada push a `main` sale publicado al instante.
- **Cambios visuales**: primero mostrale una maqueta (o la página andando solo en local) y esperá su OK. Trabajá de a un tema por vez.
- Probá en ancho de compu (≥1500px, con columnas laterales) y de celular (390px). En celular no tiene que haber scroll horizontal.

## Identidad visual (respetarla)
El sistema completo está en `DESIGN.md` (estilo "El Anzuelo Espectral"); `PRODUCT.md` tiene el contexto del producto. Leelos antes de cualquier cambio visual.
- Nombre: **Hook n' Queue**. Logo: wordmark "HOOK N' QUEUE" con el apóstrofe en forma de anzuelo.
- **Landing**: **Verde Espectral** (`#45E6A6`) sobre casi negro (fondo `#060F0D`). El hero tiene un **farol de pesca nocturna** (dibujo propio) que es la fuente de luz: penumbra hacia los bordes, humo y brasas solo cerca del farol; la oferta de ejemplo cuelga del farol y al scrollear el anzuelo engancha el título y arrastra la página. Es el único lugar donde algo brilla. Thresh (splash oficial) aparece difuminado en el cierre.
- **Adentro de la app** (`html.in-app`): gris grafito (`#0D0F0F`) y **Verde Muelle** (`#3DBF8E`). Cálida y gamer, pero **sin brillos** (ni glows ni degradés verdes). El tablón abre con el **muelle**: splash difuminado del campeón que cada uno elige en Editar perfil ("Fondo del tablón", por defecto Thresh), "SERVER" + código grande y tres datos etiquetados. Bordes casi rectos (6px), franja verde en el server activo y en tu oferta, ofertas como franjas/tarjetas separadas.
- **Letras**: **Barlow Condensed** solo para títulos grandes (código del server, títulos de la landing); **Saira Condensed** para etiquetas chiquitas en mayúsculas, botones, rangos, encabezados, servers y pestañas; **Inter** para el texto normal.
- **"En línea" = "farol prendido"**: farolito en el avatar, filtro "Farol prendido". Las posiciones tienen color propio; los íconos oficiales de posición se muestran como silueta plateada (Fill usa el ícono propio). Los botones usan íconos propios de línea, nunca emojis.
- Siempre usar las variables CSS (`--accent`, `--surface`, `--ink`…), no colores fijos, así cada componente funciona en la landing y en la app.
- Plano por capas: sin sombras en tarjetas, paneles ni botones; solo en lo que flota (menús, chat, ventanas).
- Logos propios; nunca usar logos ni marcas de Riot. Arte oficial de Riot solo en estos casos, que Sebastian decidió consultando a Riot (política "Legal Jibber Jabber"): imágenes de campeones desde Data Dragon e íconos de posición que él ponga en `iconos/`. No descargar íconos de Riot de fuentes no oficiales. El pie de página tiene que llevar el aviso que pide esa política.
- Sin imágenes ni diseños que imiten personajes de League of Legends.

## Idiomas
- Español (voseo argentino) por defecto e inglés. El sistema está al principio del último `<script>` de `index.html`: diccionario `EN` (clave = texto en español exacto) y `RULES` (regex para textos con variables).
- **Cada texto nuevo en la interfaz** necesita su traducción en `EN` (o una regla en `RULES`).
- Los textos que muestra la gente (títulos, mensajes, nicks) no se traducen.

## Funcionalidades existentes (no romperlas)
Perfiles con foto, mains y fondo del tablón elegido · ofertas con prioridades y filtros · "Repetir última oferta" · publicar rápido (horario "Ahora", que se oculta a las 3 hs si hay otros horarios; Solo/Dúo por defecto; título opcional que se arma solo) · tablón sin cuenta ("Ver el tablón" en la landing; usa la función `hnq_public_board`, que entrega solo datos recortados; chatear, publicar, reportar o bloquear piden entrar con Google) · el logo recarga la página y vuelve arriba · "Deshacer" en "Ya encontré" y "Bloquear" (la base permite reabrir hasta 2 minutos) · chats que nacen con el primer mensaje, agrupados por persona (con "Borrar chat") · avisos por mail (el primero trae el mensaje) · indicador "farol prendido" · mini tarjeta de perfil (Copiar Riot ID, OP.GG) · accesibilidad (teclado, Escape en ventanas, foco estable) · moderación (solo admins: reportes, baneos, desbaneo) · filtro de palabras ofensivas · límites anti-spam (5 ofertas activas, 15 por día, 20 mensajes/min) · donaciones (Mercado Pago y PayPal) · Google Analytics (`G-QFPJPHXCDJ`).

## Contacto público
hooknqueue@gmail.com
