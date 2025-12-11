#!/usr/bin/env bash

set -e

OUTDIR="$HOME/Videos/Recordings"
mkdir -p "$OUTDIR"

timestamp() {
    date +%Y-%m-%d_%H-%M-%S
}

is_running() {
    pgrep -f gpu-screen-recorder >/dev/null 2>&1
}

start_recording() {
    FILENAME="record_$(timestamp).mp4"
    OUTFILE="$OUTDIR/$FILENAME"

    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -o "$OUTFILE"
}

stop_recording() {
    pkill -SIGINT -f gpu-screen-recorder || true
    notify-send -a "top-layer" "Screen Recorder" "Recording saved."
}

if is_running; then
    stop_recording
else
    start_recording
fi
