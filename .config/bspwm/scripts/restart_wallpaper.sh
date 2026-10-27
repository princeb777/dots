#!/usr/bin/env bash

# Kill existing wallpaper script
pkill -f "$HOME/.config/bspwm/scripts/wallpaper.sh"

# Small delay to ensure it's fully stopped
sleep 0.2

# Restart it in background
~/.config/bspwm/scripts/wallpaper.sh &
