#!/bin/env bash

source "$(dirname "$0")/../utils.sh"

image_path="$1"
mode="$2"

system_de=$(getenv DESKTOP_SHELL)

if [[ -z "$image_path" ]]; then
  echo "Provide the fuckin image in args" >&2
  exit 1
fi

if [[ -z "$mode" ]]; then
  mode="dark"
fi

config_path="$HOME/.config/matugen/noctalia.toml"

if [[ "$system_de" == "barebones" ]]; then
  config_path="$HOME/.config/matugen/config.toml"
fi

matugen image "$image_path" -c "$config_path" -m "$mode" --type scheme-content --source-color-index 0

if [[ "$mode" == "dark" ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  vicinae theme set libadwaita-dark
  pkill -USR1 foot
  pkill -USR2 waybar
else
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
  gsettings set org.gnome.desktop.interface color-scheme 'default'

  vicinae theme set libadwaita-light
  pkill -USR2 foot
  pkill -USR2 waybar
fi
