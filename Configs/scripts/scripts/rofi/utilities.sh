#!/usr/bin/env bash

source "$(dirname "$0")/../utils.sh"

bluetooth="$(format_row "e1a7" "Bluetooth")"
wifi="$(format_row "e63e" "Wifi")"
install="$(format_row "eb71" "Install Package")"
vpn="$(format_row "e62f" "VPN")"
desktop="$(format_row "e30b" "Desktop")"
anime="$(format_row "e02c" "Anime")"
tools="$(format_row "e869" "Tools")"
learn="$(format_row "ea19" "Learn")"

OPTIONS=""
lines=8

OPTIONS+="$learn\n$anime\n$bluetooth\n$wifi\n$desktop\n$tools\n$vpn\n$install"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -theme $HOME/.config/rofi/utilities.rasi -l $lines)

system_de=$(getenv DESKTOP_SHELL)

case "$CHOICE" in
$learn)
    $HOME/scripts/rofi/groups/learn.sh
    ;;
$anime)
    curd -rofi
    ;;
$bluetooth)
    case "$system_de" in
    "noctalia")
        noctalia msg panel-toggle control-center bluetooth
        ;;
    *)
        vicinae vicinae://launch/@Gelei/store.vicinae.bluetooth/devices
        ;;
    esac
    ;;
$wifi)
    case "$system_de" in
    "noctalia")
        noctalia msg panel-toggle control-center network
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
