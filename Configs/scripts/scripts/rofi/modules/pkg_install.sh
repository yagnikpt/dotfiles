#!/usr/bin/env bash

dnf="dnf"
brew="brew"

choice=$(echo -e "$dnf\n$brew" | rofi -dmenu -p "Installer" -theme ~/.config/rofi/modules/base.rasi -l 2)

case "$choice" in
    $dnf)
        footclient --title="dnf-package-tui-overlay" -e $HOME/scripts/dnf_install.sh
        ;;
    $brew)
        footclient --title="brew-package-tui-overlay" -e $HOME/scripts/brew_install.sh
        ;;
    *)
        ;;
esac
