#!/usr/bin/env bash
album_art=$(playerctl -p spotify metadata mpris:artUrl 2> /dev/null)
if [[ -z $album_art ]]; then
    exit
fi

file="/tmp/cover.png"
curl -s "${album_art}" --output "$file"

magick "$file" -gravity Center \( -size 400x400 xc:Black -fill White -draw "circle 200,200 200,0" -alpha Copy \) -compose CopyOpacity -composite "$file"

tooltip="$(playerctl -p spotify metadata xesam:title 2> /dev/null) - $(playerctl -p spotify metadata xesam:artist 2> /dev/null)"

echo -e "$file\n$tooltip"
