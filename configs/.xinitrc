#!/bin/bash

# 1. Initialize X Resources (colors, fonts, X-based settings)
xrdb -merge $HOME/.Xresources

# 2. Execute the conditional xrandr logic from autostart.sh.
"$HOME/.config/dwm/autostart.sh" &
sleep 1.0

# 3. Start all background services (MUST use '&')
feh --bg-scale --scale-down --no-xinerama "$HOME/dotfiles/wallpapers/73.png" &

# Status Bar: slstatus
slstatus &


# 4. EXECUTE WINDOW MANAGER (MUST be the final line and NOT use '&')
exec dwm
