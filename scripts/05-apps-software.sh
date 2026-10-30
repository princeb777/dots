#!/usr/bin/env bash
# ==============================================================================
# 05-apps-software.sh
# Exact applications, browsers, editors & tools currently on this machine
# ==============================================================================

set -e

echo "==> [5/6] Checking Applications & Software..."

PACKAGES_APPS=(
    alacritty
    thunar
    nemo
    code
    zed
    spotify-launcher
    telegram-desktop
    blender
    prismlauncher
    docker
    docker-compose
    docker-buildx
    jdk17-openjdk
    jdk25-openjdk
    gradle
    android-tools
    rustup
    uv
    github-cli
    aria2
    python-cattrs
)

PACKAGES_AUR=(
    google-chrome
    helium-browser-bin
    claude-desktop
    cloudflare-warp-bin
    bluetuith
    antigravity
)

echo "--> Installing official applications via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_APPS[@]}"

echo "--> Installing AUR applications via paru..."
paru -S --needed --noconfirm "${PACKAGES_AUR[@]}"

# Enable Cloudflare WARP daemon
sudo systemctl enable warp-svc.service 2>/dev/null || true

# Ensure docker service is enabled
if command -v docker &>/dev/null; then
    sudo systemctl enable docker.service 2>/dev/null || true
    sudo usermod -aG docker "$USER" 2>/dev/null || true
fi

echo "==> Applications step completed!"
