#!/usr/bin/env bash

fzf_args=(  
  --multi  
  --preview 'paru -Siia {1}'  
  --preview-label='alt-p: toggle description, alt-b/B: toggle PKGBUILD, alt-j/k: scroll, tab: multi-select'  
  --preview-label-pos='bottom'  
  --preview-window 'down:65%:wrap'  
  --bind 'alt-p:toggle-preview'  
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'  
  --bind 'alt-k:preview-up,alt-j:preview-down'  
  --bind 'alt-b:change-preview:paru -Gpa {1} | tail -n +5'  
  --bind 'alt-B:change-preview:paru -Siia {1}'  
  --color 'pointer:green,marker:green'  
)  
  
pkg_names=$(paru -Slqa | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  echo "$pkg_names" | sed 's/^/aur\//' | tr '\n' ' ' | xargs paru -Syu --noconfirm
  read -r
fi
