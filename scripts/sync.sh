#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Dotfiles Sync Script ===${NC}\n"

# Get the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/config/.config"

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory not found at $DOTFILES_DIR${NC}"
    exit 1
fi

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed${NC}"
    echo "Install it with: brew install stow"
    exit 1
fi

# Create config directory in dotfiles if it doesn't exist
mkdir -p "$DOTFILES_CONFIG_DIR"

echo -e "${YELLOW}Step 1: Finding new/updated configs...${NC}"

# Array to store folders that will be synced
declare -a SYNCED_FOLDERS=()

# Loop through all directories in ~/.config
for dir in "$CONFIG_DIR"/*/ ; do
    if [ -d "$dir" ]; then
        folder_name=$(basename "$dir")

        # Skip if it's already a symlink
        if [ -L "$CONFIG_DIR/$folder_name" ]; then
            echo "  ⏭️  Skipping $folder_name (already symlinked)"
            continue
        fi

        # Check if folder exists in dotfiles
        if [ -d "$DOTFILES_CONFIG_DIR/$folder_name" ]; then
            echo "  📝 Updating: $folder_name"
        else
            echo "  ✨ New config found: $folder_name"
        fi

        SYNCED_FOLDERS+=("$folder_name")
    fi
done

# Also check for individual files in ~/.config
for file in "$CONFIG_DIR"/* ; do
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        file_name=$(basename "$file")
        echo "  📄 Found file: $file_name"
        SYNCED_FOLDERS+=("$file_name")
    fi
done

if [ ${#SYNCED_FOLDERS[@]} -eq 0 ]; then
    echo -e "\n${GREEN}✅ No new configs to sync. Everything is up to date!${NC}"
    exit 0
fi

echo -e "\n${YELLOW}Step 2: Copying configs to dotfiles...${NC}"
for folder in "${SYNCED_FOLDERS[@]}"; do
    source_path="$CONFIG_DIR/$folder"

    # Backup existing config in dotfiles if it exists
    if [ -e "$DOTFILES_CONFIG_DIR/$folder" ]; then
        backup_name="${folder}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  💾 Backing up old config to: $backup_name"
        mv "$DOTFILES_CONFIG_DIR/$folder" "$DOTFILES_CONFIG_DIR/$backup_name"
    fi

    # Copy to dotfiles
    echo "  📋 Copying: $folder"
    cp -r "$source_path" "$DOTFILES_CONFIG_DIR/"
done

echo -e "\n${YELLOW}Step 3: Removing original configs...${NC}"
for folder in "${SYNCED_FOLDERS[@]}"; do
    if [ -e "$CONFIG_DIR/$folder" ]; then
        echo "  🗑️  Removing: $CONFIG_DIR/$folder"
        rm -rf "$CONFIG_DIR/$folder"
    fi
done

echo -e "\n${YELLOW}Step 4: Creating symlinks with stow...${NC}"
cd "$DOTFILES_DIR"
stow -R -t ~ config

echo -e "\n${YELLOW}Step 5: Verifying symlinks...${NC}"
all_good=true
for folder in "${SYNCED_FOLDERS[@]}"; do
    if [ -L "$CONFIG_DIR/$folder" ]; then
        target=$(readlink "$CONFIG_DIR/$folder")
        echo -e "  ✅ $folder → ${GREEN}$target${NC}"
    else
        echo -e "  ❌ $folder - ${RED}Symlink not created!${NC}"
        all_good=false
    fi
done

echo -e "\n${GREEN}=== Sync Summary ===${NC}"
echo "Synced ${#SYNCED_FOLDERS[@]} config(s):"
for folder in "${SYNCED_FOLDERS[@]}"; do
    echo "  • $folder"
done

if [ "$all_good" = true ]; then
    echo -e "\n${GREEN}✅ All configs synced successfully!${NC}"
    echo -e "\n${YELLOW}Next steps:${NC}"
    echo "  1. cd ~/.dotfiles"
    echo "  2. git add ."
    echo "  3. git commit -m \"Add/update configs\""
    echo "  4. git push"
else
    echo -e "\n${RED}⚠️  Some symlinks failed to create. Please check manually.${NC}"
    exit 1
fi
