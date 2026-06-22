#!/usr/bin/env bash

source "$(dirname "$0")/../utils.sh"

plcontrols="$(format_row "e405" "Player Controls")"
bluetooth="$(format_row "e1a7" "Bluetooth")"
wifi="$(format_row "e63e" "Wifi")"
install="$(format_row "eb71" "Install Package")"
vpn="$(format_row "e62f" "VPN")"
devtools="$(format_row "eb8e" "DevTools")"
desktop="$(format_row "e30b" "Desktop")"
anime="$(format_row "e02c" "Anime")"
tools="$(format_row "e869" "Tools")"
learn="$(format_row "ea19" "Learn")"

OPTIONS=""
lines=9

if playerctl -l 2>/dev/null | grep -qE "^(brave|spotify)"; then
    OPTIONS+="$plcontrols\n"
    lines=$((lines+1))
fi
OPTIONS+="$learn\n$devtools\n$anime\n$bluetooth\n$wifi\n$desktop\n$tools\n$vpn\n$install"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -theme $HOME/.config/rofi/utilities.rasi -l $lines)

system_de=$(getenv DESKTOP_SHELL)

case "$CHOICE" in
    $plcontrols)
        $HOME/scripts/rofi/modules/music_controls.sh
        ;;
    $learn)
        $HOME/scripts/rofi/groups/learn.sh
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
            "noctalia_v5")
                noctalia msg panel-toggle control-center bluetooth;;
            *)
                vicinae vicinae://launch/@Gelei/store.vicinae.bluetooth/devices
                ;;
        esac
        ;;
    $wifi)
        case "$system_de" in
            "noctalia")
                qs -c noctalia-shell ipc call network togglePanel
                ;;
            "noctalia_v5")
                noctalia msg panel-toggle control-center network;;
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
