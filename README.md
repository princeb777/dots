# dots

Modular, minimal Arch Linux + BSPWM desktop setup and configuration backup.

## System Hardware Profile (Handpicked Drivers)
- **CPU**: Intel Core (Alder Lake-P) -> `intel-ucode`
- **iGPU**: Intel Iris Xe Graphics -> `mesa`, `vulkan-intel`, `intel-media-driver` (VA-API)
- **dGPU**: NVIDIA GeForce RTX 3050 Mobile -> `nvidia-open`
- **Wi-Fi**: Intel Wi-Fi 6 AX201 -> `linux-firmware-intel`
- **Ethernet**: Realtek RTL8111/8168 -> `linux-firmware-realtek`
- **Audio DSP**: Intel SOF DSP -> `sof-firmware`, `pipewire`, `wireplumber`

---

## Modular Installation Scripts (`scripts/`)

On a fresh Arch Linux install, clone and run:
```bash
git clone ~/Project/dots
cd dots
./install.sh
```

You can choose to install everything automatically, or run any section individually:

| Script | Purpose & Included Packages |
| :--- | :--- |
| **`01-system-drivers.sh`** | Core system base, bootloader (`grub`, `efibootmgr`), exact hardware drivers (`intel-ucode`, `nvidia-open`, `mesa`, `vulkan-intel`, `intel-media-driver`, `sof-firmware`, `linux-firmware-intel`, `linux-firmware-realtek`), and auto-install of `paru` (AUR helper). |
| **`02-audio-network.sh`** | PipeWire audio stack (`pipewire`, `wireplumber`, `pipewire-pulse`, `pipewire-alsa`, `rtkit`), `networkmanager`, `network-manager-applet`, and Bluetooth (`bluez`, `bluez-utils`). Enables system services. |
| **`03-wm-desktop.sh`** | X11 display server (`xorg-server`, `xorg-xinit`, `xorg-xrandr`), window manager (`bspwm`), hotkeys (`sxhkd`), status bar (`polybar`), app launcher (`rofi`), compositor (`picom`), display manager (`lemurs`), lockscreen (`betterlockscreen`), and `ttf-daddytime-mono-nerd`. |
| **`04-control-utils.sh`** | Hardware control utilities: `brightnessctl` (backlight), `playerctl` (media), `feh` (wallpaper), `libnotify` (`notify-send`), `xclip`, `gvfs-mtp` (phone storage), and `fastfetch`. |
| **`05-apps-software.sh`** | Handpicked user software: `alacritty`, `thunar`, `google-chrome`, `code` (VS Code), `zed`, `spotify-launcher`, `telegram-desktop`, `blender`, `prismlauncher`, `docker`, `rustup`, `uv`, and dev runtimes. |
| **`06-deploy-configs.sh`** | Deploys all `.config/` files, `.bashrc`, and wallpapers to `$HOME`, marks scripts executable, and caches the lockscreen wallpaper. |

---

## Desktop Keybindings Cheat Sheet

| Shortcut | Action |
| :--- | :--- |
| **`Super + Shift + B`** | Toggle Polybar on/off (windows instantly snap to full screen) |
| **`Super + R`** | Rofi App Launcher (Cyber / Fortnite Neon theme) |
| **`Super + Space`** | Toggle floating window mode |
| **`Super + [1-9, 0]`** | Switch workspace (empty workspaces automatically hide) |
| **`Super + Shift + [1-9, 0]`** | Move window to workspace |
| **`Super + Ctrl + Space`** | Play / Pause media |
| **`Super + Ctrl + Left`** | Next track |
| **`Super + Ctrl + Right`** | Previous track |
| **`Super + Alt + Q`** | Quit BSPWM |
| **`Super + Alt + R`** | Restart BSPWM |
