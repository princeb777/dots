#!/usr/bin/env bash

# Handle control flags if invoked directly
case "$1" in
    --play-pause)
        playerctl play-pause 2>/dev/null
        exit 0
        ;;
    --next)
        playerctl next 2>/dev/null
        exit 0
        ;;
    --prev)
        playerctl previous 2>/dev/null
        exit 0
        ;;
esac

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    play_icon="%{F#00f0ff}󰏤%{F-}" # Cyan pause button when playing
elif [ "$status" = "Paused" ]; then
    play_icon="%{F#ffe600}󰐊%{F-}" # Yellow play button when paused
else
    # No media playing or player stopped
    echo ""
    exit 0
fi

# Fetch artist & title
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ -n "$artist" ] && [ -n "$title" ]; then
    text="$artist - $title"
elif [ -n "$title" ]; then
    text="$title"
else
    text="Media"
fi

# Truncate if title is long
if [ ${#text} -gt 28 ]; then
    text="$(echo "$text" | cut -c 1-25)..."
fi

if [ "$status" = "Paused" ]; then
    text="%{F#7a789e}$text%{F-}"
else
    text="%{F#f8f9fc}$text%{F-}"
fi

# Clickable media control buttons
btn_prev="%{A1:playerctl previous:}%{F#b829ff}󰒮%{F-}%{A}"
btn_play="%{A1:playerctl play-pause:}$play_icon%{A}"
btn_next="%{A1:playerctl next:}%{F#b829ff}󰒭%{F-}%{A}"

echo "$btn_prev  $btn_play  $btn_next   $text"
