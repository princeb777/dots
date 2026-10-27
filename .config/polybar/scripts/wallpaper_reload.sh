#!/usr/bin/env bash

# Kill existing wallpaper loop
pkill -f wallpaper.sh
sleep 0.2

# Restart wallpaper loop in background
~/.config/bspwm/scripts/wallpaper.sh >/dev/null 2>&1 &

# Send notification
notify-send -u low "Wallpaper" "Wallpaper script refreshed & new background set"
