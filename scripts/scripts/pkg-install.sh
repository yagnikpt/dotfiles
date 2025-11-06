#!/usr/bin/env bash

fzf_args=(
  --multi
  --preview 'dnf -q if {1}'
  --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize'
  --preview-label-pos='bottom'
  --preview-window 'down:60%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:green,marker:green'
)

pkg_names=$(dnf ls -q --available| fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  packages_to_install=$(echo "$pkg_names" | awk '{print $1}' | tr '\n' ' ')
  sudo dnf install -y --allowerasing $packages_to_install
  read -r
fi
