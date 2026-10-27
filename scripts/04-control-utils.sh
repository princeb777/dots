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

echo "--> Installing utilities via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_UTILS[@]}"

echo "==> Control utilities step completed!"
