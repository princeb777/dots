#!/usr/bin/env bash
# ==============================================================================
# Master Arch Linux Setup & Restore Script
# Installs exact hardware drivers, desktop environment, and applications
# ==============================================================================

set -e

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/scripts" && pwd)"

if [ "$EUID" -eq 0 ]; then
    echo "ERROR: Please run this script as a normal user with sudo privileges, NOT as root."
    exit 1
fi

show_menu() {
    clear
    echo "=========================================================="
    echo "       ARCH LINUX CUSTOM DESKTOP INSTALLER (BSPWM)        "
    echo "=========================================================="
    echo " 1) Complete Setup (Run all steps sequentially)"
    echo " 2) Hardware Drivers & System Core (Intel + NVIDIA + Realtek)"
    echo " 3) Audio, Network & Bluetooth (PipeWire + NetworkManager + Bluez)"
    echo " 4) Window Manager & Desktop (BSPWM + Polybar + Rofi + Lemurs)"
    echo " 5) Control Utilities (Brightness, Media, Wallpaper, Notifications)"
    echo " 6) User Applications (Chrome, VS Code, Zed, Spotify, etc.)"
    echo " 7) Deploy Configuration Files & Wallpapers Only"
    echo " q) Quit"
    echo "=========================================================="
    read -rp "Select an option [1-7/q]: " choice
}

run_all() {
    echo "Starting full automated installation..."
    "$SCRIPTS_DIR/01-system-drivers.sh"
    "$SCRIPTS_DIR/02-audio-network.sh"
    "$SCRIPTS_DIR/03-wm-desktop.sh"
    "$SCRIPTS_DIR/04-control-utils.sh"
    "$SCRIPTS_DIR/05-apps-software.sh"
    "$SCRIPTS_DIR/06-deploy-configs.sh"
    echo ""
    echo "=========================================================="
    echo " Installation complete! You can now reboot into your desktop."
    echo "=========================================================="
}

if [ "$1" = "--all" ]; then
    run_all
    exit 0
fi

while true; do
    show_menu
    case "$choice" in
        1)
            run_all
            break
            ;;
        2)
            "$SCRIPTS_DIR/01-system-drivers.sh"
            read -rp "Press Enter to continue..."
            ;;
        3)
            "$SCRIPTS_DIR/02-audio-network.sh"
            read -rp "Press Enter to continue..."
            ;;
        4)
            "$SCRIPTS_DIR/03-wm-desktop.sh"
            read -rp "Press Enter to continue..."
            ;;
        5)
            "$SCRIPTS_DIR/04-control-utils.sh"
            read -rp "Press Enter to continue..."
            ;;
        6)
            "$SCRIPTS_DIR/05-apps-software.sh"
            read -rp "Press Enter to continue..."
            ;;
        7)
            "$SCRIPTS_DIR/06-deploy-configs.sh"
            read -rp "Press Enter to continue..."
            ;;
        q|Q)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1-7 or q."
            sleep 1
            ;;
    esac
done
