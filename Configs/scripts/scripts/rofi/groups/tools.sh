#!/bin/env bash

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}

limiter="$(format_row "f24b" "Charge Limiter")"

lines=1
OPTIONS="$limiter"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Tools" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
    $limiter)
        $HOME/scripts/rofi/modules/battery_limit.sh
        ;;
     *)
        exit 0
        ;;
esac
