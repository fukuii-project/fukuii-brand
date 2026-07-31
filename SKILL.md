---
name: fukuii-design
description: Use this skill to generate well-branded interfaces and assets for Fukuii (the multi-EVM execution client in Scala 3), either for production or throwaway prototypes/mocks/etc. Contains the design tokens, brand guidelines, colors, type, fonts, logo assets, and a worked web reference implementation.
user-invocable: true
---

Read `README.md` and `LOGO-STYLE.md`, then explore. If the user invokes this skill
without other guidance, ask what they want to build, ask some questions, and act as an
expert designer producing HTML artifacts _or_ production code as the need dictates.

## How this repo is meant to be used

**`tokens/` is data and is the source of truth. `reference/` is a worked example you
copy from, never depend on.**

Fukuii ships five product surfaces — an Astro site, React/Tailwind and
React/styled-components apps, a Qt/QML desktop GUI, and a Scala CLI. They use five
different styling mechanisms and two of them cannot read a stylesheet at all. So what
is shared is token *values* and design *intent*; each surface writes its own
implementation. There was a shared component package; it was deleted. Do not rebuild
one.

| Path | What |
|---|---|
| `tokens/*.json` | DTCG 2025.10. `primitive` → `semantic.{dark,light}` → `component` |
| `tokens/*.css` | **Generated** from the JSON by `scripts/build-tokens.mjs`. Never hand-edit |
| `reference/web/` | CSS implementation — 73 utility classes + 13 guideline pages. Copy it |
| `logo/ favicon/ social/ fonts/` | Brand assets. Consume by path; never rename or move |

`tokens/component.json` is the layer worth reading before designing anything: it says
which token each part of a button, card, panel, cell, badge or tag reads, per variant
and state. It carries **no density** — padding and sizing are each product's call.

## Quick orientation

- **Identity:** institutional-grade infrastructure — *"built to finance's standard."*
  Serious, precise, institutional, terminal-adjacent. Forest green + old gold on a
  near-black, green-tinted foundation.
- **Color:** primary accent green `#50a060` (sampled from the logo), secondary gold
  `#d6b56b`, rare pink worm accent `#c06060`. Surfaces `#0f130d` / `#1a1f16`. High
  contrast. Dark is the default; light is a parity theme, selected by
  `[data-theme="light"]` or inherited from the OS preference.
- **Light mode darkens the primary green** to `#2d6b40`. `#50a060` fails contrast on
  light surfaces. This is a real design decision, not an implementation detail —
  honor it on every surface.
- **Type:** DM Sans (display + prose, up to 800 for hero/CTA), JetBrains Mono
  (technical — chain IDs, versions, ports, labels, badges). Mono is part of the brand,
  used sparingly and deliberately.
- **Signature motif:** the **cell grid** — bordered grid, sharp corners,
  hairline shared edges, mono labels and CTA bars. Reach for it before a rounded card
  when content is structural. Plus paper-grain noise, a green/gold aurora hero, and
  mono status pills (Primary / In Progress / Planned).
- **Sharp corners are a decision.** Buttons and cells are `radius.none` on purpose.
- **Focus is non-negotiable.** Every interactive element on every surface gets a
  visible indicator: 2px `#50a060` at 2px offset, on keyboard focus.
- **Copy voice:** sentence case, short declarative headlines (often ending in a
  period), second person, concrete technical specifics, finance-serious, honest about
  alpha status, no emoji, no exclamation marks.

## Iconography

- **System.** Feather-style line icons (24×24, 2px stroke, round caps) for UI
  affordances — arrow, document, sun/moon, hamburger — plus **brand/tech glyphs**
  (filled, `currentColor`) for platform and stack pills: GitHub, Linux, Apple/macOS,
  Windows, Docker, Scala, Pekko, JVM, RocksDB.
- **Color.** Icons inherit `currentColor` — muted by default, accent green on
  emphasis or hover. Do not hardcode a fill.
- **Substitution.** Icons are hand-embedded SVG paths; there is **no icon font,
  sprite, or packaged icon set**. For UI icons beyond the set you have, use
  [Lucide](https://lucide.dev) (Feather-compatible, 2px stroke); for tech and brand
  logos use [Simple Icons](https://simpleicons.org). Both are substitutions, not
  shipped dependencies.
- **Emoji and unicode symbols are not iconography.** Avoid them, consistent with the
  no-emoji copy voice.
- **Mascot: use the PNG.** `logo/fukuii-hex-logo.png` is the master.
  `logo/fukuii-hex-logo.svg` is an SVG wrapper around an embedded base64 PNG at
  ~355 KB — the same raster, larger, with no vector benefit.
  `logo/fukuii-hex-logo-traced.svg` is the genuine vector, auto-traced and carrying no
  palette values; treat it as artwork, never as a color source.
