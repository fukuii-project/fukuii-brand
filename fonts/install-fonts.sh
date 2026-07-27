#!/usr/bin/env bash
# OPTIONAL — install the vendored brand fonts into the current user's font directory.
#
# You do NOT need this to render brand assets: scripts/render-og.sh uses fonts.conf to
# expose these files for a single command. Install only if you want the fonts available
# inside design tools (e.g. editing the SVG in the Inkscape GUI).
#
# User-level only — never writes outside $HOME, never needs root.
set -euo pipefail

FONTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/fukuii"

mkdir -p "$DEST"
find "$FONTS_DIR" -name '*.ttf' -exec cp {} "$DEST/" \;

# The OFL requires the license to travel with the fonts. Name-spaced by family, since
# both files are called OFL.txt.
for ofl in "$FONTS_DIR"/*/OFL.txt; do
  cp "$ofl" "$DEST/OFL-$(basename "$(dirname "$ofl")").txt"
done

echo "Installed to: $DEST"
ls "$DEST"

if command -v fc-cache >/dev/null; then
  fc-cache -f "$DEST" >/dev/null
  echo "Font cache refreshed."
else
  echo "NOTE: fc-cache not found — you may need to refresh your font cache manually."
fi

echo
echo "Reminder: renders should still use scripts/render-og.sh (hermetic). A system-installed"
echo "copy can otherwise win the font match and silently change output."
