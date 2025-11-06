#!/usr/bin/env bash

cliphist list | rofi -dmenu -i -p "Clipboard:" \
                               -theme $HOME/.config/rofi/clipboard.rasi \
                               | cliphist decode | wl-copy
