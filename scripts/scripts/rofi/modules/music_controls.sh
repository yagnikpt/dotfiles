#!/usr/bin/env bash

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}

currentState=$(playerctl status)
toggle=$([[ "$currentState" = "Playing" ]] && echo "$(format_row "e034" "Pause")" || echo "$(format_row "e037" "Play")")
next="$(format_row "e044" "Next")"
prev="$(format_row "e045" "Previous")"
loop="$(format_row "e040" "Loop")"

loop_none="None"
loop_track="Track"
loop_playlist="Playlist"

loop_rofi() {
    currentLoop=$(playerctl loop)
    loop_val=$(echo -e "$loop_track\n$loop_playlist\n$loop_none" | rofi -dmenu -p "Loop Mode" -theme ~/.config/rofi/modules/base.rasi -l 3 -select "$currentLoop")
    if [ -n "$loop_val" ]; then
        playerctl loop "$loop_val"
    fi
}

song_info=$(printf "<b>$(playerctl metadata xesam:title)</b>\n$(playerctl metadata xesam:artist)")

val=$(echo -e "$next\n$toggle\n$prev\n$loop" | rofi -dmenu -markup-rows -p "Player Controls" -mesg "$song_info" -theme ~/.config/rofi/modules/base.rasi -l 4)

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
