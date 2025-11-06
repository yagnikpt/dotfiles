#!/usr/bin/env bash

off="Off"
entries=$(nmcli c show --order name | awk '/wg/ {print $1}')
output="$off\n$entries"

readarray -t vpns < <(nmcli c show --order name | grep wg | awk '{print $1}')
length=$((${#vpns[@]}+1))
search=$(nmcli c show --active | awk '/wg/ {print $1; exit}')
active=$(nmcli c show --active | awk '/wg/ {print $1}')

val=$(echo -e "$output" | rofi -dmenu -p "VPN" -theme ~/.config/rofi/modules/base.rasi -l $length -select "$search")

close_connections() {
    for wg in $(nmcli c show --active | awk '/wg/ {print $1}'); do
        nmcli c down $wg
    done
}

if [[ -n "$val" ]]; then
    if [[ "$val" == "$off" ]]; then
        close_connections
        exit 0
    fi

    if [[ "$val" == "$active" ]]; then
        exit 0
    else
        close_connections
    fi

    nmcli c up $val
fi
exit 0
