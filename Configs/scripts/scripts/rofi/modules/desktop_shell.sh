#!/usr/bin/env bash

barebones="Barebones"
noctalia="Noctalia"

entries="$barebones\n$noctalia"
system_de=$(systemctl --user show-environment | sed -n 's/^DESKTOP_SHELL=//p')
current_shell="${system_de^}"

choice=$(echo -e "$entries" | rofi -dmenu -i -p "Select Desktop" -theme ~/.config/rofi/modules/base.rasi -l 2 -select $current_shell)

if [[ -n "$choice" ]]; then
    ~/scripts/niri/kill_de_services.sh
    case "$choice" in
        $barebones)
            systemctl --user set-environment DESKTOP_SHELL=barebones
            sed -i "s/include \"${system_de}.kdl\"/include \"barebones.kdl\"/" ~/.config/niri/config.kdl
            ~/scripts/niri/start_barebones_de_services.sh
            ;;
        $noctalia)
            systemctl --user set-environment DESKTOP_SHELL=noctalia
            sed -i "s/include \"${system_de}.kdl\"/include \"noctalia.kdl\"/" ~/.config/niri/config.kdl
            ~/scripts/niri/start_noctalia_de_services.sh
            ;;
        *)
            exit 0
            ;;
    esac

fi
