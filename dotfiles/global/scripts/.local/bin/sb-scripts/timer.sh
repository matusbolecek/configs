#!/bin/sh

STATE_FILE="$HOME/.local/share/dwm-timer/state"
TODAY=$(date +%Y-%m-%d)

[ ! -f "$STATE_FILE" ] && exit 0

read -r DATE ACC RUNNING START_EPOCH < "$STATE_FILE"

# New day — reset silently
if [ "$DATE" != "$TODAY" ]; then
    printf '%s 0 0 0\n' "$TODAY" > "$STATE_FILE"
    exit 0
fi

TOTAL=$ACC
if [ "$RUNNING" = "1" ]; then
    NOW=$(date +%s)
    TOTAL=$((ACC + NOW - START_EPOCH))
fi

# Show nothing when 00:00 and idle
[ "$TOTAL" -eq 0 ] && [ "$RUNNING" = "0" ] && exit 0

HH=$((TOTAL / 3600))
MM=$(( (TOTAL % 3600) / 60 ))

if [ "$RUNNING" = "1" ]; then
    printf '%02d.%02d \n' "$HH" "$MM"   # dot = active/running
else
    printf '%02d:%02d \n' "$HH" "$MM"   # colon = paused
fi
