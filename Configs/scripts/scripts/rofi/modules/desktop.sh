#!/usr/bin/env bash

custom="Custom"
noctalia="Noctalia"

entries="$custom\n$noctalia"
system_de=$(systemctl --user show-environment | sed -n 's/^DESKTOP_SHELL=//p')
current_shell="${system_de^}"

choice=$(echo -e "$entries" | rofi -dmenu -i -p "Select Desktop" -theme ~/.config/rofi/modules/base.rasi -l 2 -select $current_shell)

if [[ -n "$choice" ]]; then
    ~/scripts/niri/kill_de_services.sh
    case "$choice" in
        $custom)
            systemctl --user set-environment DESKTOP_SHELL=custom
            sed -i "s/include \"${system_de}.kdl\"/include \"custom.kdl\"/" ~/.config/niri/config.kdl
            ~/scripts/niri/start_custom_de_services.sh
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
