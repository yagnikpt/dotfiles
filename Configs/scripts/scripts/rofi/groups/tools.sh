#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

limiter="$(format_row "f24b" "Charge Limiter")"
mimeapps="$(format_row "e5c3" "MimeApps")"
tailscale="$(format_row "eacd" "Tailscale")"
wallpaperengine="$(format_row "e1bc" "Wallpaper Engine")"

lines=1
OPTIONS="$limiter"

system_de=$(getenv DESKTOP_SHELL)

if [[ "$system_de" == "noctalia" ]]; then
    OPTIONS+="\n$mimeapps\n$tailscale\n$wallpaperengine"
    lines=$((lines+3))
fi

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Tools" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
    $limiter)
        $HOME/scripts/rofi/modules/battery_limit.sh
        ;;
    $mimeapps)
        qs -c noctalia-shell ipc call plugin:mimeapp-gui openPanel
        ;;
    $tailscale)
        qs -c noctalia-shell ipc call plugin:tailscale togglePanel
        ;;
    $wallpaperengine)
        qs -c noctalia-shell ipc call plugin:linux-wallpaperengine-controller toggle
        ;;
     *)
        exit 0
        ;;
esac
