#!/bin/bash
if ! command -v yabai &>/dev/null; then
    echo "Error: yabai is not installed." >&2
    exit 1
fi
current_value=$(yabai -m config external_bar 2>/dev/null | awk '{print $1}')
if [ -z "$current_value" ]; then
    echo "Error: Failed to retrieve external_bar value." >&2
    exit 1
fi
if [ "$current_value" = "all:0:0" ]; then
    yabai -m config external_bar all:23:0
    echo "Set external_bar to all:23:0"
else
    yabai -m config external_bar all:0:0
    echo "Set external_bar to all:0:0"
fi