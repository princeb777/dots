#!/usr/bin/env bash
# Deploy dotfiles to current user environment

set -e
DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Deploying configuration files..."
mkdir -p "$HOME/.config" "$HOME/Pictures/wallpapers"

# Copy configurations
cp -rv "$DOTS_DIR/.config/"* "$HOME/.config/"
cp -v "$DOTS_DIR/.bashrc" "$HOME/.bashrc"
cp -v "$DOTS_DIR/.bash_profile" "$HOME/.bash_profile"

# Copy wallpapers
if [ -d "$DOTS_DIR/wallpapers" ]; then
    cp -rv "$DOTS_DIR/wallpapers/"* "$HOME/Pictures/wallpapers/" || true
fi

# Make scripts executable
chmod +x "$HOME/.config/polybar/"*.sh 2>/dev/null || true
chmod +x "$HOME/.config/polybar/scripts/"*.sh 2>/dev/null || true
chmod +x "$HOME/.config/bspwm/bspwmrc" 2>/dev/null || true
chmod +x "$HOME/.config/bspwm/scripts/"*.sh 2>/dev/null || true

echo "==> Configurations deployed successfully!"
