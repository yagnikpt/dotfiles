#!/usr/bin/env bash

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}

plcontrols="$(format_row "e405" "Player Controls")"
bluetooth="$(format_row "e1a7" "Bluetooth")"
wifi="$(format_row "e63e" "Wifi")"
theme="$(format_row "eb37" "Theme")"
limiter="$(format_row "f24b" "Charge Limiter")"
editor="$(format_row "e86f" "Code")"
install="$(format_row "eb71" "Install Package")"
vpn="$(format_row "e016" "VPN")"
idle="$(format_row "f3e5" "Idle Monitoring")"
devtools="$(format_row "e869" "DevTools")"

playing=$([[ -z "$(playerctl -l 2>/dev/null)" ]] && echo 0 || echo 1)

OPTIONS=""
lines=9

if [ $playing = "1" ]; then
    OPTIONS+="$plcontrols\n"
    lines=$((lines+1))
fi
OPTIONS+="$editor\n$devtools\n$bluetooth\n$wifi\n$theme\n$vpn\n$idle\n$limiter\n$install"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -theme $HOME/.config/rofi/utilities.rasi -l $lines)

case "$CHOICE" in
    $editor)
        $HOME/scripts/rofi/modules/code_editors.sh
        ;;
    $plcontrols)
        $HOME/scripts/rofi/modules/music_controls.sh
        ;;
    $devtools)
        $HOME/scripts/rofi/modules/devtools.sh
        ;;
    $bluetooth)
        vicinae vicinae://extensions/Gelei/bluetooth/devices
        ;;
    $wifi)
        ghostty --title="wifi-tui" -e nmtui
        ;;
    $theme)
        $HOME/scripts/rofi/modules/theme.sh
        ;;
    $vpn)
        $HOME/scripts/rofi/modules/vpn.sh
        ;;
    $idle)
        $HOME/scripts/rofi/modules/idle.sh
        ;;
    $limiter)
        $HOME/scripts/rofi/modules/battery_limit.sh
        ;;
    $install)
        $HOME/scripts/rofi/modules/pkg_install.sh
        ;;
    *)
        exit 0
        ;;
esac
