#!/usr/bin/env bash

case "$1" in
    --status)
        pct=$(brightnessctl -m 2>/dev/null | cut -d, -f4 | tr -d '%')
        [ -z "$pct" ] && pct=0
        
        if [ "$pct" -ge 70 ]; then
            icon="󰃠"
        elif [ "$pct" -ge 30 ]; then
            icon="󰃟"
        else
            icon="󰃞"
        fi
        echo "%{F#00f0ff}$icon%{F-} $pct%"
        exit 0
        ;;
    --inc)
        brightnessctl set +5% >/dev/null 2>&1
        polybar-msg action "#backlight.hook.0" >/dev/null 2>&1
        exit 0
        ;;
    --dec)
        brightnessctl set 5%- >/dev/null 2>&1
        polybar-msg action "#backlight.hook.0" >/dev/null 2>&1
        exit 0
        ;;
    --menu)
        options="<span color='#00f0ff'>󰃠  100%</span>\n<span color='#00f0ff'>󰃠  80%</span>\n<span color='#b829ff'>󰃟  60%</span>\n<span color='#b829ff'>󰃟  40%</span>\n<span color='#7a789e'>󰃞  20%</span>\n<span color='#7a789e'>󰃞  5%</span>"
        chosen=$(echo -e "$options" | rofi -dmenu -markup-rows -i -p "Brightness" -theme-str 'window {width: 200px;}')

        case "$chosen" in
            *100%*) brightnessctl set 100% ;;
            *80%*)  brightnessctl set 80% ;;
            *60%*)  brightnessctl set 60% ;;
            *40%*)  brightnessctl set 40% ;;
            *20%*)  brightnessctl set 20% ;;
            *5%*)   brightnessctl set 5% ;;
        esac
        polybar-msg action "#backlight.hook.0" >/dev/null 2>&1
        exit 0
        ;;
    *)
        exec "$0" --menu
        ;;
esac
