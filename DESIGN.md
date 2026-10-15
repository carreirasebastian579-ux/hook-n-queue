---
name: Hook n' Queue
description: Find someone to play League of Legends with. A spectral hook cast on the landing, a calm dock inside the app.
colors:
  verde-espectral: "#45E6A6"
  bruma-menta: "#A6F7D2"
  abismo: "#060F0D"
  fondo-hondo: "#0C1A17"
  fondo-alga: "#13251F"
  linea-alga: "#1C332C"
  tinta-espuma: "#E2F4EE"
  musgo-apagado: "#7C9A90"
  musgo-claro: "#A9CFC2"
  tinta-verde-noche: "#03140D"
  verde-muelle: "#3DBF8E"
  menta-preferida: "#7FD3B2"
  grafito-muelle: "#0D0F0F"
  superficie-muelle: "#141817"
  superficie-muelle-2: "#1B201F"
  linea-muelle: "#242A29"
  linea-campo: "#5E6866"
  tinta-muelle: "#E4EAE8"
  gris-muelle: "#86918E"
  tinta-verde-muelle: "#06120D"
  coral-alerta: "#F26B6B"
  celeste-mic: "#9CC4F4"
  rol-top: "#F2A580"
  rol-jungla: "#80D4B4"
  rol-mid: "#9CC4F4"
  rol-adc: "#F4A3A3"
  rol-support: "#C9B6F2"
  rol-fill: "#C5CFCC"
  naranja-intento: "#F2A580"
typography:
  display:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "clamp(2.6rem, 6.4vw, 4.6rem)"
    fontWeight: 800
    lineHeight: 1.02
    letterSpacing: "-0.035em"
  headline:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "clamp(1.9rem, 4vw, 2.8rem)"
    fontWeight: 800
    lineHeight: 1.1
    letterSpacing: "-0.03em"
  title:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "1.6rem"
    fontWeight: 800
    lineHeight: 1.2
    letterSpacing: "-0.02em"
  body:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.45
  label:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "0.7rem"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "0.09em"
  eyebrow:
    fontFamily: "Inter, system-ui, -apple-system, 'Segoe UI', sans-serif"
    fontSize: "0.78rem"
    fontWeight: 700
    lineHeight: 1.3
    letterSpacing: "0.14em"
rounded:
  xs: "4px"
  sm: "8px"
  md: "10px"
  lg: "12px"
  xl: "14px"
  2xl: "16px"
  3xl: "18px"
  pill: "999px"
spacing:
  2xs: "4px"
  xs: "6px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  xl: "18px"
  2xl: "24px"
  3xl: "28px"
components:
  button-primary:
    backgroundColor: "{colors.verde-muelle}"
    textColor: "{colors.tinta-verde-muelle}"
    rounded: "{rounded.sm}"
    padding: "9px 16px"
  button-primary-landing:
    backgroundColor: "{colors.verde-espectral}"
    textColor: "{colors.tinta-verde-noche}"
    rounded: "{rounded.md}"
    padding: "13px 22px"
  button-secondary:
    backgroundColor: "{colors.superficie-muelle-2}"
    textColor: "{colors.tinta-muelle}"
    rounded: "{rounded.sm}"
    padding: "9px 16px"
  button-danger:
    backgroundColor: "{colors.coral-alerta}"
    textColor: "#1A0606"
    rounded: "{rounded.sm}"
    padding: "9px 16px"
  input:
    backgroundColor: "{colors.grafito-muelle}"
    textColor: "{colors.tinta-muelle}"
    rounded: "{rounded.sm}"
    padding: "11px 12px"
  pick-chip:
    backgroundColor: "{colors.grafito-muelle}"
    textColor: "{colors.gris-muelle}"
    rounded: "{rounded.sm}"
    padding: "7px 12px"
  server-tab:
    backgroundColor: "transparent"
    textColor: "{colors.gris-muelle}"
    rounded: "{rounded.sm}"
    padding: "7px 14px"
  tag-pill:
    backgroundColor: "{colors.superficie-muelle-2}"
    textColor: "{colors.tinta-muelle}"
    rounded: "{rounded.pill}"
    padding: "2px 9px 2px 7px"
  panel:
    backgroundColor: "{colors.superficie-muelle}"
    rounded: "{rounded.lg}"
  modal-card:
    backgroundColor: "{colors.superficie-muelle}"
    rounded: "{rounded.2xl}"
    padding: "28px"
  side-card:
    backgroundColor: "{colors.superficie-muelle}"
    rounded: "{rounded.xl}"
    padding: "14px"
  chat-bubble-me:
    backgroundColor: "{colors.verde-muelle}"
    textColor: "{colors.tinta-verde-muelle}"
    rounded: "{rounded.xl}"
    padding: "8px 12px"
  chat-bubble-them:
    backgroundColor: "{colors.superficie-muelle-2}"
    textColor: "{colors.tinta-muelle}"
    rounded: "{rounded.xl}"
    padding: "8px 12px"
