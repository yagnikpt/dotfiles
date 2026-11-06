#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

limiter="$(format_row "f24b" "Charge Limiter")"
tailscale="$(format_row "eacd" "Tailscale")"
webapps="$(format_row "e051" "WebApps")"
dns="$(format_row "e875" "DNS Switcher")"
mimeapps="$(format_row "ef40" "Default Apps")"
cursors="$(format_row "f82f" "Manager Cursors")"
phone_op="$(format_row "e7ba" "Phone Operate")"

lines=1
OPTIONS="$limiter"

system_de=$(getenv DESKTOP_SHELL)

if [[ "$system_de" == "noctalia" ]]; then
    OPTIONS+="\n$tailscale\n$webapps\n$mimeapps\n$dns\n$cursors\n$phone_op"
    lines=$((lines + 6))
fi

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Tools" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
$limiter)
    $HOME/scripts/rofi/modules/battery_limit.sh
    ;;
$tailscale)
    noctalia msg panel-toggle davemhammer/tailscale:manager
    ;;
$webapps)
    noctalia msg panel-toggle umedbazarov/webapp-maker:panel
    ;;
$dns)
    noctalia msg panel-toggle nightwatch75/dns-switcher:panel
    ;;
$mimeapps)
    noctalia msg panel-toggle thaer99ob/default-apps:manager
    ;;
$cursors)
    noctalia msg panel-toggle vn1k/cursor:manager
    ;;
$phone_op)
    noctalia msg panel-toggle icefish/phone-operate:main
    ;;
*)
    exit 0
    ;;
esac
