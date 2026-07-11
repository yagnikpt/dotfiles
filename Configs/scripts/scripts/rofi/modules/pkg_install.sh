#!/bin/env bash

source "$(dirname "$0")/../../utils.sh"

dnf="$(format_row_nerd_fonts "f30a" "dnf")"
brew="$(format_row_nerd_fonts "e7fd" "brew")"

choice=$(echo -e "$dnf\n$brew" | rofi -dmenu -markup-rows -p "Installer" -theme ~/.config/rofi/modules/base.rasi -l 2)

case "$choice" in
$dnf)
    footclient --title="dnf-package-tui-overlay" -e $HOME/scripts/dnf_install.sh
    ;;
$brew)
    footclient --title="brew-package-tui-overlay" -e $HOME/scripts/brew_install.sh
    ;;
*) ;;
esac
