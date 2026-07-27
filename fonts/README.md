# Fonts

The typefaces Fukuii's visual identity is built on, vendored so brand assets render from these exact
files rather than from whatever happens to be installed locally.

| Family | File | Axes | Source |
|---|---|---|---|
| **DM Sans** | `dm-sans/DMSans[opsz,wght].ttf` (+ italic) | `opsz` 9–40 · `wght` 100–1000 | [google/fonts `ofl/dmsans`](https://github.com/google/fonts/tree/main/ofl/dmsans) |
| **JetBrains Mono** | `jetbrains-mono/JetBrainsMono[wght].ttf` (+ italic) | `wght` 100–800 | [google/fonts `ofl/jetbrainsmono`](https://github.com/google/fonts/tree/main/ofl/jetbrainsmono) |

Both are variable fonts — a single file covers the full weight range.

## Why these builds

They come from **google/fonts** — the same distribution the `@fontsource/*` npm packages are generated
from. Rendering brand assets with these files means the output matches the fonts a browser actually
loads on the site, rather than a differently-built cut of the same design.

## Rendering (no installation needed)

`fonts.conf` is a scoped fontconfig that exposes **only** these files. Point `FONTCONFIG_FILE` at it:

```bash
FONTCONFIG_FILE="$PWD/fonts/fonts.conf" inkscape ...
```

`scripts/render-og.sh` does this for the social card. Pinning the fonts fixes the font side of a render;
rasterization still depends on the Inkscape version (the current PNG came from Inkscape 1.4.x).

System fonts are *not* included. A system-installed copy of a brand font can otherwise win the match
over the vendored file and silently change a render.

fontconfig always returns a best match, so a family that isn't vendored here silently resolves to one of
these files rather than failing. Vendor every family an asset needs.

## Installing locally (optional)

Only needed if you want these fonts inside design tools (e.g. editing the SVG in the Inkscape GUI).
Rendering and CI never require it.

```bash
./fonts/install-fonts.sh
```

## License

Both families are licensed under the **SIL Open Font License 1.1**, which permits redistribution.
The `OFL.txt` in each directory is the authoritative license and must travel with the fonts.

DM Sans was commissioned from Colophon Foundry and is derived from Poppins; it is not an officially
supported Google product.
