#!/bin/bash

# 1. Initialize X Resources (colors, fonts, X-based settings)
xrdb -merge $HOME/.Xresources

# 2. CRITICAL FIX: SET RESOLUTION AND THEN PAUSE
# Execute the conditional xrandr logic from autostart.sh.
# This MUST run BEFORE feh to ensure the correct resolution is set.
"$HOME/.config/dwm/autostart.sh" &
sleep 1.0

# 3. Start all background services (MUST use '&')
# These processes run alongside DWM and keep the session active.

# Wallpaper (FEH): Now runs AFTER xrandr has set the correct resolution.
feh --bg-scale --scale-down --no-xinerama "$HOME/dotfiles/wallpapers/debian.png" &

# Status Bar: slstatus
slstatus &

# 4. AUTO-STARTED TERMINALS AND APPLICATIONS (MUST use '&')

# Tag 2 terminal
alacritty --class Alacritty,t2 &
sleep 1.0

# Tag 6 — three monitoring terminals
alacritty --class Alacritty,t6a &
sleep 0.8
alacritty --class Alacritty,t6b &
sleep 0.8
alacritty --class Alacritty,t6c &

# 5. EXECUTE WINDOW MANAGER (MUST be the final line and NOT use '&')
# DWM is configured to view Tag 1 (the empty wallpaper) first by default.
exec dwm
