#!/usr/bin/env bash

MAX=$(brightnessctl max)
CUR=$(brightnessctl get)
PERC=$((CUR * 100 / MAX))

case "$1" in
  up)
    brightnessctl set +5%
    PERC=$((($(brightnessctl get) * 100) / MAX))
    ;;
  down)
    brightnessctl set 5%-
    PERC=$((($(brightnessctl get) * 100) / MAX))
    ;;
  *)
    echo "Usage: $0 {up|down}"
    exit 1
    ;;
esac

notify-send -a "osd" -h int:value:"$PERC" ""
