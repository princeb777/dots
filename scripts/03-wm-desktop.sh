#!/usr/bin/env bash
# ==============================================================================
# 03-wm-desktop.sh
# Exact Window Manager, Bar, Compositor, Display Server & Font packages
# currently on this machine
# ==============================================================================

set -e

echo "==> [3/6] Checking Window Manager & Desktop Environment..."

# ------------------------------------------------------------------------------
# XLibre binary repository (packages.xlibre.net)
# XLibre replaces xorg-server; its packages come from a third-party pacman repo
# signed by the "XLibre for Arch Linux Maintainers" key pinned below.
# ------------------------------------------------------------------------------
XLIBRE_KEY_URL="https://packages.xlibre.net/arch/xlibre-archlinux.asc"
XLIBRE_KEY_FPR="0C92313001CFCA27627B9098B97F7C613F359424"

setup_xlibre_repo() {
    # Make sure the pacman keyring exists
    [ -d /etc/pacman.d/gnupg ] || sudo pacman-key --init

    # Import & locally sign the XLibre signing key (only if not already trusted)
    if ! sudo pacman-key --list-keys "$XLIBRE_KEY_FPR" &>/dev/null; then
        echo "--> Importing XLibre signing key..."
        local key_dir
        key_dir=$(mktemp -d)
        curl -fsSL -o "$key_dir/xlibre-archlinux.asc" "$XLIBRE_KEY_URL"

        local got_fpr
        got_fpr=$(gpg --show-keys --with-colons "$key_dir/xlibre-archlinux.asc" \
            | awk -F: '/^fpr:/{print $10; exit}')
        if [ "$got_fpr" != "$XLIBRE_KEY_FPR" ]; then
            echo "ERROR: XLibre key fingerprint mismatch!"
            echo "       expected $XLIBRE_KEY_FPR"
            echo "       got      ${got_fpr:-<none>}"
            rm -rf "$key_dir"
            exit 1
        fi

        sudo pacman-key --add "$key_dir/xlibre-archlinux.asc"
        rm -rf "$key_dir"
    fi
    sudo pacman-key --lsign-key "$XLIBRE_KEY_FPR"

    # Add the [xlibre-stable] repo to pacman.conf (only once)
    if ! grep -q '^\[xlibre-stable\]' /etc/pacman.conf; then
        echo "--> Adding [xlibre-stable] repository to /etc/pacman.conf..."
        sudo tee -a /etc/pacman.conf >/dev/null << 'EOF'

[xlibre-stable]
Server = https://packages.xlibre.net/arch/stable/$arch
EOF
    else
        echo "--> [xlibre-stable] repository already configured."
    fi
}

setup_xlibre_repo

# xlibre-xserver conflicts with xorg-server; --noconfirm would refuse the swap
# (pacman -Q resolves "provides", so compare the real package name)
if [ "$(pacman -Qq xorg-server 2>/dev/null)" = "xorg-server" ]; then
    echo "WARNING: xorg-server is installed and conflicts with xlibre-xserver."
    echo "         Remove it first:  sudo pacman -Rdd xorg-server"
    exit 1
fi

PACKAGES_WM=(
    # Display server (from [xlibre-stable])
    xlibre-meta

    # Window manager & desktop
    bspwm
    sxhkd
    polybar
    rofi
    picom
    lemurs

    # Font
    ttf-daddytime-mono-nerd
)

echo "--> Syncing databases & installing desktop packages via pacman..."
sudo pacman -Syu --needed --noconfirm "${PACKAGES_WM[@]}"

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
