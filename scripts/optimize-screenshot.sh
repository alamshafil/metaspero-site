#!/usr/bin/env bash
# Convert PNG/JPG screenshots to optimized WebP for the site.
# Usage: scripts/optimize-screenshot.sh <input...> [-o <output-dir>] [-w <width>] [-q <quality>]
# Defaults: output public/screenshots/games, width 1600px, quality 85.
# Requires: cwebp (macos: brew install webp)
set -euo pipefail

out="public/screenshots/games"; width=1600; quality=85; inputs=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o) out="$2"; shift 2 ;;
    -w) width="$2"; shift 2 ;;
    -q) quality="$2"; shift 2 ;;
    -h|--help) sed -n '2,5p' "$0"; exit 0 ;;
    *) inputs+=("$1"); shift ;;
  esac
done

[[ ${#inputs[@]} -gt 0 ]] || { echo "No input files. Use -h for help." >&2; exit 1; }
command -v cwebp >/dev/null || { echo "cwebp not found (brew install webp)" >&2; exit 1; }

mkdir -p "$out"
for f in "${inputs[@]}"; do
  name="$(basename "${f%.*}").webp"
  cwebp -q "$quality" -resize "$width" 0 -quiet "$f" -o "$out/$name" 2>/dev/null
  echo "$f -> $out/$name"
done
