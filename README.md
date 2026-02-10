# Vincent's Dotfiles

Niri + CachyOS setup with Catppuccin Mocha theme.

## Preview

- **WM**: Niri
- **Bar**: Waybar
- **Terminal**: Kitty
- **Launcher**: Fuzzel
- **Notifications**: Dunst
- **Lock Screen**: Swaylock
- **File Manager (GUI)**: Thunar
- **File Manager (TUI)**: Yazi
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
├── yazi/               # Terminal file manager
├── keyd/               # Key remapping (system config)
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
paru -S niri waybar kitty dunst fuzzel swaylock swww

# XWayland support (AUR)
paru -S xwayland-satellite

# File Manager
paru -S thunar tumbler yazi-nightly-bin

# Utilities
paru -S swayosd brightnessctl playerctl grim slurp cliphist wl-clipboard

# Shell & Prompt
paru -S zsh starship zoxide eza bat fzf ripgrep fd

# System Tools
paru -S btop wlogout networkmanager-dmenu keyd

# Korean Input
paru -S fcitx5 fcitx5-hangul fcitx5-configtool fcitx5-gtk fcitx5-qt

# Neovim & Development
paru -S tree-sitter-cli

# Fonts (optional)
paru -S ttf-jetbrains-mono-nerd noto-fonts-cjk
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