---

# Design System: Hook n' Queue

## Overview

**Creative North Star: "El Anzuelo Espectral"**

The whole system is one cast of a fishing line. The landing is the cast itself: a spectral green hook flies out of near-black water, bites into the headline and drags the page as you scroll, trailing a glowing chain. That is the only place where the system glows. Once you are inside the app (`html.in-app`), you are standing on the dock waiting for a bite: the same green settles into a calmer, desaturated tone, the background turns to a neutral graphite, and light gives way to clear layering. A night-fishing lantern hangs over the hero and is the only light source: the page sits in a soft penumbra that falls off away from the lantern, with spectral smoke and a few embers rising from it.

Inside, the app should feel warm and gamer, not clinical: the hook keeps appearing as a living signature (the online-indicator hook with its sonar ring, the hook that drops a newly published offer into the board, the hanging hook in empty states), priority numbers pop in, and rows land with a little bounce. That warmth comes from motion and the hook motif, never from glow, neon or gradients. Controls are tactile and confident: comfortable tap targets, soft 8px corners, clear pressed states, and nothing that needs precision aiming on a phone.

Density is moderate: the offer board is a real data table on desktop (8 columns, up to three columns of layout at ≥1500px) that folds into stacked cards on phones. Three families, each with one job: Inter for body text and data, Barlow Condensed 800 for the biggest titles (landing headlines, the server name in the dock), and Saira Condensed 600/700 for labels, buttons, tabs and ranks.

**Key Characteristics:**
- Two registers of the same green: Verde Espectral (landing, can glow) and Verde Muelle (app, never glows).
- Near-black, green-tinted water on the landing; neutral graphite inside the app.
- The hook is the signature motif and appears in motion, never as static decoration.
- Flat tonal layering; shadows only for things that float.
- One family (Inter), voiced through heavy weights and negative tracking.
- Tactile, generously tappable controls with clear `aria-pressed` states.

## Colors

A two-register palette: one spectral green at full strength on a deep green-black for the landing, and its quieter twin on graphite for the app, plus a few muted semantic tints for tags.

The CSS custom properties (`--bg`, `--surface`, `--surface2`, `--line`, `--ink`, `--muted`, `--accent`, `--accent-ink`, `--accent-soft`) are defined twice: once on `:root` for the landing, and again on `html.in-app` for the app. Always style with the variables, so a component works in both registers automatically.

### Primary
- **Verde Espectral** (`--accent` on the landing): the hook, the chain, the primary CTA, the scroll-cue dot, the step rail fill and the highlighted server names on the landing. The only color allowed to glow (`box-shadow` / `drop-shadow` halos with `rgba(69,230,166,.25–.9)`).
- **Verde Muelle** (`--accent` in the app): primary buttons, the user's own chat bubbles, selected picks, unread counters, the online ring, the first-priority number. Never glows.
- **Menta Preferida**: the readable text tone for "wanted" positions, role chips and the "Tuya" tag inside the app, where Verde Muelle on a tinted background would be too dark.
- **Bruma Menta**: the light core of landing effects (the lantern flame, embers, chain highlights, impact ring). Landing only.

