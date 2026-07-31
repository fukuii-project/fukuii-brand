#!/usr/bin/env bash
# Rebuild favicon/favicon.ico from the sized PNGs committed beside it.
#
# An .ico is a container holding one entry per size. Browsers pick the entry
# matching the slot they are filling, so a missing size means a larger entry
# gets downscaled by the browser rather than using purpose-made art.
#
# This builds the container only. The source PNGs are committed artwork and
# nothing here regenerates them.
#
# Usage:  ./scripts/build-favicon.sh
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIR="$REPO/favicon"
ICO="$DIR/favicon.ico"

command -v convert >/dev/null || { echo "ERROR: ImageMagick 'convert' not found" >&2; exit 1; }

# The three slots browsers actually request from an .ico.
SRC=()
for size in 16 32 48; do
  png="$DIR/favicon-${size}x${size}.png"
  [ -f "$png" ] || { echo "ERROR: missing $png" >&2; exit 1; }
  SRC+=("$png")
done

convert "${SRC[@]}" "$ICO"

echo "Built: $ICO"
if command -v identify >/dev/null; then
  echo "Entries:"
  identify "$ICO" | sed 's|.*favicon.ico\[|  [|' | sed 's/^/  /'
fi
