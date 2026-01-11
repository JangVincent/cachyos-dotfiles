#!/bin/bash

# Vincent's Dotfiles Installer
# Hyprland + CachyOS setup

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Vincent's Dotfiles Installer ==="
echo ""

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Installing GNU Stow..."
    sudo pacman -S --noconfirm stow
fi

# Packages to stow
PACKAGES=(
    hypr
    waybar
    kitty
    dunst
    wofi
    swayosd
    starship
    wlogout
    btop
    gtk
    qt
    wallpapers
    scripts
)

# Create necessary directories
mkdir -p ~/.config
mkdir -p ~/.local/bin

# Stow all packages
echo "Creating symlinks..."
for pkg in "${PACKAGES[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        echo "  Stowing $pkg..."
        stow -v -d "$DOTFILES_DIR" -t ~ "$pkg"
    fi
done

echo ""
echo "=== Done! ==="
echo "Reload Hyprland with: hyprctl reload"
