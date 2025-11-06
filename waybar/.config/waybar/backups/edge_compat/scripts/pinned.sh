#!/usr/bin/env bash

apps=(
  "google-chrome.desktop"
  "com.mitchellh.ghostty.desktop"
)

for app in "${apps[@]}"; do
  icon=$(grep "Icon=" "/usr/share/applications/$app" | cut -d= -f2)
  echo "{\"text\":\"\",\"class\":\"pinned\",\"tooltip\":\"$app\",\"icon\":\"$icon\"}"
done
