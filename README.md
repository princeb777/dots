# dots

Modular, minimal Arch Linux + BSPWM desktop setup and configuration backup.

## System Hardware Profile (Handpicked Drivers)
- **CPU**: Intel Core (Alder Lake-P) -> `intel-ucode`
- **iGPU**: Intel Iris Xe Graphics -> `mesa`
- **dGPU**: NVIDIA GeForce RTX 3050 Mobile -> `nvidia-open`
- **Wi-Fi**: Intel Wi-Fi 6 AX201 -> `linux-firmware-intel`
- **Ethernet**: Realtek RTL8111/8168 -> `linux-firmware-realtek`
- **Audio DSP**: Intel SOF DSP -> `sof-firmware`, `pipewire`, `wireplumber`

---

## Modular Installation Scripts (`scripts/`)

On a fresh Arch Linux install, clone and run:
```bash
git clone https://github.com/princeb777/dots.git
cd dots
./install.sh
```

You can choose to install everything automatically, or run any section individually:

| Script | Purpose & Included Packages |
| :--- | :--- |
| **`01-system-drivers.sh`** | Core system base, bootloader (`grub`, `efibootmgr`), exact hardware drivers (`intel-ucode`, `nvidia-open`, `mesa`, `sof-firmware`, `linux-firmware-intel`, `linux-firmware-realtek`), and auto-install of `paru` (AUR helper). |
| **`02-audio-network.sh`** | PipeWire audio stack (`pipewire`, `wireplumber`, `pipewire-pulse`, `pipewire-alsa`, `rtkit`), `networkmanager`, and Bluetooth (`bluez-utils`). Enables system services. |
| **`03-wm-desktop.sh`** | Window manager (`bspwm`), hotkeys (`sxhkd`), status bar (`polybar`), app launcher (`rofi`), compositor (`picom`), display manager (`lemurs`), `xlibre-meta`, and `ttf-daddytime-mono-nerd`. Sets up Lemurs BSPWM session entry. |
| **`04-control-utils.sh`** | Hardware control utilities: `brightnessctl` (backlight), `playerctl` (media), `feh` (wallpaper), `fastfetch`, `gvfs-mtp` (phone storage), `unzip`, `zip`, `vim`. |
| **`05-apps-software.sh`** | Handpicked user software: `alacritty`, `thunar`, `nemo`, `code` (VS Code), `zed`, `google-chrome`, `helium-browser-bin`, `spotify-launcher`, `telegram-desktop`, `blender`, `prismlauncher`, `docker`, `rustup`, `uv`, `claude-desktop`, `cloudflare-warp-bin`, `antigravity`, and dev runtimes. |
| **`06-deploy-configs.sh`** | Deploys all `.config/` files, `.bashrc`, and wallpapers to `$HOME`, and sets executable permissions on all bar and toggle scripts. |

---

## Complete Keyboard Shortcuts Cheat Sheet

All hotkeys are managed by `sxhkd` in `~/.config/sxhkd/sxhkdrc`.

### 1. Applications & Launchers
| Shortcut | Action | Command |
| :--- | :--- | :--- |
| **`Super + R`** | Application Launcher (Rofi) | `rofi -show drun` |
| **`Super + F`** | File Manager | `thunar` |
| **`Super + C`** | Terminal | `alacritty` |
| **`Super + V`** | Code Editor | `code` (VS Code) |
| **`Super + B`** | Web Browser | `google-chrome-stable` |
| **`Super + E`** | Secondary Browser | `helium-browser` |
| **`Super + T`** | Telegram Desktop | `Telegram` |
| **`Super + S`** | Music Streaming | `spotify-launcher` |
| **`Super + M`** | Minecraft Launcher | `prismlauncher` |
| **`Super + D`** | AI Assistant | `claude-desktop` |

### 2. Status Bar & System Controls
| Shortcut | Action | Details |
| :--- | :--- | :--- |
| **`Super + Shift + B`** | Toggle Polybar On / Off | Kills/respawns bar; windows instantly snap to top edge |
| **`Super + Escape`** | Reload Hotkeys | Reloads `sxhkd` configuration (`pkill -USR1 sxhkd`) |
| **`Super + Alt + R`** | Restart BSPWM | In-place window manager restart |
| **`Super + Alt + Q`** | Quit / Logout | Exits BSPWM session |

### 3. Media & Audio Controls
| Shortcut | Action | Details |
| :--- | :--- | :--- |
| **`Super + Ctrl + Space`** | Play / Pause | Also mapped to `XF86AudioPlay` / `XF86AudioPause` |
| **`Super + Ctrl + Left`** | Next Track | Also mapped to `XF86AudioNext` |
| **`Super + Ctrl + Right`** | Previous Track | Also mapped to `XF86AudioPrev` |
| **`XF86AudioRaiseVolume`** | Volume Up (+5%) | WirePlumber volume up (limit 100%) |
| **`XF86AudioLowerVolume`** | Volume Down (-5%) | WirePlumber volume down |
| **`XF86AudioMute`** | Mute / Unmute Audio | Toggles default audio sink mute |

### 4. Brightness Controls
| Shortcut | Action | Details |
| :--- | :--- | :--- |
| **`XF86MonBrightnessUp`** | Brightness Up (+5%) | Updates Polybar indicator in real time (<15ms) |
| **`XF86MonBrightnessDown`** | Brightness Down (-5%) | Updates Polybar indicator in real time (<15ms) |

### 5. Window Management (BSPWM)
| Shortcut | Action | Details |
| :--- | :--- | :--- |
| **`Super + Q`** | Close Window | Gracefully close focused node (`bspc node -c`) |
| **`Super + Shift + Q`** | Force Kill Window | Kill non-responsive node (`bspc node -k`) |
| **`Super + Shift + F`** | Toggle Fullscreen | Expand window to true fullscreen |
| **`Super + Space`** | Toggle Floating Mode | Switch between tiled and floating mode |
| **`Super + H / J / K / L`** | Focus Window | Move focus West, South, North, East |
| **`Super + Shift + H / J / K / L`** | Move Window | Swap window position West, South, North, East |
| **`Super + Ctrl + H / J / K / L`** | Resize Window | Expand/shrink window boundaries (-20px / +20px) |
| **`Super + Button2 (Middle Drag)`** | Move Floating Window | Drag and reposition floating window with mouse |

### 6. Workspaces & Gaps
| Shortcut | Action | Details |
| :--- | :--- | :--- |
| **`Super + [1-9, 0]`** | Switch to Workspace | Focus desktops 1 through 10 (empty ones auto-hide on bar) |
| **`Super + Shift + [1-9, 0]`** | Send Window to Workspace | Move active window to desktops 1 through 10 |
| **`Super + Alt + K`** | Increase Window Gap | Adds +1px to window gaps |
| **`Super + Alt + J`** | Decrease Window Gap | Subtracts -1px from window gaps (safely stops at 0) |
