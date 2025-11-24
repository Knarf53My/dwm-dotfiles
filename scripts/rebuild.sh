#!/bin/sh

echo "Which component do you want to rebuild?"
echo "1) dwm"
echo "2) st"
echo "3) slstatus"
echo "4) all"
printf "Enter number (1-4): "
read choice

build() {
    name="$1"
    path="$2"
    echo "[Rebuilding $name]..."
    (cd "$path" && make clean && make && sudo make install)
    echo "[$name done]"
}

case "$choice" in
    1)
        build "dwm" "$HOME/dwm"
        ;;
    2)
        build "st" "$HOME/st"
        ;;
    3)
        build "slstatus" "$HOME/slstatus"
        ;;
    4)
        build "slstatus" "$HOME/slstatus"
        build "st" "$HOME/st"
        build "dwm" "$HOME/dwm"
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac
