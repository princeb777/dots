#!/usr/bin/env bash
# ==============================================================================
# 03-wm-desktop.sh
# Window Manager, Bar, Compositor, Display Manager & Lockscreen
# ==============================================================================

set -e

echo "==> [3/6] Installing BSPWM Desktop, Polybar, Lemurs & Lockscreen..."

# 1. Official Packages
PACKAGES_WM=(
    # X11 Display Server & Tools
    xorg-server
    xorg-xinit
    xorg-xrandr
    xorg-xprop
    xorg-setxkbmap

    # Window Manager & Hotkeys
    bspwm
    sxhkd

    # Status Bar & App Launcher
    polybar
    rofi

    # Compositor
    picom

    # Display / Login Manager
    lemurs
)

# 2. AUR Packages
PACKAGES_AUR=(
    # DaddyTimeMono Nerd Font (used across polybar, rofi & terminal)
    ttf-daddytime-mono-nerd

    # Minimal blur lockscreen
    betterlockscreen
)

echo "--> Installing desktop packages via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_WM[@]}"

echo "--> Installing AUR packages (fonts & lockscreen) via paru..."
paru -S --needed --noconfirm "${PACKAGES_AUR[@]}"

# Enable Lemurs Login Manager
echo "--> Enabling lemurs display manager..."
sudo systemctl enable lemurs.service 2>/dev/null || true

echo "==> Window manager & desktop environment installed successfully!"
