#!/usr/bin/env bash

# Check Bluetooth power status
powered=$(bluetoothctl show 2>/dev/null | grep -q "Powered: yes" && echo "yes" || echo "no")

if [ "$powered" = "no" ]; then
    chosen=$(printf "󰂯  Turn Bluetooth On\n󰌾  Cancel" | rofi -dmenu -i -p "Bluetooth (Off)" -theme-str 'window {width: 280px;}')
    if [ "$chosen" = "󰂯  Turn Bluetooth On" ]; then
        bluetoothctl power on
        notify-send -u low "Bluetooth" "Bluetooth powered on"
    fi
    exit 0
fi

# Build menu of devices and actions
menu=$(python3 - << 'EOF'
import subprocess

print("󰂲  Turn Bluetooth Off")
print("󰑐  Scan for Nearby Devices")

connected_macs = set()
try:
    conn_out = subprocess.check_output(["bluetoothctl", "devices", "Connected"], text=True, stderr=subprocess.DEVNULL)
    for line in conn_out.strip().split("\n"):
        parts = line.split(" ")
        if len(parts) >= 3:
            connected_macs.add(parts[1])
except Exception:
    pass

try:
    dev_out = subprocess.check_output(["bluetoothctl", "devices"], text=True, stderr=subprocess.DEVNULL)
    for line in dev_out.strip().split("\n"):
        parts = line.split(" ")
        if len(parts) >= 3:
            mac = parts[1]
            name = " ".join(parts[2:])
            if mac in connected_macs:
                print(f"󰄬 󰂱  {name:<22} (Connected) [{mac}]")
            else:
                print(f"   󰂯  {name:<22} (Disconnected) [{mac}]")
except Exception:
    pass
EOF
)

chosen=$(echo -e "$menu" | rofi -dmenu -i -p "Bluetooth" -theme-str 'window {width: 440px;}')

[ -z "$chosen" ] && exit 0

case "$chosen" in
    *"Turn Bluetooth Off"*)
        bluetoothctl power off
        notify-send -u low "Bluetooth" "Bluetooth powered off"
        exit 0
        ;;
    *"Scan for Nearby Devices"*)
        notify-send -u low "Bluetooth" "Scanning for nearby devices for 7 seconds..."
        bluetoothctl --timeout 7 scan on >/dev/null 2>&1
        exec "$0"
        exit 0
        ;;
esac

# Extract MAC address from "[XX:XX:XX:XX:XX:XX]"
mac=$(echo "$chosen" | grep -o -E '\[([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}\]' | tr -d '[]')
name=$(echo "$chosen" | sed -E 's/^[ 󰄬]*[󰂱󰂯]  //' | sed -E 's/  +\(Connected\)|\(Disconnected\).*//' | sed 's/[[:space:]]*$//')

[ -z "$mac" ] && exit 0

if [[ "$chosen" =~ "(Connected)" ]]; then
    notify-send "Bluetooth" "Disconnecting $name..."
    if bluetoothctl disconnect "$mac" >/dev/null 2>&1; then
        notify-send -u low "Bluetooth" "Disconnected from $name"
    else
        notify-send -u critical "Bluetooth" "Failed to disconnect $name"
    fi
else
    notify-send "Bluetooth" "Connecting to $name ($mac)..."
    if bluetoothctl connect "$mac" >/dev/null 2>&1; then
        notify-send -u low "Bluetooth" "Connected to $name"
    else
        notify-send -u critical "Bluetooth" "Failed to connect to $name"
    fi
fi