### Neutral
- **Abismo** (`--bg`, landing): the water. Page background, `theme-color`, the base of the hero's radial gradient (`#0B2A20` at the center).
- **Fondo Hondo** / **Fondo Alga** (`--surface` / `--surface2`, landing): raised panels, marquee server cards, demo viz boxes, the phone mock frame.
- **Línea Alga** (`--line`, landing): hairline borders and dividers.
- **Tinta Espuma** (`--ink`, landing): primary text. **Musgo Apagado** (`--muted`): secondary text. **Musgo Claro**: the hero subtitle, a slightly brighter muted for long landing copy.
- **Grafito Muelle** (`--bg`, app): page and header background, input fill, inset areas (filter panel, offer detail).
- **Superficie Muelle** / **Superficie Muelle 2** (`--surface` / `--surface2`, app): panels and cards / secondary buttons, hovers, pressed segment, received chat bubbles.
- **Línea Muelle** (`--line`, app): borders of panels, cards and row dividers.
- **Línea Campo** (`--field-line`): borders of inputs, selects and the Riot tag box, so form fields reach 3:1 against the background in both registers.
- **Tinta Muelle** (`--ink`, app) and **Gris Muelle** (`--muted`, app): primary and secondary text.
- **Tinta Verde Noche** / **Tinta Verde Muelle** (`--accent-ink`): text on green fills in each register.

### Semantic tints (tags and states)
- **Coral Alerta**: errors, "Borrar", ban and report actions, the "avoid" champion chip (`rgba(242,107,107,.1)` fill).
- **Celeste Mic**: the "con micro" tag on `rgba(110,168,240,.13)`.
- **Naranja Intento**: the "tryhard" tag on `rgba(240,130,80,.14)`.
- The "chill" tag uses Menta Preferida-family `#80D4B4` on `rgba(61,191,142,.13)`.
- Third-party payment buttons keep their own brand colors (Mercado Pago `#009EE3`, PayPal `#FFC439`) and appear only in the donation card.

### Named Rules
**The Two Greens Rule.** Verde Espectral lives on the landing and may glow. Verde Muelle lives in the app and never glows. Never put a glow, neon shadow or green gradient inside `html.in-app`.

**The Variable-Only Rule.** Components read `--accent`, `--surface`, `--ink` and friends, never hard-coded greens or grays, so the same markup renders correctly in both registers.

**The Signal Rule.** Inside the app, green marks what is actionable, selected, yours or online. If it is none of those, it is gray.

## Typography

**Display Font:** Inter (with system-ui, -apple-system, Segoe UI, sans-serif)
**Body Font:** Inter (same stack)
**Display Fonts (app and labels):** Barlow Condensed 800 only for the server title in the dock ("LAS"); Saira Condensed 600/700 for everything else that is a label or sign: small uppercase labels above data (.k: 0.74rem, 0.14em tracking), buttons inside the app (uppercase, 0.06em), ranks, table headers, the server list and tabs.

**Character:** One family doing everything. The brand voice comes from weight 800 with tight negative tracking on headings, against plain 400/500 text at a compact 14px base.

### Hierarchy
- **Display** (800, `clamp(2.6rem, 6.4vw, 4.6rem)`, 1.02, -0.035em, max 11ch on phones; `clamp(3.4rem, 6.6vw, 6rem)`, 0.96, -0.04em, max 9.5ch above 820px): the landing hero headline only, the one the hook bites into. Its last word ("acá.") is set in the accent on desktop.
- **Closing** (800, `clamp(2.6rem, 7vw, 5.4rem)`, 0.98, -0.04em, max 9ch): "¿Armamos la partida?" in the final CTA section.
- **Headline** (800, `clamp(1.9rem, 4vw, 2.8rem)`, 1.1, -0.03em): landing section titles ("Cómo funciona", "Un tablón para cada server"). Feature titles step down to `clamp(1.5rem, 3vw, 2rem)`.
- **Title** (800, 1.6rem, -0.02em): the app's board title; modal titles use 1.4rem. Panel headings drop to 700 at 1rem. On phones the board title shrinks to 1.3rem.
- **Body** (400, 14px, 1.45): all app text. Landing paragraphs run larger (1.02–1.12rem, line-height 1.55, max 40–46ch).
- **Label** (600, 0.7rem, 0.09em, uppercase): side-card headings and detail keys (0.72rem, 0.06em). Form labels are sentence case, 500, 0.82rem, muted.
- **Eyebrow** (700, 0.78rem, 0.14em, uppercase, accent color): small kicker above landing headlines.
- **Wordmark**: "HOOK N' QUEUE", 800, 0.04em tracking, with the apostrophe drawn as a hook SVG in the accent color.

