#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

off="Off"
on="On"

state_cmd=$(ps aux | awk '/hypridle/ {print $8; exit}')
state=$on

system_de=$(getenv DESKTOP_SHELL)

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
            *)
                pkill -STOP hypridle
                ;;
        esac
        ;;
    $on)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call idleInhibitor enable
                ;;
            *)
                pkill -CONT hypridle
                ;;
        esac
        ;;
    *)
        exit 0
        ;;
esac

exit 0
