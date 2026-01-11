#!/bin/bash

# Vincent's Dotfiles Installer
# Hyprland + CachyOS setup

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Vincent's Dotfiles Installer ==="
echo ""

# ~/.config 에 링크할 폴더들
CONFIG_DIRS=(
    hypr
    waybar
    kitty
    dunst
    wofi
    swayosd
    starship
    wlogout
    btop
    gtk-3.0
    gtk-4.0
    qt5ct
    qt6ct
    background-images
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

echo ""
echo "=== Done! ==="
echo "Reload Hyprland with: hyprctl reload"