### Named Rules
**The Heavy Voice Rule.** Headings are heavy (700–800); never use a light or thin weight for a heading. Stick to the three families (Inter, Barlow Condensed, Saira Condensed) and never add a fourth.

**The 16px Input Rule.** On phones every input and select is at least 16px so iOS does not zoom on focus.

## Layout

A centered `.wrap` container (max 1200px, 16px side gutters), widened to 1640px at ≥1500px where the app becomes a three-column grid: left rail of servers (232px), the board, and a right rail with the profile card and people (272px), both rails sticky at 76px from the top.

The offer board is an 8-column grid on desktop (player, positions, rank, mode, schedule, title, age, actions; 12px gaps, 18px row padding, 68px minimum row height). At ≤900px the column header disappears and each offer becomes a stacked card using named grid areas (player/age, title, positions, rank/mode, full-width chat button). At ≤640px the header compresses (labels hide, icons stay), stats become a three-up grid, and the chat drawer goes full screen.

The landing is a long scroll story: a 260svh pinned hero, a "how it works" section with a sticky phone mock beside a progress rail (phone hidden ≤900px), an infinite server marquee, alternating two-column feature rows (single column ≤820px), and a final CTA where the primary button sits still right under a swinging hook (the button never moves, so it stays easy to tap). Above 1100px the hero shows the lantern on the right with an example offer hanging from its base by a short iron chain; the offer fades out as soon as the scroll starts, the lantern keeps lighting, and the usual hook then bites the headline. On phones the lantern hangs top-center without the offer. Between 821px and 1100px the lantern is hidden.

Spacing runs on small steps (4, 6, 8, 12, 16, 18, 24, 28px) inside the app; the landing uses large section padding (90–150px vertical). No horizontal page scroll at any width (`overflow-x: clip` on `html, body`); horizontally scrolling rows (server tabs, segmented filters) hide their scrollbars.

## Elevation & Depth

Flat by layers. Depth comes from stepping through `--bg` → `--surface` → `--surface2`, with 1px `--line` borders defining edges. Surfaces at rest have no shadow. Shadows appear only on things that genuinely float above the page: the chat drawer, dropdown menus, the champion suggestion list, the mini profile popover, and modal overlays (which also blur the page behind).

### Shadow Vocabulary
- **Drawer** (`box-shadow: -20px 0 40px rgba(0,0,0,.35)`): the chat drawer sliding in from the right.
- **Menu** (`box-shadow: 0 16px 40px rgba(0,0,0,.45)`): user menu and similar dropdowns; suggestion lists use `0 12px 30px rgba(0,0,0,.4)`.
- **Popover** (`box-shadow: 0 24px 60px rgba(0,0,0,.55)`): the mini profile card.
- **Overlay scrim** (`background: rgba(0,0,0,.6); backdrop-filter: blur(4px)`): behind modals.
- **Spectral glow** (`box-shadow: 0 0 0 1px rgba(69,230,166,.4), 0 8px 30px rgba(69,230,166,.25)`): landing primary buttons only; removed inside the app.

### Named Rules
**The Flat Dock Rule.** In the app, a surface earns a shadow only if it floats over other content. Cards, panels, rows and buttons stay flat; hierarchy comes from tone and borders.

## Shapes

Soft, friendly rectangles on the landing; inside the app corners are nearly square (see App shape language, `--rad` 6px). On the landing, controls (buttons, inputs, picks, server tabs, icon buttons) use 8px corners; small inner pieces drop to 4–6px (tags, segmented-control buttons). Containers grow rounder with size: stats and big buttons 10px, panels and offer details 12px, side cards and chat bubbles 14px, modals and the hero board 16px, landing demo boxes 18px. Counters, tags, toasts, the chat compose field and champion chips are full pills. Avatars and online indicators are circles.

