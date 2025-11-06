#!/usr/bin/env bash

album_art=$(playerctl -p spotify metadata mpris:artUrl 2> /dev/null)
if [[ -z $album_art ]]; then
    exit
fi
icon=$(printf "\uf108")
echo $icon
