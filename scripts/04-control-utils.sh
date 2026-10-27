#!/usr/bin/env bash
# ==============================================================================
# 04-control-utils.sh
# System control utilities (Brightness, Volume, Media, Notifications, Wallpaper)
# ==============================================================================

set -e

echo "==> [4/6] Installing Control Utilities & Hardware Tools..."

PACKAGES_UTILS=(
    # Hardware controls
    brightnessctl   # Screen backlight controller
    playerctl       # Media player MPRIS controller (Spotify, browsers)
    feh             # Wallpaper setting utility
    libnotify       # Desktop notification sender (notify-send)

    # Clipboard & File integration
    xclip           # X11 clipboard CLI
    gvfs-mtp        # Android / Phone MTP file access support
    unzip
    zip

    # System info fetcher
    fastfetch
)

echo "--> Installing utilities via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_UTILS[@]}"

echo "==> Control utilities installed successfully!"
