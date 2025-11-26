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

# Function to build a component without using a subshell for 'cd'
build() {
    local name="$1"
    local path="$2"
    echo "[Rebuilding $name]..."
    
    # 1. Safely change directory
    echo "Attempting to navigate to $path..."
    if ! cd "$path" 2>/dev/null; then
        echo "[$name ERROR: Cannot change directory to $path.]"
        echo "Please ensure the path is correct and the directory exists."
        return 1
    fi

    # 2. Check if Makefile exists before proceeding
    if [ ! -f "Makefile" ]; then
        echo "[$name ERROR: Makefile not found in $path. Aborting build.]"
        cd - >/dev/null # Go back
        return 1
    fi
    
    echo "Starting build sequence: make clean, make, sudo make install..."

    # 3. Execute the full build chain
    make clean && make && sudo make install
    BUILD_EXIT_CODE=$?
    
    # 4. Change back to the starting directory
    cd - >/dev/null

    # 5. Report result
    if [ $BUILD_EXIT_CODE -eq 0 ]; then
        echo "[$name done: SUCCESSFULLY INSTALLED]"
    else
        echo "[$name ERROR: Installation failed (Exit Code: $BUILD_EXIT_CODE). Check 'make' output for details.]"
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
        build "dwm" "$DWM_PATH"
        if [ $? -eq 0 ]; then
            build "slstatus" "$SLSTATUS_PATH"
        fi
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac
