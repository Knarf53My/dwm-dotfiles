#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"
SUCKLESS="$DOTFILES/suckless"

echo "Which component do you want to FREEZE (sync config.h → config.def.h)?"
echo "1) dwm"
echo "2) st"
echo "3) slstatus"
echo "4) all"
printf "Enter number (1-4): "
read choice

freeze_one() {
    local name="$1"
    local path="$2"

    if [ ! -d "$path" ]; then
        echo "!! $name: directory $path does not exist, skipping"
        return
    fi

    local conf="$path/config.h"
    local def="$path/config.def.h"

    if [ ! -f "$conf" ]; then
        echo "!! $name: no config.h found in $path, nothing to freeze"
        return
    fi

    if [ -f "$def" ]; then
        local backup="${def}.backup-$(date +%Y%m%d-%H%M%S)"
        echo "-> Backing up existing config.def.h to $backup"
        cp "$def" "$backup"
    else
        echo "-> No existing config.def.h, creating new"
    fi

    echo "-> Copying config.h → config.def.h for $name"
    cp "$conf" "$def"

    echo "-> Removing config.h for $name"
    rm -f "$conf"

    if [ -f "$path/Makefile" ]; then
        echo "[Rebuilding $name after freeze]..."
        (cd "$path" && make clean && make && sudo make install)
        echo "[$name freeze + rebuild done]"
    else
        echo "!! $name: Makefile missing in $path, skipping build"
    fi
}

case "$choice" in
    1)
        freeze_one "dwm"      "$SUCKLESS/dwm"
        ;;
    2)
        freeze_one "st"       "$SUCKLESS/st"
        ;;
    3)
        freeze_one "slstatus" "$SUCKLESS/slstatus"
        ;;
    4)
        freeze_one "dwm"      "$SUCKLESS/dwm"
        freeze_one "st"       "$SUCKLESS/st"
        freeze_one "slstatus" "$SUCKLESS/slstatus"
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

echo "Freeze operation complete."
echo "You can now commit config.def.h to git as the canonical config."
