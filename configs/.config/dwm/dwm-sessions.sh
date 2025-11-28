#!/bin/bash

# This script is executed directly by LightDM to ensure a clean session start.

# 1. Initialize X Resources (colors, fonts, X-based settings)
xrdb -merge "$HOME/.Xresources" &

# 2. Execute xrandr/autostart logic. 
# This runs your monitor configuration (autostart.sh)
"$HOME/.config/dwm/autostart.sh" &
sleep 1.0

# 3. Start all background services 
feh --bg-scale --scale-down --no-xinerama "$HOME/dotfiles/wallpapers/nm.png" &
"$HOME/dotfiles/suckless/slstatus/slstatus" &

# --- APPLICATION LAUNCHES ---
# Applications are placed on specific tags via rules in config.h
# Tag 1: Terminal
alacritty &

# Tag 2: Firefox
firefox-esr &

# --- AUDIO FIX: Source D-Bus environment for systemd user units ---
# This sources environment variables to let DWM and terminals connect to PulseAudio/PipeWire.
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi
# -----------------------------------------------------------------

# 4. EXECUTE WINDOW MANAGER
# CRITICAL: This MUST be the last command, and it MUST use 'exec'.
exec dwm
