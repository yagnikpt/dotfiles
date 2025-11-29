#!/usr/bin/env bash

# Options
shutdown="$(printf '\ue8ac')"
reboot="$(printf '\uf053')"
suspend="$(printf '\uef44')"
logout="$(printf '\ue9ba')"

chosen="$(echo -e "$shutdown\n$reboot\n$suspend\n$logout" | rofi -dmenu -theme ~/.config/rofi/powermenu.rasi)"

case "$chosen" in
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$suspend")
    systemctl suspend
    ;;
  "$logout")
    niri msg action quit -s
    ;;
  *)
    exit 0
    ;;
esac
