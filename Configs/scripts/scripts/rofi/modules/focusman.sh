#!/bin/env bash

FOCUSMAN_PORT=49312
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:$FOCUSMAN_PORT/status")

if [ "$STATUS_CODE" -eq 200 ]; then
  RUNNING=true
else
  RUNNING=false
fi

if [ "$RUNNING" = true ]; then
  pick=$(echo -e "Change Intent\nExit" | rofi -dmenu -p "focusman" -theme $HOME/.config/rofi/modules/base.rasi -l 2)
  case "$pick" in
  "Change Intent")
    curl "http://localhost:$FOCUSMAN_PORT/change-intent"
    ;;
  "Exit")
    systemctl --user stop focusman
    ;;
  esac
else
  systemctl --user start focusman
fi
