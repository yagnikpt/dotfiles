#!/usr/bin/env bash

map_hue_to_accent_color() {
    local hue=$1
    if (( hue >= 0 && hue <= 15 )) || (( hue >= 345 && hue <= 360 )); then
        echo "red"
    elif (( hue >= 16 && hue <= 45 )); then
        echo "orange"
    elif (( hue >= 46 && hue <= 75 )); then
        echo "yellow"
    elif (( hue >= 76 && hue <= 165 )); then
        echo "green"
    elif (( hue >= 166 && hue <= 195 )); then
        echo "teal"
    elif (( hue >= 196 && hue <= 255 )); then
        echo "blue"
    elif (( hue >= 256 && hue <= 285 )); then
        echo "purple"
    elif (( hue >= 286 && hue <= 344 )); then
        echo "pink"
    else
        echo "slate"
    fi
}

wallpaper=$(gsettings get org.gnome.desktop.background picture-uri | sed -e "s/'//g" -e "s/file:\/\///")
hue=$(magick "$wallpaper" -resize 1x1\! -colorspace HSL -format "%[fx:360*u.p{0,0}.r]" info:)
sat=$(magick "$wallpaper" -resize 1x1\! -colorspace HSL -format "%[fx:100*u.p{0,0}.g]" info:)
hue=$(printf "%.0f\n" "$hue")
sat=$(printf "%.0f\n" "$sat")

if (( sat < 10 )); then
    accent_color="slate"
else
    accent_color=$(map_hue_to_accent_color $hue)
fi

gsettings set org.gnome.desktop.interface accent-color "$accent_color"

cd ~/sys_tools/Marble-shell-theme
current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)
if [ $current_theme == "'prefer-dark'" ]; then
    sat=$((sat+8))
else
    sat=$((sat+25))
fi
python install.py -Pnp -O --filled -Pds --hue $hue --name sysacc --sat=$sat
