#!/bin/sh

STATE_FILE="$HOME/.local/share/dwm-timer/state"
SIGNAL=8
TODAY=$(date +%Y-%m-%d)
NOW=$(date +%s)

mkdir -p "$(dirname "$STATE_FILE")"

if [ ! -f "$STATE_FILE" ]; then
    printf '%s 0 0 0\n' "$TODAY" > "$STATE_FILE"
fi

read -r DATE ACC RUNNING START_EPOCH < "$STATE_FILE"

if [ "$DATE" != "$TODAY" ]; then
    LOG="$HOME/.local/share/dwm-timer/log"
    TOTAL=$ACC
    [ "$RUNNING" = "1" ] && TOTAL=$((ACC + NOW - START_EPOCH))
    HH=$((TOTAL / 3600))
    MM=$(( (TOTAL % 3600) / 60 ))
    printf '%s  %02d:%02d\n' "$DATE" "$HH" "$MM" >> "$LOG"

    ACC=0
    RUNNING=0
    START_EPOCH=0
fi

if [ "$RUNNING" = "1" ]; then
    ELAPSED=$((NOW - START_EPOCH))
    printf '%s %d 0 0\n' "$TODAY" "$((ACC + ELAPSED))" > "$STATE_FILE"
else
    printf '%s %d 1 %d\n' "$TODAY" "$ACC" "$NOW" > "$STATE_FILE"
fi

pkill -RTMIN+"$SIGNAL" dwmblocks
