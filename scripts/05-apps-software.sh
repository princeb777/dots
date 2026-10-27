#!/usr/bin/env bash
# ==============================================================================
# 05-apps-software.sh
# User software, applications, browsers, editors & media tools
# ==============================================================================

set -e

echo "==> [5/6] Installing Applications, Browsers & Software..."

# 1. Official Pacman Software
PACKAGES_APPS=(
    # Terminal & File Management
    alacritty
    thunar
    tumbler                 # Image thumbnail generation in Thunar
    thunar-archive-plugin   # Archive integration in Thunar

    # Code Editors
    code                    # VS Code
    zed                     # High-performance editor
    vim

    # Media & Communication
    spotify-launcher
    telegram-desktop

    # Creative & Gaming
    blender
    prismlauncher           # Minecraft launcher

    # Developer Runtimes & Tools
    docker
    docker-compose
    docker-buildx
    jdk17-openjdk
    jdk25-openjdk
    gradle
    android-tools
    rustup
    uv                      # Fast Python package manager
    github-cli
    aria2
)

# 2. AUR Applications
PACKAGES_AUR=(
    # Web Browsers
    google-chrome
    helium-browser-bin

    # AI & Productivity
    claude-desktop
    cloudflare-warp-bin
)

echo "--> Installing official applications via pacman..."
sudo pacman -S --needed --noconfirm "${PACKAGES_APPS[@]}"

echo "--> Installing AUR applications via paru..."
paru -S --needed --noconfirm "${PACKAGES_AUR[@]}"

# Enable Docker service if docker is installed
if command -v docker &>/dev/null; then
    echo "--> Enabling Docker service..."
    sudo systemctl enable docker.service 2>/dev/null || true
    sudo usermod -aG docker "$USER" 2>/dev/null || true
fi

echo "==> Applications & software installed successfully!"
