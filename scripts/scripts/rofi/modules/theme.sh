#!/usr/bin/env bash

current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)
light="Light"
dark="Dark"

light_item="$light\0icon\x1f./icons/light_mode.svg"
dark_item="$dark\0icon\x1f./icons/dark_mode.svg"

selected=""

if [ $current_theme == "'prefer-dark'" ]; then
    selected=$dark
else
    selected=$light
fi

new_theme=$(echo -e "$light_item\n$dark_item" | rofi -dmenu -show-icons -p "Select Theme" -theme $HOME/.config/rofi/modules/base.rasi -l 2 -select $selected)
current_image=$(swww query | sed 's/.*: //')

case $new_theme in
    $light)
        gsettings set org.gnome.desktop.interface color-scheme default
        matugen image $current_image -m light
        ;;
    $dark)
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
        matugen image $current_image -m dark
        ;;
    *)
        ;;
esac
