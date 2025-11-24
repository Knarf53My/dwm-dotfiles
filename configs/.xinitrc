# autostart applications
feh --bg-fill ~/dotfiles/wallpapers/debian.png &
~/.config/dwm/autostart.sh &
slstatus &
# tag 1 terminal (rule sends it to tag 1)
st &
# tag 2 firefox (rule sends it to tag 2)
firefox-esr &   # or flatpak run org.mozilla.firefox &
# tag 3: three terminals
st -n t3a -e bmon &
sleep 0.8
st -n t3b -e ranger &
sleep 0.8
st -n t3c -e htop &
# tag 4: Google Chrome
google-chrome &
# Autoconnect Bluetooth speaker
(
    sleep 2
    bluetoothctl power on
    bluetoothctl connect 99:D5:BC:1A:C0:95
) &

# Loading DWM
while true; do
    dwm || break
done

