# reference/ — worked examples, not a dependency

**Copy from these. Do not depend on them.**

`tokens/` is the source of truth and it is data — DTCG JSON, plus the CSS generated
from it. This directory shows how that data becomes a real implementation on a
specific platform. Each product owns its own copy and evolves it freely.

```
reference/
  web/      CSS custom properties, 73 utility classes, 13 guideline pages
```

Directories are per platform so more can be added without restructuring: a
`reference/qml/` Style singleton for the desktop GUI, or a `reference/scala/` ANSI
palette for the CLI, when those products start.

## Why copying, and not a package

There was one — `@fukuii/design-system` on npm. It was deleted. The reasoning is
worth keeping, because the instinct to re-create it will recur:

| Surface | Stack | Styling mechanism |
|---|---|---|
| `fukuii-org` | Astro 7 | plain CSS |
| web apps | Next 16 · React 19 | Tailwind 4 `@theme` |
| web apps | Vite 6 · React 19 | styled-components |
| `fukuii-gui` | Qt/QML | QML properties |
| `fukuii-cli` | Scala 3 | ANSI |

Five surfaces, five styling mechanisms, and the three web ones disagree with each
other. A CSS class is useless to styled-components, awkward for Tailwind, and
meaningless in QML. Two of the five cannot consume a stylesheet at all.

What genuinely crosses all five is **token values** and **design intent**. Those are
in `tokens/` and in the guidelines. Everything below that line is implementation, and
implementation does not survive a consumer changing framework — the previous package
was written for a Next.js site, and became unusable the moment that site moved to
Astro.

The one thing a shared package did buy was preventing value drift, and generated
tokens buy that more cheaply. The drift was real: `#4d8a28`, the pre-rebrand olive,
survived in one consumer's `theme-color` while the manifest correctly said `#50a060`.

## Using the web reference

`web/styles.css` is the entry point and imports the generated token layers plus the
web-only implementation. Copy `web/` and `../tokens/*.css` into your project, or lift
individual rules — both are intended.

Verified: `fukuii-org` builds against this copy with no package dependency, with all
token families and utility classes reaching the built CSS.

Two things that look like details and are not:

- **Use the bare-string `@import` form.** Bundlers silently drop
  `@import url('./relative.css')` — the build passes, and every token vanishes from
  the output while `var(--fk-*)` references survive and resolve to nothing.
- **The layer order is load-bearing.** `base.css` and `effects.css` consume variables
  the token layers define.
