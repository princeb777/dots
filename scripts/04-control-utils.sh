#!/usr/bin/env bash
# ==============================================================================
# 04-control-utils.sh
# Exact hardware control & CLI utilities currently on this machine
# ==============================================================================

set -e

echo "==> [4/6] Checking Control Utilities & Tools..."

PACKAGES_UTILS=(
    brightnessctl
    playerctl
    feh
    gvfs-mtp
    fastfetch
    unzip
    zip
    vim
)

PACKAGES_AUR=(
    python-pywal16   # wallpaper -> color scheme (alacritty via ~/.config/wal/templates)
)

echo "--> Installing utilities via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_UTILS[@]}"

echo "--> Installing AUR utilities (pywal16) via paru..."
paru -S --needed --noconfirm "${PACKAGES_AUR[@]}"

echo "==> Control utilities step completed!"
