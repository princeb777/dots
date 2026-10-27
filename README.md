# dots

Minimal Arch Linux + BSPWM desktop configuration.

## Features
- **Window Manager**: `bspwm` + `sxhkd`
- **Status Bar**: `polybar` (floating dock, Cyber/Fortnite purple & cyan theme, zero empty workspaces)
- **App Launcher & Menus**: `rofi` (themed with custom magenta/cyan palette, Wi-Fi & Bluetooth managers)
- **Compositor**: `picom` (glx backend, 4px corner radius matching the bar)
- **Terminal**: `alacritty` + DaddyTimeMono Nerd Font

## Keybindings Cheat Sheet
| Shortcut | Action |
| :--- | :--- |
| `Super + Shift + B` | Toggle Polybar on/off (snaps windows to full screen) |
| `Super + R` | Rofi Application Launcher |
| `Super + Space` | Toggle floating mode for window |
| `Super + [1-9, 0]` | Switch to desktop (empty ones auto-hide on bar) |
| `Super + Shift + [1-9, 0]` | Send window to desktop |
| `Super + Ctrl + Space` | Play / Pause media |
| `Super + Ctrl + Left` | Next track |
| `Super + Ctrl + Right` | Previous track |
| `Super + Alt + Q` | Quit bspwm |
| `Super + Alt + R` | Restart bspwm |

## Quick Deploy / Restore
```bash
./install.sh
```
