#!/usr/bin/env bash
# ==============================================================================
# 02-audio-network.sh
# Exact audio and network packages currently on this machine
# ==============================================================================

set -e

echo "==> [2/6] Checking Audio & Network Packages..."

PACKAGES_AUDIO_NET=(
    # PipeWire stack
    pipewire
    pipewire-audio
    pipewire-pulse
    pipewire-alsa
    wireplumber
    alsa-utils
    rtkit

    # Network & Bluetooth
    networkmanager
    bluez-utils
)

echo "--> Installing audio & network packages via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_AUDIO_NET[@]}"

echo "--> Ensuring essential services are enabled..."
sudo systemctl enable NetworkManager.service 2>/dev/null || true
sudo systemctl enable bluetooth.service 2>/dev/null || true

echo "==> Audio & Network step completed!"
