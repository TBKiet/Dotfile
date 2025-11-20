#!/bin/bash

# Dotfiles installer using GNU Stow
# Author: TBKiet
# Date: 2025-11-21

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logo
print_logo() {
    echo -e "${CYAN}"
    cat << "EOF"
    ____        __  _____ __         
   / __ \____  / /_/ __(_) /__  _____
  / / / / __ \/ __/ /_/ / / _ \/ ___/
 / /_/ / /_/ / /_/ __/ / /  __(__  ) 
/_____/\____/\__/_/ /_/_/\___/____/  
                                      
EOF
    echo -e "${NC}"
}

print_logo

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}❌ This script is designed for macOS only${NC}"
    exit 1
fi

echo -e "${CYAN}🚀 Starting dotfiles installation...${NC}\n"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${YELLOW}⚠️  GNU Stow not found. Installing via Homebrew...${NC}"
    if ! command -v brew &> /dev/null; then
        echo -e "${RED}❌ Homebrew not found. Please install Homebrew first:${NC}"
        echo -e "${BLUE}   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${NC}"
        exit 1
    fi
    brew install stow
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "${BLUE}📁 Dotfiles directory: ${DOTFILES_DIR}${NC}\n"

# Function to backup existing files
backup_existing() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$backup_dir"
        mv "$file" "$backup_dir/"
        echo -e "${YELLOW}   ⚠️  Backed up existing file: $file -> $backup_dir${NC}"
    fi
}

# Function to stow a package
stow_package() {
    local package=$1
    local target_dir=${2:-$HOME}
    
    echo -e "${CYAN}📦 Installing $package...${NC}"
    
    # Remove existing symlinks if they exist
    if [ -d "$DOTFILES_DIR/$package" ]; then
        cd "$DOTFILES_DIR"
        stow -D "$package" -t "$target_dir" 2>/dev/null || true
        stow "$package" -t "$target_dir"
        echo -e "${GREEN}   ✅ $package installed${NC}"
    else
        echo -e "${YELLOW}   ⚠️  $package directory not found, skipping${NC}"
    fi
}

# Backup and remove old symlinks
echo -e "${BLUE}🔧 Cleaning up old configurations...${NC}"
for link in ~/.bash_profile ~/.bashrc ~/.zshrc ~/.zshenv ~/.zprofile ~/.p10k.zsh ~/.gitconfig ~/.gitignore_global; do
    if [ -L "$link" ]; then
        rm "$link"
        echo -e "${GREEN}   ✅ Removed old symlink: $link${NC}"
    elif [ -f "$link" ]; then
        backup_existing "$link"
    fi
done

echo ""

# Install packages with GNU Stow
stow_package "shell"
stow_package "git"
stow_package "config"

echo ""
echo -e "${GREEN}✅ Dotfiles installation completed!${NC}"
echo ""
echo -e "${CYAN}📝 Next steps:${NC}"
echo -e "${BLUE}   1. Restart your terminal or run: source ~/.zshrc${NC}"
echo -e "${BLUE}   2. Install Homebrew packages: brew bundle install --file=$DOTFILES_DIR/Brewfile${NC}"
echo -e "${BLUE}   3. Review your configurations in: $DOTFILES_DIR${NC}"
echo ""
echo -e "${YELLOW}💡 To uninstall, run: cd $DOTFILES_DIR && stow -D shell git config${NC}"
echo ""
