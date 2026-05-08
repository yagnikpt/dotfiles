#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

theme="$(format_row "eb37" "Theme")"
idle="$(format_row "f3e5" "Idle Inhibitor")"
shell="$(format_row "e30b" "Shell")"

lines=3
OPTIONS="$shell\n$theme\n$idle"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Desktop" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
    $shell)
        $HOME/scripts/rofi/modules/desktop_shell.sh
        ;;
    $theme)
        $HOME/scripts/rofi/modules/theme.sh
        ;;
    $idle)
        $HOME/scripts/rofi/modules/idle.sh
        ;;
     *)
        exit 0
        ;;
esac
