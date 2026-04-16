#!/usr/bin/env bash

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}

plcontrols="$(format_row "e405" "Player Controls")"
bluetooth="$(format_row "e1a7" "Bluetooth")"
wifi="$(format_row "e63e" "Wifi")"
install="$(format_row "eb71" "Install Package")"
vpn="$(format_row "e62f" "VPN")"
devtools="$(format_row "eb8e" "DevTools")"
desktop="$(format_row "e30b" "Desktop")"
anime="$(format_row "e02c" "Anime")"
tools="$(format_row "e869" "Tools")"

OPTIONS=""
lines=8

if playerctl -l 2>/dev/null | grep -qE "^(brave|spotify)"; then
    OPTIONS+="$plcontrols\n"
    lines=$((lines+1))
fi
OPTIONS+="$devtools\n$anime\n$bluetooth\n$wifi\n$desktop\n$tools\n$vpn\n$install"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -theme $HOME/.config/rofi/utilities.rasi -l $lines)

system_de=$(systemctl --user show-environment | sed -n 's/^DESKTOP_SHELL=//p')

case "$CHOICE" in
    $plcontrols)
        $HOME/scripts/rofi/modules/music_controls.sh
        ;;
    $devtools)
        $HOME/scripts/rofi/modules/devtools.sh
        ;;
    $anime)
        curd -rofi
        ;;
    $bluetooth)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call bluetooth togglePanel
                ;;
            *)
                vicinae vicinae://extensions/Gelei/bluetooth/devices
                ;;
        esac
        ;;
    $wifi)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call network togglePanel
                ;;
            *)
                nmgui
                ;;
        esac
        ;;
    $desktop)
        $HOME/scripts/rofi/groups/desktop.sh
        ;;
    $tools)
        $HOME/scripts/rofi/groups/tools.sh
        ;;
    $vpn)
        $HOME/scripts/rofi/modules/vpn.sh
        ;;
    $install)
        $HOME/scripts/rofi/modules/pkg_install.sh
        ;;
    *)
        exit 0
        ;;
esac
