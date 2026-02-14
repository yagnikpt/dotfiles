#!/usr/bin/env bash

# Listen for overview events and signal waybar
niri msg --json event-stream | jq -c --unbuffered 'select(.OverviewOpenedOrClosed != null)' | \
while read -r event; do
    killall -SIGUSR1 waybar
done
