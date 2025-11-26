#!/bin/bash
# Using /bin/bash explicitly as the interpreter

# Define the paths for your suckless utilities.
# These paths are now relative to your home directory ($HOME).
DWM_PATH="$HOME/dotfiles/suckless/dwm"
SLSTATUS_PATH="$HOME/dotfiles/suckless/slstatus"

echo "Which component do you want to rebuild?"
echo "1) dwm"
echo "2) slstatus"
echo "3) all"
printf "Enter number (1-3): "
read choice

build() {
    name="$1"
    path="$2"
    echo "[Rebuilding $name]..."
    
    # Use 'cd' in a subshell and check its exit status
    if (cd "$path" 2>/dev/null); then
        echo "Successfully navigated to $path. Starting build..."
        make clean && make && sudo make install
        
        # Check if 'make install' was successful
        if [ $? -eq 0 ]; then
            echo "[$name done: SUCCESSFULLY INSTALLED]"
        else
            echo "[$name ERROR: Installation failed. Check 'make' output for details.]"
        fi
    else
        echo "[$name ERROR: Cannot change directory to $path.]"
        echo "Please ensure the path is correct and the directory exists."
        exit 1
    fi
}

case "$choice" in
    1)
        build "dwm" "$DWM_PATH"
        ;;
    2)
        build "slstatus" "$SLSTATUS_PATH"
        ;;
    3)
        # Rebuilding all components.
        build "slstatus" "$SLSTATUS_PATH"
        build "dwm" "$DWM_PATH"
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 3."
        exit 1
        ;;
esac

