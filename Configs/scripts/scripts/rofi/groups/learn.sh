#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

article="$(format_row "ef42" "Spawn Article")"
bmark="$(format_row "e865" "Read Book")"

lines=2
OPTIONS="$article\n$bmark"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -markup-rows -i -p "Learn" -theme $HOME/.config/rofi/modules/base.rasi -l $lines)

case "$CHOICE" in
    $article)
        article_spawner
        ;;
    $bmark)
        bmark --rofi --rofi-config ~/.config/rofi/modules/anime_picker.rasi
        ;;
     *)
        exit 0
        ;;
esac
