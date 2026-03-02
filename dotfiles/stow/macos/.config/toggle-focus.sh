#!/bin/bash

STATE_FILE="$HOME/.focus_mode_state"

if [ -f "$STATE_FILE" ]; then
    # Turn OFF
    skhd --stop-service
    yabai --stop-service
    defaults write com.apple.dock autohide -bool false
    defaults delete com.apple.dock autohide-delay
    killall Dock
    rm "$STATE_FILE"
    osascript -e 'display notification "Focus mode OFF" with title "Toggle"'
else
    # Turn ON
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 1000
    killall Dock
    sleep 2 
    yabai --start-service
    skhd --start-service
    touch "$STATE_FILE"
    osascript -e 'display notification "Focus mode ON" with title "Toggle"'
fi
