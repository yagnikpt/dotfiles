#!/usr/bin/env bash

# Remote name from rclone config
REMOTE="gdrive"
# Remote path to store backups
REMOTE_PATH="Backup"

# Array: local_path:remote_subdir
declare -A SOURCE_PATHS=(
    ["$HOME/Documents"]="Documents"
    ["$HOME/Pictures"]="Pictures"
    ["$HOME/codes/dsa"]="codes/dsa"
)

# Flags for bisync:
# --resync   : required for first run to establish baseline (remove after first sync)
# --copy-links : copy symlink targets
# --exclude-from : exclude patterns from file
# --verbose  : show what's happening
# --create-empty-src-dirs : ensure directory structure is mirrored
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RCLONE_FLAGS=(
    --copy-links
    --exclude-from "$SCRIPT_DIR/rclone_exclude.txt"
    --conflict-resolve newer
    --create-empty-src-dirs
    --verbose
)

# NOTE: For the FIRST run, add --resync flag:
# RCLONE_FLAGS="$RCLONE_FLAGS --resync"
# After first successful sync, remove --resync and run normally

status=0

for SRC in "${!SOURCE_PATHS[@]}"; do
    if [ -d "$SRC" ] || [ -f "$SRC" ]; then
        if ! rclone bisync "$SRC" "$REMOTE:$REMOTE_PATH/${SOURCE_PATHS[$SRC]}" "${RCLONE_FLAGS[@]}" "$@"; then
            status=1
        fi
    fi
done

if [ "$status" -eq 0 ]; then
    notify-send "Files are synced :)" -a "Backup" -e
else
    notify-send "Backup errored" -a "Backup" -u critical -e
fi