Chat bubbles are 14px with one tucked corner (4px) on the speaker's side. Position icons sit in 32px rounded-square tiles. The hook and its hexagonal chain links are the only non-rectangular shapes, and they belong to the brand, not to general UI.

## Components

### Buttons
Tactile and confident: a solid fill, a clear label, no outline-only primaries.
- **Shape:** gently rounded (8px); the landing's big CTA is 10px with 13×22px padding.
- **Primary:** accent fill with dark green ink, weight 600, 9×16px padding.
- **Secondary:** `--surface2` fill, `--ink` text, weight 500.
- **Danger:** Coral Alerta fill with near-black red ink, for destructive moderation actions.
- **Small:** 6×12px, 0.8rem.
- **Disabled:** 45% opacity, `not-allowed` cursor.
- **Focus:** global 2px accent outline at 2px offset (`:focus-visible`).
- **Landing only:** primaries carry the spectral glow.

### Chips (picks)
- **Style:** 8px corners, `--bg` fill, 1px `--line` border, muted text, 18px icon, 7×12px padding.
- **Selected (`aria-pressed="true"`):** accent border, `--accent-soft` fill, accent text, plus a small round accent badge showing the priority number (1, 2, 3…), which pops in with a springy scale.
- **Tags:** pill-shaped, 0.73rem, 500, a 12px icon, in semantic tints (schedule gray, mic blue, no-mic muted, tryhard orange, chill mint).
- **Champion chips:** pills with a 20px colored monogram circle; "like" in mint, "avoid" in coral.

### Cards / Containers
- **Panel (the board):** `--surface`, 12px corners, no border, rows separated by `--line`; the header row sits on `--bg`.
- **Modal card:** `--surface`, 16px corners, 1px `--line` border, 28px padding, max 420px (540px wide variant).
- **Side cards:** `--surface`, 14px corners, 1px border, 14px padding, uppercase label heading.
- **Offer detail:** expands inside the row on `--bg` with a 12px corner and border, fading in over 0.25s.
- **Shadow strategy:** none at rest (see Elevation).

### Inputs / Fields
- **Style:** `--bg` fill, 1px `--field-line` border, 8px corners, 11×12px padding, full width.
- **Focus:** border turns accent; no glow.
- **Label:** above the field, 0.82rem, 500, muted.
- **Error:** Coral Alerta text, 0.82rem, under the field, with reserved height so the layout does not jump.
- **Riot tag box:** a fixed 104px field with a muted "#" prefix, focusing as one unit.

### Navigation
- **App header:** sticky, 56px, `--bg` in the app, bottom hairline. Wordmark at left; chats button (with unread pill), language switch and user menu at right. Below 640px, text labels hide and icons remain.
- **Server tabs:** horizontally scrolling row of 8px outline tabs; the active one gets an accent border on `--surface2` in the app (solid accent fill on the landing). A small dot marks the user's home server. At ≥1500px they move into the left rail as a list with counts.
- **Segmented filters:** a `--bg` track with 3px padding; the active segment fills with `--surface2`.
- **Landing nav:** fixed and transparent over the hero, turning to a blurred translucent bar once scrolled.

### Chat drawer
A 400px right-hand drawer (full screen on phones). Messages are 14px bubbles at max 78% width; yours are accent-filled on the right, theirs `--surface2` on the left. System notes are centered and muted; an ended-offer notice is a full-width accent-soft banner. Conversations from different offers are separated by a hairline divider with a pill label. The compose field is a pill.

### Online lantern indicator ("farol prendido")
Someone online "has their lantern lit". A small fishing lantern (Menta Preferida, no glow, no pulse) sits in a 17×20px rounded tab at the bottom-right of the avatar. Copy follows the metaphor: "farol prendido" next to the nick, the filter "Farol prendido", the right rail "Con el farol prendido en LAS". Screen readers still hear "en línea".

