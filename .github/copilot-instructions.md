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
tokens. Every `fukuii-project` repo references these assets from here, so paths in this repo are a
public contract other repos depend on.

Fukuii itself is a multi-EVM execution client written in Scala 3. **None of that code lives here.**
This repo holds brand assets only.

## There is no toolchain here — read this before suggesting any command

This repo has **no build system, no package manager and no dependencies** — as of HEAD; if a
script is ever committed, replace this section with the real commands:

- **No manifest and no lockfile of any kind.** No `package.json`, no `*.toml`, no `Makefile`, no
  `justfile`, no `Taskfile`, no `go.mod`, no `Cargo.toml`, no `pyproject.toml`, no `build.sbt`, no
  `Dockerfile`.
- **No `install`, `dev`, `build`, `lint`, `format`, `typecheck` or `test` command exists.** Never
  invent one and never suggest running one. There is nothing to run.
- **No CI.** This repo has no `.github/workflows/`.
- **No linter and no formatter config at any level** — no `.editorconfig`, `.prettierrc`,
  `.eslintrc` or `.stylelintrc` anywhere in the tree.

**Match the existing style by hand.** No gate will catch a formatting mistake here, because there is
no gate.

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
- `tokens/tailwind.css` — re-exports the palette in a Tailwind CSS 4 `@theme` block. Tailwind 4
  syntax is a property of that file; **nothing in this repo compiles it.** Consuming repos do.

**Change a color in one and you must change it in all three**, and update `LOGO-STYLE.md`, which
records the sampled palette.

## Code style

Observed from the committed files. Nothing enforces any of it:

- 2-space indentation, no tabs, UTF-8, LF line endings.
- CSS custom properties are `--fk-<name>`; the JSON mirror is camelCase.
- Token files column-align their values. Preserve the alignment when editing.
- Markdown uses tables for reference data.

## Branching

Work directly on `main`. No topic branches are required for ordinary work in this repo. Pushing is a
separate decision from committing — never push without being asked.

## Security

This repository is **public**. Everything committed here is world-readable immediately.

- Never add a secret, key, credential, keystore or `.env` file. `.gitignore` is the gate; do not
  weaken it.
- There is no dependency-update configuration, and that is deliberate: with no manifest, no lockfile
  and no CI workflows, this repo has zero dependency surface. If it ever gains a
  `.github/workflows/` file, or any file that pins an external dependency (a manifest, lockfile,
  Dockerfile, devcontainer or git submodule), that changes.

## Do not

1. **Change, replace or remove `LICENSE`.** It is Apache-2.0 by deliberate choice. Never propose a
   different license — the question is legal and commercial, not technical.
2. **Rename or move an asset.** `README.md` documents a `raw.githubusercontent.com` URL pinned to
   `HEAD`, and other repos consume these paths. A rename silently breaks external consumers.
3. **Touch `fonts/` or `scripts/`.** They are untracked, in-flight local work. Do not commit them,
   do not add them to `.gitignore`, do not `git clean` them, do not move or delete them.
4. **Run `git add -A` or `git add .`.** In-flight work here is not confined to untracked
   directories — it also shows up as uncommitted modifications to tracked files, `README.md` most of
   all. A blanket stage sweeps someone else's half-finished change into your commit. Check
   `git status` and stage explicit paths.
5. **Improvise an asset pipeline.** `logo/png/*`, the `favicon/*` set and `social/og-fukuii.png` are
   derived from vector sources with no committed generator. Do not hand-edit a raster expecting it
   to stay consistent with its vector.
6. **Reconcile the canonical-source conflict.** `tokens/colors.css` names
   `brand/design-system/tokens/colors.css` as canonical while `README.md` calls this repo canonical.
   That is unresolved — raise it, do not pick a side.
7. **"Fix" the paths in `favicon/site.webmanifest`.** They are root-relative
   (`/android-chrome-192x192.png`) because the file is written for deployment at a site root, not
   for this repo's layout.
8. **Add `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` or issue and PR templates.** The
   `fukuii-project` organization supplies all of them to every repo that lacks its own. Their
   absence here is inheritance working, not a gap.
9. **Add CI.** The `fukuii-project` org publishes a reusable `checks.yml`, and `fukuii-template`
   ships a thin caller for it — an obviously-helpful, org-sanctioned action. Adding one here is an
   operator decision: it creates a dependency surface, which is the trigger that makes
   dependency-update config warranted (see Security).

## Response style

- No pleasantries. Code first, explanation only if asked.
- Concise bullets over paragraphs.
- Do not repeat the prompt back.
