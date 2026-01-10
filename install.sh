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
    echo "  Stowing $pkg..."
    stow -v -d "$DOTFILES_DIR" -t ~ "$pkg"
done

echo ""
echo "=== Required packages ==="
echo "Install these if not already installed:"
echo ""
echo "sudo pacman -S hyprland waybar kitty dunst wofi swayosd brightnessctl playerctl"
echo "sudo pacman -S btop starship wlogout grim slurp cliphist swww"
echo ""
echo "=== SDDM Theme (optional) ==="
echo "git clone https://github.com/JaKooLit/simple-sddm-2 /tmp/simple-sddm-2"
echo "sudo cp -r /tmp/simple-sddm-2 /usr/share/sddm/themes/"
echo "echo -e '[Theme]\nCurrent=simple-sddm-2' | sudo tee /etc/sddm.conf.d/theme.conf"
echo ""
echo "Done! Reload Hyprland with: hyprctl reload"
