#!/usr/bin/env bash

VSCODE_CONFIG_DIR="$HOME/.config/Code/User/globalStorage"
STORAGE_FILE="$VSCODE_CONFIG_DIR/storage.json"

if [ ! -f "$STORAGE_FILE" ]; then
    echo "Error: VS Code storage file not found at '$STORAGE_FILE'."
    echo "Please ensure VS Code is installed and has been opened at least once."
    exit 1
fi

mapfile -t WORKSPACE_PATHS < <(
    jq -r '.profileAssociations.workspaces | keys[]' "$STORAGE_FILE" | grep 'file:///' | sed 's/file:\/\///g'
)

declare -a UNIQUE_PATHS=($(printf "%s\n" "${WORKSPACE_PATHS[@]}" | sort | uniq))

for i in "${!UNIQUE_PATHS[@]}"; do
    UNIQUE_PATHS[$i]="${UNIQUE_PATHS[$i]/$HOME/\~}"
done

if [ ${#UNIQUE_PATHS[@]} -gt 0 ]; then
    val=$(printf "%s\n" "${UNIQUE_PATHS[@]}" | rofi -dmenu -p "Workspaces" -theme $HOME/.config/rofi/modules/base_with_search.rasi -theme-str 'window {width: 500px;}')
    absolute_path="${val/\~/$HOME}"
    if [ -n "$val" ]; then
        code $absolute_path
    fi
else
    notify-send "error"
fi
