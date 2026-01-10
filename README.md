# Vincent's Dotfiles

Hyprland + CachyOS setup with Catppuccin Mocha theme.

## Preview

- **WM**: Hyprland
- **Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Wofi
- **Notifications**: Dunst
- **Theme**: Catppuccin Mocha (Green accent)

## Structure

```
dotfiles/
├── hypr/           # Hyprland config
├── waybar/         # Status bar
├── kitty/          # Terminal
├── dunst/          # Notifications
├── wofi/           # App launcher
├── swayosd/        # Volume/brightness OSD
├── starship/       # Shell prompt
├── wlogout/        # Logout menu
├── btop/           # System monitor
├── gtk/            # GTK 3/4 themes
├── qt/             # Qt 5/6 themes
├── wallpapers/     # Background images
├── scripts/        # Custom scripts
└── install.sh      # Installer
```

## Installation

```bash
git clone https://github.com/USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Dependencies

```bash
# Core
sudo pacman -S hyprland waybar kitty dunst wofi

# Utilities
sudo pacman -S swayosd brightnessctl playerctl grim slurp cliphist

# Extras
sudo pacman -S btop starship wlogout swww
```

## SDDM Theme

Using [simple-sddm-2](https://github.com/JaKooLit/simple-sddm-2) with Catppuccin colors.

```bash
git clone https://github.com/JaKooLit/simple-sddm-2 /tmp/simple-sddm-2
sudo cp -r /tmp/simple-sddm-2 /usr/share/sddm/themes/
echo -e '[Theme]\nCurrent=simple-sddm-2' | sudo tee /etc/sddm.conf.d/theme.conf
```

## Keybindings

| Key | Action |
|-----|--------|
| Super + Space | App launcher (Wofi) |
| Super + T | Terminal |
| Super + Q | Close window |
| Super + L | Lock screen |
| Super + Shift + 3 | Screenshot (full) |
| Super + Shift + 4 | Screenshot (region) |

## License

MIT
