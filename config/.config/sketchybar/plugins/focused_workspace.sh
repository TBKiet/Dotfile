#!/bin/bash
focused=$(aerospace list-workspaces --focused --format '%{workspace}')
sketchybar --set "$NAME" label="$focused" 