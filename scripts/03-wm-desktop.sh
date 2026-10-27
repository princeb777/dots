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

# Setup Lemurs BSPWM session file
if [ -d /etc/lemurs/wms ]; then
    echo "--> Configuring Lemurs bspwm session entry..."
    sudo tee /etc/lemurs/wms/bspwm >/dev/null << 'EOF'
sxhkd &
exec bspwm
EOF
    sudo chmod +x /etc/lemurs/wms/bspwm 2>/dev/null || true
fi

echo "==> Window Manager & Desktop step completed!"
