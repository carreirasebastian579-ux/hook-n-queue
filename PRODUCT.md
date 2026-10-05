# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users
League of Legends players looking for someone to play with (duo, flex, normals, ARAM, Clash). LAS and LAN players are the priority audience, but every server matters (NA, EUW, OCE and the rest are supported). Spanish (Argentine voseo) is the default language; English is a full second language.

The job: find a compatible teammate on their own server, by position, rank, schedule, mic and vibe, and get into a game quickly.

## Product Purpose
Hook n' Queue (https://hooknqueue.com) is a board of offers per server. A player creates a profile (Riot ID, #tag, server), publishes what they're looking for, and others reach out through a built-in chat to swap nick/Discord and queue up. Success: a player goes from landing to an active conversation with a compatible duo in minutes, for free.

## Positioning
- **Offers with priorities:** positions, modes, ranks and schedules are ordered by preference, so others see at a glance what a player most wants to play, and fine-grained filters (last 24 h, rank, position, schedule, mic, vibe) narrow the board.
- **A cared-for community:** admin moderation (reports, bans), an offensive-word filter, and anti-spam limits keep the board healthy, unlike open Discord servers.

## Operating Context
Used mostly right before or between games, on desktop (often beside the game client) and on phones. Sign-in is with Google. Chats are grouped per person, born from an offer, and auto-deleted 24 h after the offer ends. Optional email notifications. Admins moderate from inside the app.

## Capabilities and Constraints
- Profiles with photo and mains; offers with priorities and filters; per-person chats with "Borrar chat"; email notices; online indicator; mini profile card (copy Riot ID, OP.GG link); admin moderation; offensive-word filter; limits (5 active offers, 15 per day, 20 messages/min); donations (Mercado Pago, PayPal); Google Analytics.
- Static site with no build step (plain HTML/CSS/JS, the app lives in `index.html`); Supabase backend (auth, database, Realtime, storage, Edge Function for email via Resend); Vercel hosting that deploys on every push to `main`.
- Real security lives in the database (RLS, triggers, limits), not the browser.
- Every new interface string needs an English translation.
- Free product; supported by donations.

## Brand Commitments
- Name **Hook n' Queue**; wordmark "HOOK N' QUEUE" with the apostrophe drawn as a fishing hook. The hook motif is part of the identity (landing hero, online indicator).
- Voice: Argentine Spanish voseo, short and direct, gamer-casual ("¿Armamos la partida?").
- Not affiliated with Riot Games; the disclaimer stays. No official Riot art, icons or images (unless the owner adds them to `iconos/` per Riot's policy), and nothing imitating League of Legends characters. Position icons and logos are original.
- Public contact: hooknqueue@gmail.com.

## Evidence on Hand
No user counts, testimonials, press or partnerships yet. Future work must not invent numbers, testimonials or social proof. Real assets: `og.png`, favicons, `apple-touch-icon.png`, the live product itself.

## Product Principles
1. From landing to a game, fast: every step should shorten the path to an active chat with a compatible duo.
2. Preferences are information: priority order is the product's language, so show it, never flatten it.
3. A healthy board beats a big board: moderation, filters and limits are features, not friction.
4. Local first, open to all: LAS/LAN and voseo lead, but no server or English speaker is a second-class user.
5. Honest by default: free, independent from Riot, no fabricated proof.
