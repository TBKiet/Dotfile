#!/bin/bash

# Get total CPU usage (user + sys)
cpu_total=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
# Get number of logical cores
cores=$(sysctl -n hw.logicalcpu)
# Calculate average usage per core
cpu=$(echo "$cpu_total $cores" | awk '{printf "%.1f", $1/$2}')

# Get RAM usage (used in GB)
mem_used=$(vm_stat | awk '/Pages active/ {active=$3} /Pages wired down/ {wired=$4} /Pages occupied by compressor/ {comp=$5} END {print (active+wired+comp)*4096/1024/1024/1024}')
mem_used=$(printf "%.1f" "$mem_used")

# Output for SketchyBar
sketchybar --set "$NAME" label="CPU: ${cpu}%  RAM: ${mem_used}Gb" 