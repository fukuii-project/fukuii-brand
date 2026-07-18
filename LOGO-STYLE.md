# Fukuii Logo Style Reference

Derived from `logo/fukuii-hex-logo.png` via pixel sampling.

## Visual Style

The logo is a **sticker-style badge** — bold black outline/stroke, flat fills, white bleed border,
and a cartoon character mascot. The aesthetic is playful-technical: cute enough to be memorable,
structured enough to anchor a technical product.

- **Shape**: flat-top hexagon (pointing-sides orientation)
- **Treatment**: sticker with white outer border + deep drop shadow
- **Character**: anthropomorphic mantis/grasshopper with a pink worm accessory
- **Typography**: bold slab/outlined wordmark "FUKUII" below the hexagon

## Color Palette (sampled from logo PNG)

| Role | Token | Hex | Notes |
|---|---|---|---|
| Hex background (primary) | `--fk-green-3` | `#50a060` | Dominant green — the brand's main green |
| Character body (accent green) | `--fk-green-char` | `#60b040` | More yellow-green, mantis body |
| Highlight / glow | `--fk-green-light` | `#70c080` | Lighter variant, used for canvas glow |
| Mid green (light mode accent) | `--fk-green-2` | `#2d6b40` | Darker version for light backgrounds |
| Deep green (backgrounds) | `--fk-green` | `#1e4a2d` | Darkest green in scale |
| Worm accent (pink) | `--fk-pink` | `#c06060` | Dusty rose — secondary accent |
| Outline / dark strokes | — | `#202020` | Near-neutral dark from logo outlines |
| Sticker white border | — | `#ffffff` | Hard white outline around shapes |
| Gold (secondary brand) | `--fk-gold-2` | `#d6b56b` | Not from logo directly — existing brand |

## Design System Usage

- `--accent` (dark mode) = `--fk-green-3` `#50a060` — buttons, links, highlights
- `--accent` (light mode) = `--fk-green-2` `#2d6b40` — same role, darker for contrast
- `--fk-pink` = secondary accent; use sparingly for alerts, tags, or decorative callouts
- `--fk-green-char` = available for secondary visual elements where yellow-green contrast is needed

## Logo Alignment Notes

- The previous green (`#4d8a28`) was olive/dark and did not match the logo's actual hex color
- Greens in the canvas animation (HexCanvas.tsx) and all CSS tokens have been updated to `#50a060` base
- The character's body green (`#60b040`) is warmer/more yellow than the hex background — do not
  conflate the two; use `--fk-green-3` for primary brand actions, `--fk-green-char` only for
  decorative secondary elements
