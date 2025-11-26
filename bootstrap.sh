#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"
SUCKLESS="$DOTFILES/suckless"

echo "==> Bootstrapping dotfiles setup..."

# -----------------------------------------------------------
# 1. Create base directories
# -----------------------------------------------------------

echo "==> Creating base directories..."
mkdir -p "$HOME/.config"
mkdir -p "$DOTFILES/aliases"
mkdir -p "$SUCKLESS/dwm"
mkdir -p "$SUCKLESS/st"
mkdir -p "$SUCKLESS/slstatus"
mkdir -p "$DOTFILES/scripts"
mkdir -p "$DOTFILES/themes"
mkdir -p "$DOTFILES/wallpapers"

# -----------------------------------------------------------
# 2. Helper: safe symlink
# -----------------------------------------------------------

link_file() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "!! Source $src does not exist, skipping"
        return
    fi

    if [ -L "$dest" ]; then
        echo "-> Replacing existing symlink $dest"
        rm -f "$dest"
    elif [ -e "$dest" ]; then
        echo "!! $dest already exists and is not a symlink, skipping"
        return
    fi

    echo "-> Linking $src → $dest"
    ln -s "$src" "$dest"
}

echo "==> Linking configuration files... (etc)"

# Bash config
link_file "$DOTFILES/configs/.bashrc" "$HOME/.bashrc"

# Vim config
link_file "$DOTFILES/configs/.vimrc" "$HOME/.vimrc"

# DWM config (autostart)
link_file "$DOTFILES/configs/.config/dwm/autostart.sh" "$HOME/.config/dwm/autostart.sh"

# Alacritty config
# Assuming you have a config file for alacritty
# link_file "$DOTFILES/configs/.config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Xorg config
link_file "$DOTFILES/configs/.xinitrc" "$HOME/.xinitrc"


# -----------------------------------------------------------
# 3. Check for .bashrc execution in .profile
# -----------------------------------------------------------

# Ensures .bashrc is sourced correctly in login shells,
# particularly for non-interactive logins used by some environments.
if [ -f "$HOME/.profile" ]; then
    if ! grep -q "\.bashrc" "$HOME/.profile"; then
        echo "==> Appending .bashrc sourcing to ~/.profile"
        echo -e "\n# Source .bashrc if it exists\nif [ -f \"\$HOME/.bashrc\" ]; then\n    . \"\$HOME/.bashrc\"\nfi" >> "$HOME/.profile"
    else
        echo "-> .bashrc sourcing already present in ~/.profile"
    fi
else
    echo "!! No ~/.profile found, you may want to link or create one."
fi

# Ensures the .xinitrc is called correctly by startx
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "startx" "$HOME/.bashrc"; then
        echo "==> Adding startx check to ~/.bashrc for TTY login"
        echo -e "\n# Start X on login if applicable\nif [ \"\$(tty)\" = \"/dev/tty1\" ]; then\n    startx\nfi" >> "$HOME/.bashrc"
    else
        echo "-> startx check already present in ~/.bashrc"
    fi
else
    echo "!! No ~/.bashrc found, you may want to link or create one."
fi

# -----------------------------------------------------------
# 4. Install essential packages (Debian-based)
# -----------------------------------------------------------

echo "==> Installing required packages (Debian)..."

sudo apt update
sudo apt install -y \
    build-essential \
    libx11-dev libxft-dev libxinerama-dev \
    libfreetype6-dev libfontconfig1-dev \
    maim xclip feh \
    pkg-config \
    xorg xinit x11-xserver-utils \
    alacritty \
    firefox-esr  /* Browser installed from Debian repository */

echo "==> Installing terminfo support... (ncurses)"
sudo apt install -y ncurses-base ncurses-term

# -----------------------------------------------------------
# 5. Initial suckless build (if sources exist)
# -----------------------------------------------------------

echo "==> Building suckless tools (if sources exist)..."

build_suckless() {
    local name="$1"
    local path="$2"

    if [ -d "$path" ]; then
        if [ -f "$path/Makefile" ]; then
            echo "--> Building $name in $path"
            (cd "$path" && sudo make clean install)
        else
            echo "!! $name: no Makefile found in $path, skipping"
        fi
    else
        echo "!! $name: directory $path does not exist, skipping"
    fi
}
build_suckless "dwm"      "$SUCKLESS/dwm"
build_suckless "slstatus" "$SUCKLESS/slstatus"

echo "==> Bootstrap complete! You should now be able to run DWM."
