#!/bin/env bash

off="Off"
on="On"

state_cmd=$(ps aux | awk '/hypridle/ {print $8; exit}')
state=$on

system_de=$(systemctl --user show-environment | sed -n 's/^DESKTOP_SHELL=//p')

if [[ "$state_cmd" == *"T"* ]]; then
    state=$off
fi

val=$(echo -e "$on\n$off" | rofi -dmenu -p "Idle Inhibitor" -theme ~/.config/rofi/modules/base.rasi -l 2 -select "$state")

case "$val" in
    $off)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call idleInhibitor disable
                ;;
            "custom")
                pkill -STOP hypridle
                ;;
        esac
        ;;
    $on)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call idleInhibitor enable
                ;;
            "custom")
                pkill -CONT hypridle
                ;;
        esac
        ;;
    *)
        exit 0
        ;;
esac

exit 0
