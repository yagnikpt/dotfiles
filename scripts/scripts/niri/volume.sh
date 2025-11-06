#!/usr/bin/env bash

step=0.05

MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "muted" || echo "unmuted")

case "$1" in
    up)
        if [ "$MUTED" = "muted" ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%
        fi
        wpctl set-mute @DEFAULT_SINK@ 0
        wpctl set-volume @DEFAULT_SINK@ "${step}+" -l 1.0
        ;;
    down)
        # wpctl set-mute @DEFAULT_SINK@ 0
        wpctl set-volume @DEFAULT_SINK@ "${step}-"
        ;;
    mute)
        wpctl set-mute @DEFAULT_SINK@ toggle
        ;;
esac

volume=$(wpctl get-volume @DEFAULT_SINK@)
vol_value=$(echo "$volume" | awk '{print $2 * 100}')
vol_status=$(echo "$volume" | cut -d" " -f3)

if [ "$vol_status" = "[MUTED]" ]; then
    notify-send -a "muted" "MUTED"
    exit 0
fi

notify-send -a "osd" -h int:value:"$vol_value" ""
