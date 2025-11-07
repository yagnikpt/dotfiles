#!/usr/bin/env bash

# Reload Spotify via Ctrl+Shift+R, then return to the previous window
theme=$(spicetify config current_theme)
scheme=$(spicetify config color_scheme)

# spicetify update

# If the matugen theme is not applied
if [[ "$theme" != "matugen" || "$scheme" != "Base" ]]; then
  spicetify config current_theme matugen color_scheme Base
  spicetify apply enable-devtools
else
  # Get the currently active window address
  ACTIVE_WINDOW=$(niri msg -j focused-window | jq -r '.id' 2>/dev/null)

  # Find Spotify window class (first match)
  SPOTIFY_WINDOW=$(niri msg -j windows | jq -r '.[] | select(.app_id=="Spotify") | .id' | head -n 1)

  spicetify refresh -s

  if [ -z "$SPOTIFY_WINDOW" ]; then
    echo "Spotify window not found."
    exit 0
  fi

  # Focus Spotify
  niri msg action focus-window --id "$SPOTIFY_WINDOW"
  sleep 0.1

  # Send Ctrl+Shift+R to Spotify
  ydotool key 29:1 42:1 19:1 19:0 42:0 29:0

  # Return to previously focused window
  if [ -n "$ACTIVE_WINDOW" ]; then
    niri msg action focus-window --id "$ACTIVE_WINDOW"
  fi
fi
