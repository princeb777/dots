#!/usr/bin/env bash
# ==============================================================================
# 02-audio-network.sh
# Audio subsystem (PipeWire), Networking (NetworkManager), and Bluetooth (Bluez)
# ==============================================================================

set -e

echo "==> [2/6] Installing Audio, Network & Bluetooth Essentials..."

PACKAGES_AUDIO_NET=(
    # PipeWire Audio Stack
    pipewire
    pipewire-audio
    pipewire-pulse
    pipewire-alsa
    wireplumber
    alsa-utils
    rtkit

    # Networking
    networkmanager
    network-manager-applet

    # Bluetooth
    bluez
    bluez-utils
)

echo "--> Installing packages via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_AUDIO_NET[@]}"

echo "--> Enabling essential services..."
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service

echo "==> Audio, Network & Bluetooth setup completed!"
