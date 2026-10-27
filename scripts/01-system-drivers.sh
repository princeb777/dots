#!/usr/bin/env bash
# ==============================================================================
# 01-system-drivers.sh
# Core base system & exact hardware drivers currently on this machine
# ==============================================================================

set -e

echo "==> [1/6] Checking Core System & Hardware Drivers..."

PACKAGES_SYSTEM=(
    # Core system & boot
    base
    base-devel
    linux
    sudo
    git
    efibootmgr
    grub
    os-prober

    # Exact hardware drivers
    intel-ucode
    mesa
    nvidia-open
    linux-firmware-intel
    linux-firmware-realtek
    sof-firmware
)

echo "--> Installing core & hardware drivers via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_SYSTEM[@]}"

# Ensure Paru (AUR Helper) is installed
if ! command -v paru &>/dev/null; then
    echo "--> Paru not found. Installing paru-bin from AUR..."
    BUILD_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$BUILD_DIR"
    (cd "$BUILD_DIR" && makepkg -si --noconfirm)
    rm -rf "$BUILD_DIR"
fi

echo "==> Hardware drivers & system base step completed!"
