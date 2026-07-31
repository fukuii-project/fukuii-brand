#!/usr/bin/env bash
# Rebuild the derived favicon assets:
#
#   favicon/favicon.ico          — container, from the 16/32/48 PNGs beside it
#   favicon/maskable-512x512.png — Android/PWA maskable icon
#
# Source PNGs are committed artwork; nothing here regenerates them.
#
# Usage:  ./scripts/build-favicon.sh
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIR="$REPO/favicon"

command -v convert >/dev/null || { echo "ERROR: ImageMagick 'convert' not found" >&2; exit 1; }

# ---- favicon.ico -----------------------------------------------------------
# An .ico is a container holding one entry per size. Browsers pick the entry
# matching the slot they are filling, so a missing size means a larger entry
# gets downscaled by the browser instead of using purpose-made art.
ICO="$DIR/favicon.ico"
SRC=()
for size in 16 32 48; do
  png="$DIR/favicon-${size}x${size}.png"
  [ -f "$png" ] || { echo "ERROR: missing $png" >&2; exit 1; }
  SRC+=("$png")
done
convert "${SRC[@]}" "$ICO"
echo "Built: $ICO"

# ---- maskable-512x512.png --------------------------------------------------
# A maskable icon is cropped by the platform to a device mask (circle, squircle,
# teardrop). Only the central 80% circle — radius 204.8px on a 512 canvas — is
# guaranteed visible, and the icon must be fully opaque, because the mask crops
# to a shape and any transparency shows the platform's background through it.
#
# The mark's furthest opaque pixel sits at 231.1px from centre in the 500x500
# source, i.e. 92.4% of half-canvas. Rendering it into a 433px box puts that
# point at ~201px on the 512 canvas, inside the safe circle with a few px to
# spare for resampling. 433 is a DOWNSCALE of the 500px source, never an upscale.
MASK="$DIR/maskable-512x512.png"
LOGO="$REPO/logo/fukuii-hex-logo.png"
[ -f "$LOGO" ] || { echo "ERROR: missing $LOGO" >&2; exit 1; }

# Background is --fk-ink (tokens/colors.css). Kept in sync by hand: this is a
# generated raster, not a token consumer.
convert "$LOGO" -resize 433x433 \
  -background '#1a1f16' -gravity center -extent 512x512 \
  -flatten -alpha off \
  -define png:compression-level=9 \
  "$MASK"
echo "Built: $MASK"

if command -v identify >/dev/null; then
  echo "Entries:"
  identify "$ICO" | sed 's|.*favicon.ico\[|  [|' | sed 's/^/  /'
  identify "$MASK" | sed 's/^/  /'
fi
