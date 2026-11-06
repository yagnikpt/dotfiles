#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

noc_list="$(format_row "e0ee" "Reading List")"
article="$(format_row "ef42" "Spawn Article")"
bmark="$(format_row "e865" "Read Book")"

lines=2
OPTIONS="$article\n$bmark"

system_de=$(getenv DESKTOP_SHELL)

if [[ "$system_de" == "noctalia" ]]; then
    OPTIONS="$noc_list\n$OPTIONS"
    lines=$((lines + 1))
fi

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Learn" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
$article)
    article_spawner
    ;;
$bmark)
    bmark --rofi --rofi-config ~/.config/rofi/modules/anime_picker.rasi
    ;;
$noc_list)
    noctalia msg panel-toggle ahmedhossamdev/reading-list:panel
    ;;
*)
    exit 0
    ;;
esac
