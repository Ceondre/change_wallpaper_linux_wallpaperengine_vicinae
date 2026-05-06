#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title change Background
# @vicinae.mode compact
# @vicinae.description Uses Linux wallpaperengine to change the Wallpaper random, from all the wallpapers in your workshop

set -euo pipefail
shopt -s nullglob
killall linux-wallpaperengine || true
dir="$HOME/.steam/steam/steamapps/workshop/content/431960"

folders=()
for d in "$dir"/*/; do
  [ -d "$d" ] || continue
  folders+=("${d%/}")  # entferne abschließenden Slash
done

if (( ${#folders[@]} == 0 )); then
  echo "kein Ordner gefunden in: $dir" >&2
  exit 1
fi

idx=$(( RANDOM % ${#folders[@]} ))
selected="${folders[$idx]}"

# Aufruf: Pfad zum gewählten Ordner (füge Slash hinzu, falls das Programm einen braucht)
linux-wallpaperengine --screen-root eDP-1 --screen-root HDMI-A-1 "$selected/"
