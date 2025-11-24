#!/usr/bin/env bash

# Remote name from rclone config
REMOTE="yagnikpt"
# Remote path to store backups
REMOTE_PATH="Backup"

# Array: local_path:remote_subdir
declare -A SOURCE_PATHS=(
    ["$HOME/Documents"]="Documents"
    ["$HOME/Pictures"]="Pictures"
    ["$HOME/codes/dsa"]="codes/dsa"
)

# Flags:
# --update   : skip files that are newer on the remote
# --delete-excluded : remove files deleted locally
# --progress : show progress
# --copy-links : copy symlink targets
# --exclude-from : exclude patterns from file
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
RCLONE_FLAGS="--update --copy-links --delete-excluded --exclude-from $SCRIPT_DIR/rclone_exclude.txt"

for SRC in "${!SOURCE_PATHS[@]}"; do
    if [ -d "$SRC" ] || [ -f "$SRC" ]; then
        rclone sync "$SRC" "$REMOTE:$REMOTE_PATH/${SOURCE_PATHS[$SRC]}" $RCLONE_FLAGS $*
    fi
done

notify-send "Files are synced :)" -a "Backup" -e
