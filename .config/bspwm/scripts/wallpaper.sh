#!/usr/bin/env bash

# Path to your wallpapers folder
WALLPAPER_DIR="$HOME/Pictures/wallpapers"  # change this to your folder

# Interval in seconds
INTERVAL=60

# Optional: your pywal16 template
TEMPLATE="alacritty16.toml"

# Function to pick a random wallpaper
pick_wallpaper() {
    mapfile -t files < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))
    echo "${files[RANDOM % ${#files[@]}]}"
}

# Infinite loop
while true; do
    WALLPAPER=$(pick_wallpaper)
    echo "Setting wallpaper: $WALLPAPER"

    # Generate pywal16 colors from wallpaper and apply template
    wal -i "$WALLPAPER" -t -n -q  # -t uses template, -n avoids auto wallpaper setting, -q quiet
    feh --bg-scale "$WALLPAPER"
    # Optional: set wallpaper manually if wal didn't set it
    # feh --bg-scale "$WALLPAPER"

    sleep "$INTERVAL"
done
