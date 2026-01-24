#!/bin/bash

# Vincent's Dotfiles Installer
# Niri + CachyOS setup

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Vincent's Dotfiles Installer ==="
echo ""

# ~/.config 에 링크할 폴더들
CONFIG_DIRS=(
    niri
    waybar
    kitty
    dunst
    swayosd
    starship
    wlogout
    btop
    gtk-3.0
    gtk-4.0
    qt5ct
    qt6ct
    background-images
    networkmanager-dmenu
    fuzzel
    swaylock
    fcitx5
)

# Create directories
mkdir -p ~/.config
mkdir -p ~/.local/bin

# Link config directories
echo "Creating symlinks to ~/.config..."
for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        # 기존 링크나 폴더가 있으면 제거
        rm -rf ~/.config/$dir
        ln -sf "$DOTFILES_DIR/$dir" ~/.config/$dir
        echo "  $dir → ~/.config/$dir"
    fi
done

# Link scripts to ~/.local/bin
echo ""
echo "Creating symlinks to ~/.local/bin..."
if [ -d "$DOTFILES_DIR/scripts" ]; then
    for script in "$DOTFILES_DIR/scripts"/*; do
        if [ -f "$script" ]; then
            name=$(basename "$script")
            rm -f ~/.local/bin/$name
            ln -sf "$script" ~/.local/bin/$name
            echo "  $name → ~/.local/bin/$name"
        fi
    done
fi

# Link home directory dotfiles
echo ""
echo "Creating symlinks to home directory..."
HOME_FILES=(.zshrc .gitconfig)
for file in "${HOME_FILES[@]}"; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        rm -f ~/$file
        ln -sf "$DOTFILES_DIR/$file" ~/$file
        echo "  $file → ~/$file"
    fi
done

# System configs (requires sudo)
echo ""
echo "Installing system configs (requires sudo)..."
if [ -d "$DOTFILES_DIR/keyd" ]; then
    sudo mkdir -p /etc/keyd
    sudo cp "$DOTFILES_DIR/keyd/default.conf" /etc/keyd/default.conf
    echo "  keyd/default.conf → /etc/keyd/default.conf"
    sudo systemctl restart keyd 2>/dev/null || echo "  (keyd service not running)"
fi

# Check for xwayland-satellite (required for X11 apps)
echo ""
if ! command -v xwayland-satellite &> /dev/null; then
    echo "WARNING: xwayland-satellite not found!"
    echo "  Install from AUR: paru -S xwayland-satellite"
    echo "  Required for X11/Electron apps (Slack, Spotify, etc.)"
fi

echo ""
echo "=== Done! ==="
echo "Reload Niri config or restart session"
