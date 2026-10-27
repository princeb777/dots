#!/usr/bin/env bash

# Check Wi-Fi radio status
wifi_status=$(nmcli -fields WIFI g 2>/dev/null | tail -n 1 | tr -d '[:space:]')

if [ "$wifi_status" = "disabled" ]; then
    toggle_opt="󰖩  Enable Wi-Fi"
else
    toggle_opt="󰖪  Disable Wi-Fi"
fi

# Generate formatted list of Wi-Fi networks using python
network_list=$(python3 - << 'EOF'
import subprocess

try:
    out = subprocess.check_output(
        ["nmcli", "-t", "-f", "IN-USE,SSID,SIGNAL,SECURITY", "dev", "wifi", "list"],
        stderr=subprocess.DEVNULL,
        text=True
    )
except Exception:
    out = ""

seen = set()
lines = []

for line in out.strip().split("\n"):
    if not line:
        continue
    parts = line.split(":")
    if len(parts) < 4:
        continue
    in_use, ssid, signal, sec = parts[0], parts[1], parts[2], parts[3]
    if not ssid or ssid == "--" or ssid in seen:
        continue
    seen.add(ssid)
    
    sig_int = int(signal) if signal.isdigit() else 0
    if sig_int >= 75:
        icon = "󰤨"
    elif sig_int >= 50:
        icon = "󰤥"
    elif sig_int >= 25:
        icon = "󰤢"
    else:
        icon = "󰤟"
        
    active_mark = "󰄬 " if in_use == "*" else "  "
    sec_icon = "󰌾" if sec else " "
    lines.append(f"{active_mark}{icon}  {ssid:<26} {signal:>3}%  {sec_icon}")

print("\n".join(lines))
EOF
)

# Combine actions and network list
menu_entries=$(printf "%s\n󰑐  Rescan Networks\n%s" "$toggle_opt" "$network_list")

# Prompt user via Rofi
chosen=$(echo -e "$menu_entries" | rofi -dmenu -i -p "Wi-Fi" -theme-str 'window {width: 440px;}')

[ -z "$chosen" ] && exit 0

case "$chosen" in
    *"Enable Wi-Fi"*)
        nmcli radio wifi on
        notify-send -u low "Wi-Fi" "Wi-Fi enabled"
        exit 0
        ;;
    *"Disable Wi-Fi"*)
        nmcli radio wifi off
        notify-send -u low "Wi-Fi" "Wi-Fi disabled"
        exit 0
        ;;
    *"Rescan Networks"*)
        notify-send -u low "Wi-Fi" "Scanning for available networks..."
        nmcli dev wifi rescan
        sleep 1.5
        exec "$0"
        exit 0
        ;;
esac

# Extract SSID from chosen line
# The line format: [2 chars active][1 char icon][2 spaces][SSID 26 chars][1 space][signal 4 chars][2 spaces][sec]
chosen_clean=$(echo "$chosen" | sed -E 's/^[ 󰄬]*[󰤨󰤥󰤢󰤟]  //')
ssid=$(echo "$chosen_clean" | sed -E 's/  +[0-9]+%.*$//' | sed 's/[[:space:]]*$//')

[ -z "$ssid" ] && exit 0

# Check if connection is already saved
saved_con=$(nmcli -t -f NAME connection show | grep -Fx "$ssid")

if [ -n "$saved_con" ]; then
    notify-send "Wi-Fi" "Connecting to saved network: $ssid..."
    if nmcli connection up id "$ssid"; then
        notify-send -u low "Wi-Fi" "Connected to $ssid"
    else
        notify-send -u critical "Wi-Fi" "Failed to connect to $ssid"
    fi
else
    # Check if network requires password (contains 󰌾)
    if [[ "$chosen" =~ "󰌾" ]]; then
        password=$(rofi -dmenu -password -p "Enter Password for $ssid:" -theme-str 'window {width: 380px;}')
        [ -z "$password" ] && exit 0
        notify-send "Wi-Fi" "Connecting to $ssid..."
        if nmcli device wifi connect "$ssid" password "$password"; then
            notify-send -u low "Wi-Fi" "Connected to $ssid"
        else
            notify-send -u critical "Wi-Fi" "Failed to connect to $ssid. Check password."
        fi
    else
        notify-send "Wi-Fi" "Connecting to $ssid..."
        if nmcli device wifi connect "$ssid"; then
            notify-send -u low "Wi-Fi" "Connected to $ssid"
        else
            notify-send -u critical "Wi-Fi" "Failed to connect to $ssid"
        fi
    fi
fi
