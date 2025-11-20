#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

FOCUSED_WORKSPACE=$(aerospace list-workspaces --format "%{workspace} %{workspace-is-focused}" | awk '$2=="true"{print $1}')
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0xFF00FFFF icon.color=0xFF00FF00 label.color=0xFF00FF00 label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2
else
  sketchybar --set $NAME background.color=0x44FFFFFF icon.color=0xffffffff label.color=0xffffffff label.shadow.drawing=off icon.shadow.drawing=off background.border_width=0
fi