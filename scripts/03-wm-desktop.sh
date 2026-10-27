#!/usr/bin/env bash
# ==============================================================================
# 03-wm-desktop.sh
# Exact Window Manager, Bar, Compositor & Font packages currently on this machine
# ==============================================================================

set -e

echo "==> [3/6] Checking Window Manager & Desktop Environment..."

PACKAGES_WM=(
    bspwm
    sxhkd
    polybar
    rofi
    picom
    lemurs
)

PACKAGES_AUR=(
    xlibre-meta
    ttf-daddytime-mono-nerd
)

echo "--> Installing desktop packages via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_WM[@]}"

echo "--> Installing AUR packages (XLibre & Nerd Font) via paru..."
paru -S --needed --noconfirm "${PACKAGES_AUR[@]}"

# Enable Lemurs Login Manager
echo "--> Enabling lemurs display manager..."
sudo systemctl enable lemurs.service 2>/dev/null || true

echo "==> Window Manager & Desktop step completed!"
