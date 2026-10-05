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
- **Antes de pushear**, mostrale a Sebastian qué cambió y pedile confirmación. Cada push a `main` sale publicado al instante.
- Probá en ancho de compu (≥1500px, con columnas laterales) y de celular (390px). En celular no tiene que haber scroll horizontal.

## Identidad visual (respetarla)
El sistema completo está en `DESIGN.md` (estilo "El Anzuelo Espectral"); `PRODUCT.md` tiene el contexto del producto. Leelos antes de cualquier cambio visual.
- Nombre: **Hook n' Queue**. Logo: wordmark "HOOK N' QUEUE" con el apóstrofe en forma de anzuelo.
- **Landing**: **Verde Espectral** (`#45E6A6`) sobre casi negro (fondo `#060F0D`), con el anzuelo que se clava en el título y arrastra al scrollear. Es el único lugar donde algo brilla (glows, partículas, degradés).
- **Adentro de la app** (`html.in-app`): gris grafito (`#0D0F0F`) y **Verde Muelle** (`#3DBF8E`). Cálida y gamer, pero **sin brillos**: la personalidad sale del anzuelo en movimiento (indicador "en línea", anzuelo que deja caer ofertas, anzuelo que se balancea), nunca de glows ni degradés.
- Siempre usar las variables CSS (`--accent`, `--surface`, `--ink`…), no colores fijos, así cada componente funciona en la landing y en la app.
- Plano por capas: sin sombras en tarjetas, paneles ni botones; solo en lo que flota (menús, chat, ventanas).
- Íconos de posiciones y logos son **propios**. No usar arte, íconos ni imágenes oficiales de Riot Games (salvo que Sebastian los ponga en `iconos/` siguiendo la política de Riot).
- Sin imágenes ni diseños que imiten personajes de League of Legends.

## Idiomas
- Español (voseo argentino) por defecto e inglés. El sistema está al principio del último `<script>` de `index.html`: diccionario `EN` (clave = texto en español exacto) y `RULES` (regex para textos con variables).
- **Cada texto nuevo en la interfaz** necesita su traducción en `EN` (o una regla en `RULES`).
- Los textos que muestra la gente (títulos, mensajes, nicks) no se traducen.

## Funcionalidades existentes (no romperlas)
Perfiles con foto y mains · ofertas con prioridades y filtros · chats agrupados por persona (con "Borrar chat") · avisos por mail · indicador "en línea" con anzuelo · mini tarjeta de perfil (Copiar Riot ID, OP.GG) · moderación (solo admins: reportes, baneos, desbaneo) · filtro de palabras ofensivas · límites anti-spam (5 ofertas activas, 15 por día, 20 mensajes/min) · donaciones (Mercado Pago y PayPal) · Google Analytics (`G-QFPJPHXCDJ`).

## Contacto público
hooknqueue@gmail.com
