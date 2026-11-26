#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

pacman="$(format_row_nerd_fonts "f385" "pacman")"
aur="$(format_row_nerd_fonts "e732" "aur")"

choice=$(echo -e "$pacman\n$aur" | rofi -dmenu -markup-rows -p "Installer" -theme ~/.config/rofi/modules/base.rasi -l 2)

case "$choice" in
$pacman)
    footclient --title="pacman-package-tui-overlay" -e $HOME/scripts/pacman_install.sh
    ;;
$aur)
    footclient --title="aur-package-tui-overlay" -e $HOME/scripts/aur_install.sh
    ;;
*) ;;
esac
