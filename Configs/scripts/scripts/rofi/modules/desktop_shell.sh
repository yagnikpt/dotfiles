#!/usr/bin/env bash

source "$(dirname "$0")/../../utils.sh"

barebones="Barebones"
noctalia="Noctalia"

entries="$barebones\n$noctalia"
system_de=$(getenv DESKTOP_SHELL)
current_shell="${system_de^}"
echo $current_shell

choice=$(echo -e "$entries" | rofi -dmenu -i -p "Select Desktop" -theme ~/.config/rofi/modules/base.rasi -l 2 -select $current_shell)

if [[ -n "$choice" ]]; then
    ~/scripts/niri/kill_de_services.sh
    case "$choice" in
        $barebones)
            setconf "DESKTOP_SHELL" "barebones"
            sed -i "s/include \"${system_de}.kdl\"/include \"barebones.kdl\"/" ~/.config/niri/config.kdl
            ~/scripts/niri/start_barebones_de_services.sh
            ;;
        $noctalia)
            setconf "DESKTOP_SHELL" "noctalia"
            sed -i "s/include \"${system_de}.kdl\"/include \"noctalia.kdl\"/" ~/.config/niri/config.kdl
            ~/scripts/niri/start_noctalia_de_services.sh
            ;;
        *)
            exit 0
            ;;
    esac

fi
