# fukuii-brand — agent instructions

The canonical source for Fukuii's visual identity: logos, favicons, social/OG images and color
tokens. `README.md` states that every `fukuii-project` repo references these assets from here, so
paths in this repo are a public contract other repos depend on.

Fukuii itself is a "Multi-EVM execution client in Scala 3" (`favicon/site.webmanifest`). **None of
that code lives here.** This repo holds brand assets only.

## There is no toolchain here — read this before running anything

This repo has **no build system, no package manager and no dependencies**. That is a fact about the
repo, verified against the whole tree, not an omission waiting to be filled in — as of HEAD; if a
script is ever committed, replace this section with the real commands:

- **No manifest and no lockfile of any kind.** No `package.json`, no `*.toml`, no `Makefile`, no
  `justfile`, no `Taskfile`, no `go.mod`, no `Cargo.toml`, no `pyproject.toml`, no `build.sbt`, no
  `Dockerfile`.
- **No `install`, `dev`, `build`, `lint`, `format`, `typecheck` or `test` command exists.** Do not
  invent one, do not run one, and do not tell a user to run one. There is nothing to run.
- **No CI.** This repo has no `.github/workflows/`.
- **No linter and no formatter config at any level** — no `.editorconfig`, `.prettierrc`,
  `.eslintrc` or `.stylelintrc` anywhere in the tree.

The consequence is the important part: **match the existing style by hand.** No gate will catch a
formatting mistake here, because there is no gate.

## Contents

31 tracked files: 17 PNG, 6 SVG, 2 Markdown, 2 CSS, 1 JSON, 1 `.webmanifest`, 1 `.ico`, 1 `LICENSE`.

| Path | What |
|---|---|
| `logo/` | Hex-badge logo (PNG, SVG, traced SVG), light/dark wordmarks |
| `logo/png/` | Sized raster exports — 64, 128, 256, 512 |
| `favicon/` | Full favicon set plus `site.webmanifest` |
| `social/` | Open Graph image, as a `.svg` and a rendered `.png` |
| `tokens/` | Color tokens — `colors.css`, `colors.json`, `tailwind.css` |
| `LOGO-STYLE.md` | Logo usage guide and the sampled palette |
| `README.md` | Public-facing overview and the asset-consumption URL |

## Color tokens

Three files carry the same palette in three shapes, and **nothing generates one from another** —
they are kept in sync by hand:

- `tokens/colors.css` — CSS custom properties, `--fk-*` prefix, plus role tokens and a
  `[data-theme="light"]` override block.
- `tokens/colors.json` — the same values as data, camelCase (`fkGreen3`), split `dark` / `light`.
- `tokens/tailwind.css` — re-exports the palette in a Tailwind CSS 4 `@theme` block. **Tailwind 4
  syntax is a property of this file; nothing in this repo compiles it.** Consuming repos do.

**Change a color in one and you must change it in all three.** `LOGO-STYLE.md` records where the
palette came from — pixel-sampled from the logo PNG — so update it too when a value moves.

## Code style

Observed from the committed files. Nothing enforces any of it:

- 2-space indentation, no tabs, UTF-8, LF line endings.
- CSS custom properties are `--fk-<name>`; the JSON mirror is camelCase.
- Token files column-align their values. Preserve the alignment when editing.
- Markdown uses tables for reference data.

## Branching

**Work directly on `main`.** Operator policy, confirmed 2026-07-27 — not inferred from history. No
topic branches are required for ordinary work in this repo.

Pushing is a separate decision from committing and is never inferred. Do not push without being
asked.

## Security

This repository is **public**. Everything committed here is world-readable immediately.

- Never add a secret, key, credential, keystore or `.env` file. `.gitignore` is the gate; do not
  weaken it.
- There is no dependency-update configuration here, and that is deliberate: with no manifest, no
  lockfile and no CI workflows, this repo has **zero dependency surface**, and a cooldown config
  would imply a control that is not operating. **If this repo ever gains a `.github/workflows/`
  file, or any file that pins an external dependency (a manifest, lockfile, Dockerfile, devcontainer
  or git submodule), that reasoning expires** and dependency-update config becomes warranted.

## Boundaries — ask before touching

1. **`LICENSE` is Apache-2.0 and the choice is deliberate.** Never change, replace or remove it, and
   never propose a different license. Licensing is a legal and commercial decision, not a technical
   one.
2. **Asset filenames and paths are a public contract.** `README.md` documents a
   `raw.githubusercontent.com` URL pinned to `HEAD`, and other repos in the org consume these paths.
   Renaming or moving a file silently breaks external consumers. Ask first.
3. **`fonts/` and `scripts/` are untracked, in-flight local work.** Do not commit them, do not add
   them to `.gitignore`, do not `git clean` them, and do not move or delete them. They are the
   operator's own pending work and gitignoring them would silently block a later commit.
4. **Stage explicit paths. Never `git add -A` or `git add .` in this repo.** In-flight work here is
   not confined to untracked directories — it also shows up as uncommitted modifications to tracked
   files, `README.md` most of all. A blanket stage sweeps someone else's half-finished change into
   your commit. Check `git status` and name the files you mean.
5. **Derived assets have no committed generator.** `logo/png/*`, the `favicon/*` set and
   `social/og-fukuii.png` are all derived from vector sources, and **as of HEAD** no committed
   command regenerates any of them. Do not improvise a pipeline, and do not hand-edit a raster
   expecting it to stay consistent with its vector. If render tooling is ever committed, replace
   this item with the real command.
6. **`tokens/colors.css` names a canonical source that `README.md` contradicts.** Its header points
   at `brand/design-system/tokens/colors.css`; `README.md` calls this repo canonical. That is
   unresolved. Do not reconcile it on your own — raise it.
7. **`favicon/site.webmanifest` uses root-relative icon paths** (`/android-chrome-192x192.png`). It
   is written for deployment at a site root, not for this repo's directory layout. Do not "fix"
   those paths.
8. **Community-health files are inherited, not missing.** `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`,
   `SECURITY.md` and the issue and pull-request templates are supplied to every repo in the
   `fukuii-project` organization by the org-level `.github` repository. Their absence here is
   inheritance working. Do not add local copies.
9. **CI is available org-wide but deliberately not adopted here.** The `fukuii-project` org
   publishes a reusable `checks.yml`, and `fukuii-template` ships a thin caller for it. This repo
   has no caller. Adding one is an operator decision, not an improvement to make unasked: it
   creates a dependency surface, which is the trigger that makes dependency-update config
   warranted (see Security).
