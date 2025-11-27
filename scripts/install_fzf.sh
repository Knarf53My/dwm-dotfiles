#!/bin/bash

# --- FZF Installation and Configuration Script ---

FZF_CONFIG_FILE="$HOME/.fzf.bash"
BASHRC_PATH="$HOME/.bashrc"

echo "--- FZF (Fuzzy Finder) Installation Script ---"
echo "FZF provides powerful interactive history and file search (Ctrl+R, Ctrl+T)."

# 1. Installation Check
if command -v fzf >/dev/null 2>&1; then
    echo "FZF is already installed. Skipping apt install."
else
    echo "Installing FZF using sudo apt..."
    sudo apt update
    if sudo apt install -y fzf; then
        echo "FZF successfully installed."
    else
        echo "Error: Failed to install FZF. Please check your internet connection or repository settings."
        exit 1
    fi
fi

# 2. Check for Bash Configuration
# FZF should automatically install a config file (usually .fzf.bash or similar)
# that sets up the key bindings (Ctrl+R, Ctrl+T).

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    FZF_KEY_BINDINGS_SOURCE="/usr/share/doc/fzf/examples/key-bindings.bash"
elif [ -f /usr/share/bash-completion/completions/fzf ]; then
    # On some systems, the main completion file handles the key bindings
    FZF_KEY_BINDINGS_SOURCE="/usr/share/bash-completion/completions/fzf"
else
    echo "Warning: Standard FZF key binding file not found. Key bindings might need manual setup."
fi


# 3. Ensure Key Bindings are Sourced in .bashrc
# We check if .bashrc already sources fzf before adding it.

if grep -q "fzf" "$BASHRC_PATH"; then
    echo "FZF sourcing logic already found in $BASHRC_PATH."
else
    echo "Adding FZF sourcing logic to $BASHRC_PATH..."
    cat << 'EOF_FZF_BASHRC' >> "$BASHRC_PATH"

# --- FZF (Fuzzy Finder) Configuration ---
# Source the FZF key bindings and completion scripts for interactive search.
if [ -f /usr/share/bash-completion/completions/fzf ]; then
    . /usr/share/bash-completion/completions/fzf
fi
# Alternative location check (less common, but safe)
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

EOF_FZF_BASHRC
    echo "FZF configuration added to .bashrc."
fi

# 4. Final step
echo ""
echo "✅ FZF installation complete."
echo "To activate FZF in your current session, run: source $BASHRC_PATH"
echo "Otherwise, the new settings will take effect upon the next terminal startup."

read -r -p "Would you like to load the new settings immediately? (y/N): " load_response
if [[ "$load_response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    source "$BASHRC_PATH"
    echo "Settings loaded. Try pressing Ctrl+R to test the history search!"
fi
