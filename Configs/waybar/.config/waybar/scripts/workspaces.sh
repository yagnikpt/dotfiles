#!/bin/env bash

# ---- HANDLE SCROLL ----
if [ "$1" = "up" ]; then
    niri msg action focus-workspace-up >/dev/null 2>&1
    exit 0
elif [ "$1" = "down" ]; then
    niri msg action focus-workspace-down >/dev/null 2>&1
    exit 0
fi

# ---- GET ACTIVE WORKSPACE ----
ACTIVE=$(niri msg -j workspaces | jq '.[] | select(.is_active == true) | .id')

[ -z "$ACTIVE" ] && exit 0

TEXT="[Workspace $ACTIVE]"
TOOLTIP="Active Workspace: $ACTIVE"

echo "{\"text\":\"$TEXT\"}"
