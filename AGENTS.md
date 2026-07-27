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

The one committed command is `scripts/render-og.sh`, which re-renders the social card and needs
Inkscape 1.x.

Check `git ls-files` for a manifest, workflow or formatter config before trusting this. If one has
landed, this section has expired — and so has the dependency-surface reasoning under Security.

## Structure

| Path | What |
|---|---|
| `logo/` | Hex-badge logo and wordmarks, vector and raster |
| `logo/png/` | Raster exports of the logo at several sizes |
| `favicon/` | Favicon set plus `site.webmanifest` |
| `social/` | Open Graph image, vector source and rendered raster |
| `tokens/` | Color tokens, one file per consuming format |
| `fonts/` | Vendored brand typefaces plus a scoped fontconfig |
| `scripts/` | `render-og.sh` — regenerates the social card |
| `LOGO-STYLE.md` | Logo usage guide and the sampled palette |
| `README.md` | Public-facing overview and the asset-consumption URL |

## Color tokens

`tokens/` carries the same palette once per consuming format, and **nothing generates one from
another**:

- `colors.css` — CSS custom properties, `--fk-*` prefix, role tokens, `[data-theme="light"]` block.
- `colors.json` — the same values as data, camelCase (`fkGreen3`), split `dark` / `light`.
- `tailwind.css` — Tailwind CSS 4 `@theme` block. **Nothing here compiles it**; consuming repos do.

**Change a color and you must change it in every file in `tokens/`, and in `LOGO-STYLE.md`.**

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
3. **Only `social/og-fukuii.png` has a committed generator** — regenerate it with
   `scripts/render-og.sh`. `logo/png/*` and the `favicon/*` set have none: do not improvise a
   pipeline, and do not hand-edit a raster expecting it to stay consistent with its vector.
4. **Where two files disagree about which is canonical, raise it — do not pick a side.** Known
   instance as of 2026-07-27: `tokens/colors.css` names `brand/design-system/tokens/colors.css`
   canonical, while `README.md` calls this repo canonical.
5. **`favicon/site.webmanifest` icon paths are root-relative** (`/android-chrome-192x192.png`), for
   deployment at a site root rather than this repo's layout. Do not "fix" them.
6. **Community-health files are inherited, not missing.** The `fukuii-project` org supplies
   `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` and issue and PR templates to every repo
   lacking its own. Do not add local copies.
7. **Do not add CI.** The org publishes a reusable `checks.yml` and `fukuii-template` ships a caller
   for it; this repo deliberately has none. Adding one creates a dependency surface (see Security).
