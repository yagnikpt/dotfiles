#!/usr/bin/env bash

BATTERY_PATH="/org/freedesktop/UPower/devices/battery_BAT0"
CHECK_INTERVAL=30
LOW_BATTERY_NOTIFIED=0
FULL_THRESHOLD_NOTIFIED=0

while true; do
    PERCENTAGE=$(upower -i $(upower -e | grep BAT) | grep "percentage" | awk '{print $2}' | tr -d '%')
    STATE=$(upower -i $BATTERY_PATH | grep state | awk '{print $2}')
    FULL_THRESHOLD=$(cat /sys/class/power_supply/BAT0/charge_control_end_threshold 2>/dev/null || echo "100")

    # Check if battery is at or below 20% and not charging
    if [ "$PERCENTAGE" -le 20 ] && [ "$STATE" != "charging" ] && [ "$STATE" != "fully-charged" ]; then
        if [ "$LOW_BATTERY_NOTIFIED" -eq 0 ]; then
            notify-send -u critical "Low Battery Alert" "Battery at ${PERCENTAGE}%! Plug in your charger."
            LOW_BATTERY_NOTIFIED=1
        fi
    else
        LOW_BATTERY_NOTIFIED=0
    fi

    # Check if battery has reached the full threshold while charging
    if [ "$PERCENTAGE" -ge "$FULL_THRESHOLD" ] && [ "$STATE" = "charging" ]; then
        if [ "$FULL_THRESHOLD_NOTIFIED" -eq 0 ]; then
            notify-send -u normal "Battery Full" "Battery reached ${FULL_THRESHOLD}% threshold. Consider unplugging to preserve battery health."
            FULL_THRESHOLD_NOTIFIED=1
        fi
    else
        # Reset notification flag when battery drops below threshold or stops charging
        if [ "$PERCENTAGE" -lt "$FULL_THRESHOLD" ] || [ "$STATE" != "charging" ]; then
            FULL_THRESHOLD_NOTIFIED=0
        fi
    fi

    sleep $CHECK_INTERVAL
done
