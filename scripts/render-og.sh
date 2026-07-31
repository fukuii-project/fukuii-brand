#!/usr/bin/env bash
# Regenerate social/og-fukuii.png from og-fukuii.svg.
#
# Renders with the vendored fonts in fonts/ via a scoped fontconfig: no system font
# installation required, and a system-installed lookalike can't win the match. Output
# also depends on the Inkscape version (the current PNG came from Inkscape 1.4.x).
#
# Needs Inkscape 1.x and ImageMagick.
#
# Usage:  ./scripts/render-og.sh
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SVG="$REPO/social/og-fukuii.svg"
PNG="$REPO/social/og-fukuii.png"

command -v inkscape >/dev/null || { echo "ERROR: inkscape not found" >&2; exit 1; }
command -v convert  >/dev/null || { echo "ERROR: ImageMagick 'convert' not found" >&2; exit 1; }

export FONTCONFIG_FILE="$REPO/fonts/fonts.conf"

if command -v fc-list >/dev/null; then
  echo "Fonts visible to this render:"
  fc-list : file | sed 's|.*/||; s|: *$||' | sort -u | sed 's/^/  - /'
fi

# 1200x630 is the Open Graph card size, and matches the SVG's viewBox.
inkscape "$SVG" \
  --export-type=png \
  --export-filename="$PNG" \
  --export-width=1200 \
  --export-height=630

# The card is a full-bleed rectangle with no transparency, so Inkscape's alpha
# channel is dead weight — every pixel is opaque. Dropping it is lossless here
# and takes ~10% off the file.
convert "$PNG" -alpha off -define png:compression-level=9 "$PNG"

echo "Rendered: $PNG"
