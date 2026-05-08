#!/bin/env bash

vscode="Code"
zed="Zed"

options="$vscode\n$zed"

val=$(echo -e $options | rofi -dmenu -p "Code Editors" -l 2 -theme ~/.config/rofi/modules/base.rasi)

case "$val" in
    $vscode)
        vicinae vicinae://launch/@ShyAssassin/store.vicinae.vscode-recents/open-recents
        ;;
    $zed)
        vicinae vicinae://launch/@pavle99/store.vicinae.zed-recents/open-recents
        ;;
    *)
        exit 0
        ;;
esac