### The dock (board header)
The board opens with the server as a dock sign, inspired by LoL Esports' editorial schedule: a fixed, blurred and darkened Thresh splash (Data Dragon "centered" image, blur 5px, brightness .7) behind a left-to-right dark gradient; the label SERVER, the code in Barlow Condensed 800 (`clamp(4rem, 7vw, 6.2rem)`), the server name plus "el tablón de tu server", and three labeled values: OFERTAS ACTIVAS (MOSTRANDO "X de Y" when filtering), FAROL PRENDIDO, NUEVAS HOY. "Publicar oferta" sits beside it, full width on phones. The champion name is credited small at the top right.

### App shape language
Corners are nearly square inside the app (--rad 6px for panels, side cards, details; 4px for tags; modals 10px). The active server in the side list is marked with a 3px accent stripe on the left; tabs (servers under 1500px and the date filter) use a 2px accent underline instead of filled pills. The user's own offer row gets a 3px accent stripe on its left edge. The profile card shows the splash of the user's main #1 as a short faded banner above the avatar (plain surface when there are no mains).

### Position colors
Each role has its own color, applied to its icon everywhere (rows, filters, offer form, detail): see the rol-* colors in the frontmatter. Official Riot position icons (PNGs in `iconos/`, from Riot's ranked-positions.zip) are shown as a silhouette in polished silver (a vertical gradient from #F2F5F4 to #AEB8B5 through a CSS mask), never with their original bronze-ish tint; Fill keeps the house icon. In rows, "Juega" tiles show the colored icon on a faint tint of its color; "Busca" tiles add a stronger tint and a 1px inset outline in the same color. Priority 2+ stays smaller and faded.

### Lantern (signature, landing)
A night-fishing lantern drawn from scratch (iron cage and cap in Musgo Apagado, never glowing; glass and flicking flame in Verde Espectral, Bruma Menta and a near-white core). It hangs from an iron chain, sways ±2.2° over 6s, and positions the light: a screen-blended spectral pool plus a penumbra vignette centered on it (measured in JS), spectral smoke drifting from it, and ~10 embers rising from it. Text and buttons always sit above the penumbra so they stay fully legible. It is a fisherman's lantern: never a hooded figure, scythe, souls or anything evoking a League of Legends champion.

### Hook drop (signature)
When a new offer appears, a hook on its chain drops from above, the row falls in with a small overshoot (`rowIn`, 1.5s) and briefly tints green, then the hook is pulled back up. Empty states show the hook hanging and gently swinging (`swing`, 3.4s, ±7°).

## Do's and Don'ts

### Do:
- **Do** style every component with the CSS variables so it works under both `:root` (landing) and `html.in-app` (app).
- **Do** keep glow and light effects on the landing, and make them come from a source (the lantern, the hook): penumbra away from the lantern, embers only near it, never particles scattered across the screen; inside the app, express warmth through the hook motif and motion (pop, drop, swing, sonar ring).
- **Do** mark selections with `aria-pressed` and show priority order with numbered accent badges; order is information.
- **Do** keep tap targets comfortable (at least 32–34px icon buttons, full-width chat button on phones) and inputs at 16px on phones.
- **Do** wrap every animation in a `prefers-reduced-motion: reduce` fallback that shows the final state.
- **Do** check both ≥1500px (three-column layout) and 390px (no horizontal scroll).

### Don't:
- **Don't** put glows, neon shadows or green gradients inside the app (`html.in-app`); the landing is the only place things shine.
- **Don't** add shadows to resting cards, panels, rows or buttons in the app; only floating layers get them.
- **Don't** add a fourth typeface or use light weights for headings.
- **Don't** use Riot logos or trademarks, Riot art from unofficial sources, or anything imitating League of Legends characters. Allowed official art (owner's decision under Riot's "Legal Jibber Jabber" policy): champion images from Data Dragon and the official position icons in `iconos/`. Logos are original, and the footer keeps Riot's notice.
- **Don't** hard-code Verde Espectral (`#45E6A6`) inside the app or Verde Muelle on the landing.
- **Don't** use the hook or chain as static clip-art; it appears as a living element (biting, dropping, swinging, pulsing).
