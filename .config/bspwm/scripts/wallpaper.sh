#!/usr/bin/env bash

# Path to your wallpapers folder
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Interval in seconds
INTERVAL=60

# Function to pick a random wallpaper
pick_wallpaper() {
    mapfile -t files < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) 2>/dev/null)
    if [ ${#files[@]} -gt 0 ]; then
        echo "${files[RANDOM % ${#files[@]}]}"
    fi
}

# Infinite loop
while true; do
    WALLPAPER=$(pick_wallpaper)
    if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
        echo "Setting wallpaper: $WALLPAPER"

        # Generate pywal16 colors from the wallpaper. Templates in
        # ~/.config/wal/templates are rendered into ~/.cache/wal
        # (alacritty imports ~/.cache/wal/alacritty.toml).
        # -n: don't set wallpaper (feh does it)  -t: skip tty  -q: quiet
        if command -v wal &>/dev/null; then
            wal -i "$WALLPAPER" -n -t -q
        fi

        # --bg-fill preserves aspect ratio (no stretching) by zooming to fill screen
        feh --bg-fill "$WALLPAPER"
    fi

    sleep "$INTERVAL"
done
