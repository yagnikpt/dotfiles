#!/bin/env bash

vscode="Code"
zed="Zed"

options="$vscode\n$zed"

val=$(echo -e $options | rofi -dmenu -p "Code Editors" -l 2 -theme ~/.config/rofi/modules/base.rasi)

case "$val" in
    $vscode)
        vicinae deeplink vicinae://extensions/ShyAssassin/vscode-recents/open-recents
        ;;
    $zed)
        vicinae deeplink vicinae://extensions/pavle99/zed-recents/open-recents
        ;;
    *)
        exit 0
        ;;
esac
