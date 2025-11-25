#!/bin/sh

# Only do anything if xrandr is available
if ! command -v xrandr >/dev/null 2>&1; then
    exit 0
fi

# Laptop internal panel
if xrandr | grep -q '^eDP-1 connected'; then
    # Laptop-only setup
    xrandr --output eDP-1 --mode 1920x1080 --primary
fi

# Desktop HDMI monitor
if xrandr | grep -q '^HDMI-1 connected'; then
    # Desktop-only setup
    xrandr --output HDMI-1 --mode 1920x1080 --primary
fi

# If you ever run a dual-screen setup, you can replace the HDMI block with e.g.:
# if xrandr | grep -q '^HDMI-1 connected'; then
#     xrandr \
#       --output HDMI-1 --mode 1920x1080 --primary \
#       --output eDP-1 --off
# fi
