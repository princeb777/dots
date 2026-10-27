#!/usr/bin/env bash
# ==============================================================================
# 06-deploy-configs.sh
# Deploy dotfiles, configuration scripts, and wallpapers to $HOME
# ==============================================================================

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> [6/6] Deploying configuration files & wallpapers..."

# 1. Ensure target directories exist
mkdir -p "$HOME/.config" "$HOME/Pictures/wallpapers"

# 2. Deploy .config files
echo "--> Copying .config folders (bspwm, polybar, rofi, sxhkd, picom, alacritty, fastfetch)..."
cp -rv "$ROOT_DIR/.config/"* "$HOME/.config/"

# 3. Deploy home directory files
echo "--> Copying shell dotfiles..."
cp -v "$ROOT_DIR/.bashrc" "$HOME/.bashrc"
cp -v "$ROOT_DIR/.bash_profile" "$HOME/.bash_profile"

# 4. Deploy wallpapers
if [ -d "$ROOT_DIR/wallpapers" ]; then
    echo "--> Copying wallpapers to ~/Pictures/wallpapers/..."
    cp -rv "$ROOT_DIR/wallpapers/"* "$HOME/Pictures/wallpapers/"
fi

# 5. Ensure all executable scripts have proper permissions
echo "--> Setting executable permissions..."
chmod +x "$HOME/.config/polybar/"*.sh 2>/dev/null || true
chmod +x "$HOME/.config/polybar/scripts/"*.sh 2>/dev/null || true
chmod +x "$HOME/.config/bspwm/bspwmrc" 2>/dev/null || true
chmod +x "$HOME/.config/bspwm/scripts/"*.sh 2>/dev/null || true

# 6. Initialize betterlockscreen cache if installed
if command -v betterlockscreen &>/dev/null && [ -f "$HOME/Pictures/wallpapers/anime.jpg" ]; then
    echo "--> Caching lockscreen wallpaper with betterlockscreen..."
    betterlockscreen -u "$HOME/Pictures/wallpapers/anime.jpg" 2>/dev/null || true
fi

echo "==> All configurations deployed successfully!"
