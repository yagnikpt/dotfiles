#!/usr/bin/env bash

player=$(playerctl -l 2>/dev/null | head -n 1)
if [ -z "$player" ]; then
  echo '{"text": "", "tooltip": "", "class": "inactive"}'
  exit 0
fi

name=$(playerctl metadata --format '{{title}}' 2>/dev/null)
artist=$(playerctl metadata --format '{{artist}}' 2>/dev/null)
icon="󰎈"

case "$player" in
  *spotify*) icon="" ;;
  *mpv*) icon="󰎁" ;;
  *vlc*) icon="󰕼" ;;
esac

echo "{\"text\":\"$icon\",\"tooltip\":\"$artist - $name\"}"
