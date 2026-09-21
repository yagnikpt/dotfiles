#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

limiter="$(format_row "f24b" "Charge Limiter")"
tailscale="$(format_row "eacd" "Tailscale")"
wallpaperengine="$(format_row "e1bc" "Wallpaper Engine")"
webapps="$(format_row "e051" "WebApps")"
dns="$(format_row "e875" "DNS Switcher")"

lines=1
OPTIONS="$limiter"

system_de=$(getenv DESKTOP_SHELL)

if [[ "$system_de" == "noctalia" ]]; then
    OPTIONS+="\n$tailscale\n$webapps\n$dns\n$wallpaperengine"
    lines=$((lines + 4))
fi

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Tools" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
$limiter)
    $HOME/scripts/rofi/modules/battery_limit.sh
    ;;
$tailscale)
    noctalia msg panel-toggle davemhammer/tailscale:manager
    ;;
$wallpaperengine)
    noctalia msg panel-toggle tadomika_ari/w-engine:w-engine-panel
    ;;
$webapps)
    noctalia msg panel-toggle umedbazarov/webapp-maker:panel
    ;;
$dns)
    noctalia msg panel-toggle nightwatch75/dns-switcher:panel
    ;;
*)
    exit 0
    ;;
esac
