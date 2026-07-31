# fukuii-brand — agent instructions

The canonical source for Fukuii's visual identity: logos, favicons, social/OG images and color
tokens. Every `fukuii-project` repo references these assets from here, so **paths in this repo are a
public contract** other repos depend on.

Fukuii itself is a multi-EVM execution client in Scala 3. **None of that code lives here** — this
repo holds brand assets only.

## There is no toolchain

**No build system, no package manager, no dependencies.** No `install`, `dev`, `build`, `lint`,
`format`, `typecheck` or `test` command exists — do not invent one, run one, or tell a user to run
one. There is no linter or formatter config either, so **match the surrounding file by hand**.

Three committed commands, all run by hand:

- `node scripts/build-tokens.mjs` — regenerates `tokens/colors.css` and `tokens/tailwind.css`
  from the token JSON. Node only, no dependencies. `--check` verifies without writing.
- `scripts/render-og.sh` — re-renders the social card. Needs Inkscape 1.x and ImageMagick.
- `scripts/build-favicon.sh` — rebuilds `favicon/favicon.ico` from the 16/32/48 PNGs beside it,
  and `favicon/maskable-512x512.png` from the hex logo. Needs ImageMagick. Derives from committed
  artwork; it does not regenerate the source PNGs.

Check `git ls-files` for a manifest, workflow or formatter config before trusting this. If one has
landed, this section has expired — and so has the dependency-surface reasoning under Security.

## Structure

| Path | What |
|---|---|
| `logo/` | Hex-badge logo and wordmarks, vector and raster |
| `logo/png/` | Raster exports of the logo at several sizes |
| `favicon/` | Favicon set, the maskable PWA icon, plus `site.webmanifest` |
| `social/` | Open Graph image, vector source and rendered raster |
| `tokens/` | Color tokens, one file per consuming format |
| `fonts/` | Vendored brand typefaces plus a scoped fontconfig |
| `scripts/` | Generators — the tokens, the social card, the favicon container |
| `LOGO-STYLE.md` | Logo usage guide and the sampled palette |
| `README.md` | Public-facing overview and the asset-consumption URL |

## Color tokens

**The source of truth is JSON. The CSS is generated.** This replaced a hand-maintained
mirror in which the same values lived in three files and drifted.

| File | Role |
|---|---|
| `primitive.json` | Raw palette and scales. No theme dependency |
| `semantic.dark.json` / `semantic.light.json` | Role tokens — `accent`, `bg-card`, `text-muted`. Swapping the file is what changes the theme |
| `component.json` | Recipes — which token each part of a button, card, panel, cell, badge or tag reads, per variant and state. **No density**: padding and sizing are each product's own call |
| `colors.css` | **GENERATED.** Custom properties, `--fk-*` palette + role tokens, `[data-theme="light"]`, and an OS-preference fallback |
| `tailwind.css` | **GENERATED.** Tailwind 4 `@theme` block, re-exporting via `var()`. Nothing here compiles it; consuming repos do |

Format is the [DTCG Design Tokens Format Module 2025.10](https://www.designtokens.org/tr/2025.10/),
stable since 2025-10-28. Note `color` is an object with `colorSpace` and `components`, and
`dimension` is `{value, unit}` admitting only `px` and `rem` — which is why `tracking` is
typed `number` and carries its unit in the description.

**To change a color:** edit the JSON, run `node scripts/build-tokens.mjs`, then update
`LOGO-STYLE.md`, `README.md` and `favicon/site.webmanifest` — those still hold hex literals
by hand. The webmanifest's `theme_color` is `--fk-green-3`, its `background_color` is `--fk-ink`.

**Never hand-edit `colors.css` or `tailwind.css`.** `node scripts/build-tokens.mjs --check`
fails if they are out of date with the JSON; run it before committing a token change.

Two things in the token set are load-bearing and must not be "cleaned up":

1. `semantic.light.json` overrides the **primitive** `color.green-3` to `#2d6b40`, not just
   the role token. `#50a060` fails contrast on light surfaces and several utilities read the
   raw token directly rather than through `{color.accent}`.
2. The generated `@media (prefers-color-scheme: light)` block must stay identical to the
   `[data-theme="light"]` block. Both come from the same JSON, so they cannot diverge —
   that is the point of generating them.

Artwork hardcodes palette values too — both wordmarks and `social/og-fukuii.svg`. Changing one of
those colors means editing the vector and re-rendering its raster. `logo/fukuii-hex-logo-traced.svg`
is auto-traced artwork holding no palette values; do not treat it as a color source.

## Code style

- 2-space indentation, no tabs, UTF-8, LF line endings.
- CSS custom properties are `--fk-<name>`; the JSON mirror is camelCase.
- Token files column-align their values. Preserve the alignment.
- Markdown uses tables for reference data.

## Branching

Work directly on `main`. Pushing is a separate decision from committing — never push unasked.

## Security

This repository is **public**.

- Never add a secret, key, credential, keystore or `.env` file. `.gitignore` is the gate; do not
  weaken it.
- **No dependency-update configuration, deliberately.** With no manifest, lockfile or CI workflow
  this repo has zero dependency surface, and a cooldown config would imply a control that is not
  operating. If it ever gains a workflow, manifest, lockfile, Dockerfile, devcontainer or git
  submodule, that reasoning expires and the config becomes warranted.

## Boundaries — ask before touching

1. **`LICENSE` is Apache-2.0 by deliberate choice.** Never change, replace or remove it, and never
   propose a different license. The question is legal, not technical.
2. **Never rename or move an asset.** Other repos and the project site consume these paths directly,
   pinned to `HEAD`. A rename silently breaks external consumers.
3. **Regenerate with the committed script, never by hand.** `social/og-fukuii.png` comes from
   `scripts/render-og.sh`, `favicon/favicon.ico` and `favicon/maskable-512x512.png` from
   `scripts/build-favicon.sh`. `logo/png/*` and
   the favicon PNGs have no generator: do not improvise a pipeline for those, and do not hand-edit
   a raster expecting it to stay consistent with its vector.
4. **This repo is upstream: brand → design-system → org builds.** The palette changes here first
   and the design system mirrors it. Never invert that — a downstream repo is not the source — and
   do not edit a downstream repo from here to match a change made in this one.
5. **`favicon/site.webmanifest` icon paths are root-relative** (`/android-chrome-192x192.png`), for
   deployment at a site root rather than this repo's layout. Do not "fix" them.
6. **Community-health files are inherited, not missing.** The `fukuii-project` org supplies
   `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` and issue and PR templates to every repo
   lacking its own. Do not add local copies.
7. **Do not add CI.** The org publishes a reusable `checks.yml` and `fukuii-template` ships a caller
   for it; this repo deliberately has none. Adding one creates a dependency surface (see Security).
