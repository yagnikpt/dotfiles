#!/usr/bin/env bash

dnf="dnf"
brew="brew"

choice=$(echo -e "$dnf\n$brew" | rofi -dmenu -p "Installer" -theme ~/.config/rofi/modules/base.rasi -l 2)

case "$choice" in
    $dnf)
        kitty --title="dnf-package-tui" -e $HOME/scripts/dnf_install.sh
        ;;
    $brew)
        kitty --title="brew-package-tui" -e $HOME/scripts/brew_install.sh
        ;;
    *)
        ;;
esac
