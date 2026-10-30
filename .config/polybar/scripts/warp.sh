#!/usr/bin/env bash

# Handle toggle action
if [ "$1" = "--toggle" ]; then
    status=$(warp-cli status 2>/dev/null | grep -i "Status update:" | cut -d: -f2 | tr -d " ")
    if [ "$status" = "Connected" ] || [ "$status" = "Connecting" ]; then
        warp-cli disconnect >/dev/null 2>&1
        notify-send -u low "Cloudflare WARP" "Disconnected" 2>/dev/null || true
    else
        warp-cli connect >/dev/null 2>&1
        notify-send -u low "Cloudflare WARP" "Connecting to WARP..." 2>/dev/null || true
    fi
    exit 0
fi

# Fetch connection status
status=$(warp-cli status 2>/dev/null | grep -i "Status update:" | cut -d: -f2 | tr -d " ")

case "$status" in
    "Connected")
        echo "%{F#00f0ff}󰖂%{F-} WARP"
        ;;
    "Connecting")
        echo "%{F#ffe600}󰖂%{F-} Connecting"
        ;;
    *)
        echo "%{F#7a789e}󰖂 WARP%{F-}"
        ;;
esac
