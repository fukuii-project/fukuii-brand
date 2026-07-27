<!--
  SELF-CONTAINED BY CHOICE — do not thin this into a pointer at AGENTS.md.

  This repository is public, so its github.com surfaces are in play for
  anyone browsing it, and github.com Chat reads this file but does NOT read
  AGENTS.md. The same holds for VS Code code review, Visual Studio Chat and
  code review, and Eclipse and Xcode Chat. On those, this file is the only
  instruction the model sees, so a thin delta would leave it with nothing.
  Eclipse code review reads no custom instructions of any kind, so nothing
  written here reaches it. JetBrains is deliberately not listed: the support
  matrix says its Chat surface takes no agent instructions, but GitHub's own
  changelog of 2026-03-11 announced AGENTS.md and CLAUDE.md support in
  JetBrains IDEs as generally available, and the matrix has not caught up.

  The cost is duplication with AGENTS.md, paid deliberately: when either file
  changes, change both. They must not contradict each other.

  Support differs per surface and changes often. Re-check before assuming:
  https://docs.github.com/en/copilot/reference/custom-instructions-support
-->

# fukuii-brand

The canonical source for Fukuii's visual identity: logos, favicons, social/OG images and color
tokens. Every `fukuii-project` repo references these assets from here, so **paths in this repo are a
public contract** other repos depend on.

Fukuii itself is a multi-EVM execution client in Scala 3. **None of that code lives here** — this
repo holds brand assets only.

## There is no toolchain

**No build system, no package manager, no dependencies.** No `install`, `dev`, `build`, `lint`,
`format`, `typecheck` or `test` command exists — never invent one and never suggest running one.
There is no linter or formatter config either, so **match the surrounding file by hand**.

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
  this repo has zero dependency surface. If it ever gains a workflow, manifest, lockfile,
  Dockerfile, devcontainer or git submodule, that changes.

## Do not

1. **Change, replace or remove `LICENSE`.** It is Apache-2.0 by deliberate choice. Never propose a
   different license — the question is legal, not technical.
2. **Rename or move an asset.** Other repos and the project site consume these paths directly,
   pinned to `HEAD`. A rename silently breaks external consumers.
3. **Improvise an asset pipeline.** Raster assets are derived from vector sources with no committed
   generator. Do not hand-edit a raster expecting it to stay consistent with its vector.
4. **Pick a side when two files disagree about which is canonical — raise it instead.** Known
   instance as of 2026-07-27: `tokens/colors.css` names `brand/design-system/tokens/colors.css`
   canonical, while `README.md` calls this repo canonical.
5. **"Fix" the icon paths in `favicon/site.webmanifest`.** They are root-relative
   (`/android-chrome-192x192.png`) for deployment at a site root, not this repo's layout.
6. **Add `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` or issue and PR templates.** The
   `fukuii-project` org supplies all of them to every repo lacking its own.
7. **Add CI.** The org publishes a reusable `checks.yml` and `fukuii-template` ships a caller for
   it; this repo deliberately has none. Adding one creates a dependency surface (see Security).

## Response style

- No pleasantries. Code first, explanation only if asked.
- Concise bullets over paragraphs.
- Do not repeat the prompt back.
