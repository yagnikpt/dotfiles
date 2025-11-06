#!/usr/bin/env bash

limit=$(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)

val=$(echo -e "100\n80\n60" | rofi -dmenu -p "Battery Charging Limit" -theme ~/.config/rofi/modules/base.rasi -select "$limit" -l 3)
if [ -n "$val" ]; then
    asusctl -c $val
fi
