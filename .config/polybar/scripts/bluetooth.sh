#!/usr/bin/env bash

# Check if bluetooth controller is powered on
if ! bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    echo "%{F#7a789e}󰂲%{F-} off"
    exit 0
fi

# Check for connected devices
connected=$(bluetoothctl devices Connected 2>/dev/null | head -n 1 | cut -d ' ' -f 3-)

if [ -n "$connected" ]; then
    # Truncate device name if too long
    if [ ${#connected} -gt 14 ]; then
        connected="$(echo "$connected" | cut -c 1-12).."
    fi
    echo "%{F#00f0ff}󰂱%{F-} $connected"
else
    echo "%{F#b829ff}󰂯%{F-} on"
fi
