#!/bin/bash

# Sync script - Update dotfiles with latest changes from home directory
# Run this after making changes to your configs

set -e

DOTFILES_DIR="$HOME/.dotfiles"

echo "🔄 Syncing dotfiles..."

# Function to sync a directory
sync_dir() {
    local source=$1
    local dest=$2
    local name=$3
    
    if [ -d "$source" ] && [ ! -L "$source" ]; then
        echo "📦 Syncing $name..."
        rsync -av --delete "$source/" "$dest/" \
            --exclude '.DS_Store' \
            --exclude '*.log' \
            --exclude 'logs/' \
            --exclude 'cache/' \
            --exclude '.git/' \
            --exclude 'node_modules/'
        echo "   ✅ $name synced"
    fi
}

# Sync .config directories
echo ""
echo "🔧 Syncing .config directories..."
for dir in "$DOTFILES_DIR/config/.config"/*; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        if [ -d "$HOME/.config/$dirname" ] && [ ! -L "$HOME/.config/$dirname" ]; then
            sync_dir "$HOME/.config/$dirname" "$dir" "$dirname"
        fi
    fi
done

# Sync shell configs
echo ""
echo "🐚 Syncing shell configs..."
for file in .zshrc .zshenv .zprofile .p10k.zsh .bashrc .bash_profile; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        cp "$HOME/$file" "$DOTFILES_DIR/shell/"
        echo "   ✅ $file synced"
    fi
done

# Sync git configs
echo ""
echo "🔀 Syncing git configs..."
for file in .gitconfig .gitignore_global; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        cp "$HOME/$file" "$DOTFILES_DIR/git/"
        echo "   ✅ $file synced"
    fi
done

echo ""
echo "✅ Sync completed!"
echo ""
echo "📝 Next steps:"
echo "   1. Review changes: cd $DOTFILES_DIR && git status"
echo "   2. Commit changes: git add . && git commit -m 'Update configs'"
echo "   3. Push to remote: git push"
echo ""
