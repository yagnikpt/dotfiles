#!/bin/env bash

setconf() {
  local key="$1"
  local val="$2"
  local file="${3:-${HOME}/.config/environment.d/env.conf}"

  sed -i "s|^${key}=.*|${key}=${val}|" "$file"
  systemctl --user set-environment "${key}=${val}"
}

getconf() {
  local key="$1"
  local file="${2:-${HOME}/.config/environment.d/env.conf}"

  grep "^${key}=" "$file" | cut -d'=' -f2
}

getenv() {
  local key="$1"
  systemctl --user show-environment | grep "^${key}=" | cut -d'=' -f2
}

format_row() {
    local icon=$(printf "\u$1")
    local label="$2"
    printf "<span face='Material Symbols Rounded' size='x-large' line_height='0.01' rise='-5pt'>%s</span> %s" "$icon" "$label"
}
