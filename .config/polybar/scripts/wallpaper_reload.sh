#!/usr/bin/env bash

WALLPAPER_SCRIPT="$HOME/.config/bspwm/scripts/wallpaper.sh"

# Kill existing wallpaper loop (match the full path only, so nothing else
# with "wallpaper.sh" in its name gets killed)
pkill -f "$WALLPAPER_SCRIPT"
sleep 0.2

# Restart wallpaper loop fully detached from polybar
setsid -f "$WALLPAPER_SCRIPT" >/dev/null 2>&1 </dev/null

# Send notification
notify-send -u low "Wallpaper" "Wallpaper script refreshed & new background set"
