# Vincent's Dotfiles

Niri + CachyOS setup with Catppuccin Mocha theme.

## Preview

- **WM**: Niri
- **Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Fuzzel
- **Notifications**: Dunst
- **Lock Screen**: Swaylock
- **IME**: Fcitx5 (Korean)
- **Theme**: Catppuccin Mocha (Green accent)

## Structure

```
dotfiles/
├── niri/               # Niri window manager config
├── waybar/             # Status bar
├── kitty/              # Terminal emulator
├── dunst/              # Notifications
├── swayosd/            # Volume/brightness OSD
├── swaylock/           # Lock screen (Catppuccin theme)
├── fuzzel/             # Application launcher
├── starship/           # Shell prompt
├── wlogout/            # Logout menu
├── btop/               # System monitor
├── gtk-3.0/            # GTK3 theme settings
├── gtk-4.0/            # GTK4 theme settings
├── qt5ct/              # Qt5 theme settings
├── qt6ct/              # Qt6 theme settings
├── fcitx5/             # Korean input method
├── networkmanager-dmenu/  # Network manager menu
├── background-images/  # Wallpapers
├── scripts/            # Custom scripts
├── .zshrc              # Zsh configuration
├── .gitconfig          # Git configuration
└── install.sh          # Installer script
```

## Installation

```bash
git clone https://github.com/USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Dependencies

```bash
# Core - Window Manager & Desktop
sudo pacman -S niri waybar kitty dunst fuzzel swaylock swww

# Utilities
sudo pacman -S swayosd brightnessctl playerctl grim slurp cliphist wl-clipboard

# Shell & Prompt
sudo pacman -S zsh starship zoxide eza bat fzf ripgrep fd

# System Tools
sudo pacman -S btop wlogout networkmanager-dmenu

# Korean Input
sudo pacman -S fcitx5 fcitx5-hangul fcitx5-configtool fcitx5-gtk fcitx5-qt

# Fonts (optional)
sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts-cjk
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

## SDDM Theme

See [sddm-setting.md](./sddm-setting.md) for SDDM theme setup guide.

## License

MIT
