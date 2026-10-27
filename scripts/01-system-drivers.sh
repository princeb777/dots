#!/usr/bin/env bash
# ==============================================================================
# 01-system-drivers.sh
# Handpicked hardware drivers & system essentials
# Targeted for: Intel Alder Lake CPU + Iris Xe iGPU + NVIDIA RTX 3050 + Realtek LAN
# ==============================================================================

set -e

echo "==> [1/6] Installing Core System & Hardware Drivers..."

# 1. Official Core System & Bootloader
PACKAGES_CORE=(
    base
    base-devel
    linux
    linux-headers
    sudo
    git
    efibootmgr
    grub
    os-prober
)

# 2. Handpicked Hardware Drivers (No excess/unneeded drivers)
PACKAGES_HARDWARE=(
    # Intel CPU microcode
    intel-ucode
    
    # Intel Alder Lake Iris Xe Graphics
    mesa
    vulkan-intel
    intel-media-driver
    
    # NVIDIA GeForce RTX 3050 Mobile
    nvidia-open
    
    # Intel Wi-Fi 6 AX201 & Bluetooth firmware
    linux-firmware-intel
    
    # Realtek RTL8111/8168 Ethernet firmware
    linux-firmware-realtek
    
    # Intel Alder Lake Sound Open Firmware (SOF DSP audio)
    sof-firmware
)

echo "--> Installing core and hardware packages via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_CORE[@]}" "${PACKAGES_HARDWARE[@]}"

# 3. Ensure Paru (AUR Helper) is installed
if ! command -v paru &>/dev/null; then
    echo "--> Paru not found. Installing paru-bin from AUR..."
    BUILD_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$BUILD_DIR"
    (cd "$BUILD_DIR" && makepkg -si --noconfirm)
    rm -rf "$BUILD_DIR"
    echo "--> Paru installed successfully."
fi

echo "==> Hardware drivers & system base installed successfully!"
