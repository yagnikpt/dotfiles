#!/usr/bin/env bash

plcontrols="Player Controls"
bluetooth="Bluetooth"
wifi="Wifi"
theme="Theme"
limiter="Charge Limiter"
editor="Code"
install="Install Package"
vpn="VPN"
idle="Idle Monitoring"

plcontrols_item="$plcontrols\0icon\x1f./icons/music_note.svg"
bluetooth_item="$bluetooth\0icon\x1f./icons/bluetooth.svg"
wifi_item="$wifi\0icon\x1f./icons/wifi.svg"
theme_item="$theme\0icon\x1f./icons/theme.svg"
limiter_item="$limiter\0icon\x1f./icons/battery_4.svg"
editor_item="$editor\0icon\x1f./icons/code.svg"
install_item="$install\0icon\x1f./icons/install_desktop.svg"
vpn_item="$vpn\0icon\x1f./icons/vpn.svg"
idle_item="$idle\0icon\x1f./icons/idle.svg"

playing=$([[ -z "$(playerctl -l 2>/dev/null)" ]] && echo 0 || echo 1)

OPTIONS=""
lines=0

if [ $playing = "1" ]; then
    OPTIONS+="$plcontrols_item\n"
    lines=$((lines+1))
fi
OPTIONS+="$editor_item\n$bluetooth_item\n$wifi_item\n$theme_item\n$vpn_item\n$idle_item\n$limiter_item\n$install_item"
lines=$((lines+8))

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -show-icons -theme $HOME/.config/rofi/utilities.rasi -l $lines)

case "$CHOICE" in
    $editor)
        $HOME/scripts/rofi/modules/code_editors.sh
        ;;
    $plcontrols)
        $HOME/scripts/rofi/modules/music_controls.sh
        ;;
    $bluetooth)
        $HOME/.local/bin/vicinae vicinae://extensions/Gelei/bluetooth/devices
        ;;
    $wifi)
        $HOME/.local/bin/vicinae vicinae://extensions/dagimg-dot/wifi-commander/manage-saved-networks
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
        kitty --title="install-package-tui" -e $HOME/scripts/pkg-install.sh
        ;;
    *)
        exit 0
        ;;
esac
