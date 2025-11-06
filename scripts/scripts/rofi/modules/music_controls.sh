#!/usr/bin/env bash

currentState=$(playerctl status)
toggle=$([[ "$currentState" = "Playing" ]] && echo "Pause" || echo "Play")
next="Next"
prev="Previous"
loop="Loop"

toggle_item=$([[ "$currentState" = "Playing" ]] && echo "$toggle\0icon\x1f$HOME/.config/rofi/icons/pause.svg" || echo "$toggle\0icon\x1f$HOME/.config/rofi/icons/play.svg")
next_item="$next\0icon\x1f$HOME/.config/rofi/icons/skip_next.svg"
prev_item="$prev\0icon\x1f$HOME/.config/rofi/icons/skip_previous.svg"
loop_item="$loop\0icon\x1f$HOME/.config/rofi/icons/repeat.svg"

loop_none="None"
loop_track="Track"
loop_playlist="Playlist"

loop_rofi() {
    declare -A VAL_INDEX=(
        ["None"]=2
        ["Track"]=0
        ["Playlist"]=1
    )
    currentLoop=$(playerctl loop)
    loop_val=$(echo -e "$loop_track\n$loop_playlist\n$loop_none" | rofi -dmenu -p "Loop Mode" -theme ~/.config/rofi/modules/base.rasi -l 3 -select "$currentLoop")
    if [ -n "$loop_val" ]; then
        playerctl loop "$loop_val"
    fi
}

song_info=$(printf "<b>$(playerctl metadata xesam:title)</b>\n$(playerctl metadata xesam:artist)")

val=$(echo -e "$next_item\n$toggle_item\n$prev_item\n$loop_item" | rofi -dmenu -show-icons -p "Player Controls" -mesg "$song_info" -theme ~/.config/rofi/modules/base.rasi -l 4)

case $val in
    $toggle)
        playerctl play-pause
        ;;
    $next)
        playerctl next
        ;;
    $prev)
        playerctl previous
        ;;
    $loop)
        loop_rofi
        ;;
    *)
        exit 0
        ;;
esac
