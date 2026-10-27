#!/usr/bin/env bash

# Query active connection from NetworkManager
active=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev 2>/dev/null | grep -E "connected" | grep -v "externally\|disconnected" | head -n 1)

type=$(echo "$active" | cut -d: -f2)
conn=$(echo "$active" | cut -d: -f4)

if [ "$type" = "wifi" ]; then
    if [ ${#conn} -gt 15 ]; then
        conn="$(echo "$conn" | cut -c 1-13).."
    fi
    echo "%{F#00f0ff}󰖩%{F-} $conn"
elif [ "$type" = "ethernet" ]; then
    echo "%{F#b829ff}󰈀%{F-} Wired"
else
    echo "%{F#7a789e}󰖪%{F-} Offline"
fi
