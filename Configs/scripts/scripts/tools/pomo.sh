#!/bin/env bash

pom() {
  local split="$POMO_SPLIT"

  if [[ -z "$split" ]]; then
    split="$(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")"
  fi

  case "$split" in
    25/5)
      work="25m"
      break_time="5m"
      ;;
    50/10)
      work="50m"
      break_time="10m"
      ;;
    "all done")
      return
      ;;
    *)
      return 1
      ;;
  esac

  timer "$work" && terminal-notifier \
    -message Pomodoro \
    -title 'Work Timer is up! Take a Break 😊' \
    -sound Crystal

  if gum confirm "Ready for a break?"; then
    timer "$break_time" && terminal-notifier \
      -message Pomodoro \
      -title 'Break is over! Get back to work 😬' \
      -sound Crystal
  else
    pom
  fi
}
