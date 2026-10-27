#!/usr/bin/env bash

if pgrep -x polybar >/dev/null; then
    killall -q polybar
    while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.05; done
    # Reset top padding on all monitors so windows reclaim the space
    for m in $(bspc query -M --names 2>/dev/null); do
        bspc config -m "$m" top_padding 0
    done
    bspc config top_padding 0
else
    ~/.config/polybar/launch.sh
fi
