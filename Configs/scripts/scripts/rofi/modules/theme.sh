#!/usr/bin/env bash

current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)

source "$(dirname "$0")/../../utils.sh"

light="$(format_row "e518" "Light")"
dark="$(format_row "e51c" "Dark")"

selected=""

if [ $current_theme == "'prefer-dark'" ]; then
    selected="$dark"
else
    selected="$light"
fi

new_theme=$(echo -e "$light\n$dark" | rofi -dmenu -markup-rows -p "Select Theme" -theme $HOME/.config/rofi/modules/base.rasi -l 2 -select "$selected")

system_de=$(getenv DESKTOP_SHELL)

case $new_theme in
$light)
    case "$system_de" in
    "noctalia")
        noctalia msg theme-mode-set light
        ;;
    *)
        current_image=$(awww query | sed 's/.*: //')
        ~/scripts/niri/handle_theme_or_wallpaper.sh "$current_image" "light"
        ;;
    esac
    ;;
$dark)
    case "$system_de" in
    "noctalia")
        noctalia msg theme-mode-set dark
        ;;
    *)
        current_image=$(awww query | sed 's/.*: //')
        ~/scripts/niri/handle_theme_or_wallpaper.sh "$current_image" "dark"
        ;;
    esac
    ;;
*) ;;
esac
