#!/bin/bash

# Random Pokemon selector script for fastfetch
POKEMON_DIR="/Users/Kiet/pokemon-colorscripts/colorscripts/small/regular"

# Get random Pokemon
RANDOM_POKEMON=$(ls "$POKEMON_DIR" | shuf -n 1)
echo "$POKEMON_DIR/$RANDOM_POKEMON" 