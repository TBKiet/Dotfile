# 🎨 Dotfiles

Personal macOS configuration files managed with GNU Stow.

## 📦 Structure

```
dotfiles/
├── config/          # .config directory packages
│   └── .config/
│       ├── aerospace/
│       ├── alacritty/
│       ├── nvim/
│       ├── sketchybar/
│       ├── yabai/
│       └── ...
├── shell/           # Shell configurations
│   ├── .zshrc
│   ├── .zshenv
│   ├── .zprofile
│   ├── .p10k.zsh
│   ├── .bashrc
│   └── .bash_profile
├── git/             # Git configurations
│   ├── .gitconfig
│   └── .gitignore_global
├── scripts/         # Helper scripts
├── Brewfile         # Homebrew packages
├── install.sh       # Installation script
└── README.md        # This file
```

## 🚀 Installation

### Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)

### Quick Install

```bash
# Clone this repository
git clone https://github.com/TBKiet/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installation script
chmod +x install.sh
./install.sh
```

### Manual Install

```bash
# Install GNU Stow if not already installed
brew install stow

# Clone the repository
git clone https://github.com/TBKiet/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install specific packages
stow shell    # Shell configurations
stow git      # Git configurations
stow config   # .config directory files

# Install all packages
stow */
```

## 🔧 Usage

### Installing a package

```bash
cd ~/dotfiles
stow <package-name>
```

Example:
```bash
stow shell  # Creates symlinks for shell configs
stow git    # Creates symlinks for git configs
```

### Uninstalling a package

```bash
cd ~/dotfiles
stow -D <package-name>
```

Example:
```bash
stow -D shell  # Removes symlinks for shell configs
```

### Reinstalling a package

```bash
cd ~/dotfiles
stow -R <package-name>
```

## 📝 What's Included

### Shell
- **Zsh** with Oh My Zsh
- **Powerlevel10k** theme
- Custom aliases and functions
- Environment variables

### Applications
- **Neovim** - Text editor configuration
- **Alacritty** - Terminal emulator
- **Yabai** - Tiling window manager
- **SKHD** - Hotkey daemon
- **Sketchybar** - Custom menu bar
- **Aerospace** - Window manager
- **Karabiner** - Keyboard customization
- And more...

### Git
- Git aliases
- Global gitignore
- Git configurations

## 🎯 Features

- ✅ Clean and organized structure
- ✅ Easy to install and uninstall
- ✅ Automatic backup of existing configs
- ✅ Modular package system
- ✅ Version controlled with Git
- ✅ Cross-machine sync ready

## 🔄 Updating

```bash
cd ~/dotfiles
git pull origin main

# Restow packages to update symlinks
stow -R shell git config
```

## 🗑️ Uninstalling

```bash
cd ~/dotfiles

# Remove all symlinks
stow -D shell git config

# Or remove specific package
stow -D shell
```

## 📚 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Dotfiles Guide](https://dotfiles.github.io/)

## 📄 License

MIT

## 👤 Author

**TBKiet**

---

⭐ If you find this useful, consider giving it a star!
