# Vincent's Dotfiles

Niri + CachyOS setup with Catppuccin Mocha theme.

## Preview

- **WM**: Niri
- **Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Fuzzel
- **Notifications**: Dunst
- **Theme**: Catppuccin Mocha (Green accent)

## Structure

```
dotfiles/
├── niri/           # Niri config
├── waybar/         # Status bar
├── kitty/          # Terminal
├── dunst/          # Notifications
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
sudo pacman -S niri waybar kitty dunst fuzzel

# Utilities
sudo pacman -S swayosd brightnessctl playerctl grim slurp cliphist swaylock

# Extras
sudo pacman -S btop starship wlogout swaybg
```

## Keybindings

| Key | Action |
|-----|--------|
| Super + Space | App launcher (Fuzzel) |
| Super + T | Terminal |
| Super + Q | Close window |
| Super + L | Lock screen |
| Super + Shift + 3 | Screenshot (full) |
| Super + Shift + 4 | Screenshot (region) |

## License

MIT
