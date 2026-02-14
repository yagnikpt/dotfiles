#!/usr/bin/env bash

current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}

light="$(format_row "e518" "Light")"
dark="$(format_row "e51c" "Dark")"

selected=""

if [ $current_theme == "'prefer-dark'" ]; then
    selected="$dark"
else
    selected="$light"
fi

new_theme=$(echo -e "$light\n$dark" | rofi -dmenu -markup-rows -p "Select Theme" -theme $HOME/.config/rofi/modules/base.rasi -l 2 -select "$selected")
current_image=$(swww query | sed 's/.*: //')

case $new_theme in
    $light)
        gsettings set org.gnome.desktop.interface gtk-theme ""; gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3;
        gsettings set org.gnome.desktop.interface color-scheme default;
        gsettings set org.gnome.desktop.interface icon-theme Papirus-Light
        # sed -i 's/gtk-application-prefer-dark-theme = true/gtk-application-prefer-dark-theme = false/' ~/.config/gtk-4.0/settings.ini
        matugen image "$current_image" -m light
        pkill -SIGUSR2 waybar
        ;;
    $dark)
        gsettings set org.gnome.desktop.interface gtk-theme ""; gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark;
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark;
        gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
        # sed -i 's/gtk-application-prefer-dark-theme = false/gtk-application-prefer-dark-theme = true/' ~/.config/gtk-4.0/settings.ini
        matugen image "$current_image" -m dark
        pkill -SIGUSR2 waybar
        ;;
    *)
        ;;
esac
