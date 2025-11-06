#!/bin/env bash

off="Off"
on="On"

state_cmd=$(ps aux | awk '/hypridle/ {print $8; exit}')
state=$on

if [[ "$state_cmd" == *"T"* ]]; then
    state=$off
fi

val=$(echo -e "$on\n$off" | rofi -dmenu -p "Idle Monitoring" -theme ~/.config/rofi/modules/base.rasi -l 2 -select "$state")

if [[ -n "$val" ]]; then
    case "$val" in
        $off)
            pkill -STOP hypridle
            ;;
        $on)
            pkill -CONT hypridle
            ;;
        *)
            exit 0
            ;;
    esac

fi
exit 0
