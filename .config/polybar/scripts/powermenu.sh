#!/usr/bin/env bash

action="$1"

if [ "$action" = "restart" ]; then
    confirm=$(printf '<span color="#ffe600">󰜉  Yes, restart</span>\n<span color="#7a789e">󰌾  Cancel</span>' | rofi -dmenu -markup-rows -i -p "Restart system?" -theme-str 'window {width: 260px;}')
    case "$confirm" in
        *restart*) systemctl reboot ;;
    esac
elif [ "$action" = "shutdown" ]; then
    confirm=$(printf '<span color="#ff2a85">󰐥  Yes, power off</span>\n<span color="#7a789e">󰌾  Cancel</span>' | rofi -dmenu -markup-rows -i -p "Shut down system?" -theme-str 'window {width: 260px;}')
    case "$confirm" in
        *power*|*shut*) systemctl poweroff ;;
    esac
else
    # Full power menu
    choice=$(printf '<span color="#ffe600">󰜉  Restart</span>\n<span color="#ff2a85">󰐥  Shutdown</span>\n<span color="#b829ff">󰍃  Logout</span>\n<span color="#7a789e">󰌾  Cancel</span>' | rofi -dmenu -markup-rows -i -p "Power Menu" -theme-str 'window {width: 240px;}')
    case "$choice" in
        *Restart*) systemctl reboot ;;
        *Shutdown*) systemctl poweroff ;;
        *Logout*) bspc quit ;;
        *) exit 0 ;;
    esac
fi
