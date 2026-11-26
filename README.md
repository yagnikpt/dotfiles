# Dotfiles

Personal Linux desktop setup (Umbriel + Noctalia), managed with [Tuckr](https://github.com/RaphGL/Tuckr).

Use at your own risk: this is tuned for my machine and can overwrite existing config.

## Install

```bash
git clone https://github.com/yagnikpt/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
tuckr add \*
```

Notes:
- Install required apps/fonts first.
- Some colors/assets are generated from `matugen` and may need regeneration on your machine.
- Desktop shell is [Noctalia](https://noctalia.dev) now; the older barebones setup is still available.

## What's here

`Configs/`
- `niri`, `waybar`, `rofi`, `mako`, `gammastep`, `umbriel`
- `zsh`, `ghostty`, `kitty`, `fastfetch`, `vicinae`
- `hypr` (hypridle/hyprlock), `scripts`, `matugen`

`Services/`
- user services for startup/background tasks (for example: waybar toggle, swww, gammastep, backups, noctalia)

Shell switch:
- `Configs/scripts/scripts/rofi/modules/desktop.sh` lets you switch between `Custom` (barebones) and `Noctalia`.

## Screenshots

![desktop](./main.webp)
![wallpaper picker](./wallpicker.webp)
![shell](./shell.webp)

More: [post](https://www.reddit.com/r/unixporn/comments/1oqngoz/niri_minimalist_niri_setup)
