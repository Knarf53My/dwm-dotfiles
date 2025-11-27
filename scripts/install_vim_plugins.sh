#!/bin/bash

VIMRC_PATH="$HOME/.vimrc"
VIM_PLUG_URL='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
PLUG_DIR="$HOME/.local/share/nvim/site/autoload/plug.vim" # For Neovim compatibility
PLUG_DIR_FALLBACK="$HOME/.vim/autoload/plug.vim"         # For standard Vim

echo "--- Vim Customization Bootstrap Script ---"
echo "This script installs Vim-Plug, creates a minimal .vimrc, and prepares plugins."

# --- 1. Install Vim-Plug (The Plugin Manager) ---
if [ ! -f "$PLUG_DIR" ] && [ ! -f "$PLUG_DIR_FALLBACK" ]; then
    echo "Vim-Plug not found. Installing now..."
    
    # Check if we should use the standard Vim directory or the Neovim directory
    if command -v nvim >/dev/null 2>&1; then
        # Install for Neovim (if nvim is detected)
        curl -fLo "$PLUG_DIR" --create-dirs "$VIM_PLUG_URL"
        echo "Vim-Plug installed to Neovim path."
    elif command -v vim >/dev/null 2>&1; then
        # Install for standard Vim
        curl -fLo "$PLUG_DIR_FALLBACK" --create-dirs "$VIM_PLUG_URL"
        echo "Vim-Plug installed to standard Vim path."
    else
        echo "Error: Neither 'vim' nor 'nvim' command found. Cannot install Vim-Plug."
        # We don't exit here, in case the user wants to manually install Vim/Neovim later, 
        # but the .vimrc file is still created.
    fi
else
    echo "Vim-Plug already installed. Skipping plugin manager install."
fi

# --- 2. Create the Minimal .vimrc ---
echo "Creating/Overwriting minimal .vimrc at $VIMRC_PATH..."

# Write the minimal .vimrc content 
cat << EOF_VIMRC > "$VIMRC_PATH"
" --- Minimal and Colorful .vimrc ---
" This file sets up basic features and loads a clean theme.

" --- Minimal and Colorful .vimrc for Dotfiles Repo ---
" This file sets up basic features and essential plugins.
" Users can uncomment their preferred theme below.

" 1. Required settings for plugins/colors
set nocompatible              " Be iMproved, required for plugins
filetype off                  " Required for Vim-Plug

" 2. Enable syntax highlighting and colors
syntax on
set background=dark           " Tell Vim our terminal background is dark
set t_Co=256                  " Enable 256 colors

" 3. Basic functionality and aesthetics
set encoding=utf-8            " Use UTF-8 encoding
set number                    " Show line numbers
set cursorline                " Highlight the current line
set autoindent                " Auto-indent
set smarttab                  " Smart tabs

" 4. Plugin Manager Setup (Vim-Plug)
call plug#begin('~/.vim/plugged')

" --- ESSENTIAL PLUGINS ---
" 1. File Explorer: NERDTree (A tree explorer for file navigation)
Plug 'preservim/nerdtree'

" 2. Syntax Highlighting Enhancement: vim-polyglot (Comprehensive syntax highlighting for many languages)
Plug 'sheerun/vim-polyglot'

" --- THEME PLUGINS (Choose One by Uncommenting) ---
" Plug 'dracula/vim'           " Option 1: Dracula Theme
Plug 'arcticicestudio/nord-vim' " Option 2: Nord Theme (icy, cool color palette)
" Plug 'morhetz/gruvbox'       " Option 3: Gruvbox Theme (warm, retro-inspired color palette)

" --- END PLUGINS ---
call plug#end()

" 5. Plugin Specific Configuration
" Uncomment one color scheme below after running :PlugInstall
" colorscheme dracula         " Activate Dracula (if uncommented above)
colorscheme nord            " Activate Nord (if uncommented above)
" colorscheme gruvbox         " Activate Gruvbox (if uncommented above)

" NERDTree mappings (opens/closes with Ctrl+n, opens on startup if no file specified)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <C-n> :NERDTreeToggle<CR>
EOF_VIMRC

echo "Minimal .vimrc created successfully."

# --- 3. Install Plugins ---
echo ""
echo "Plugins are ready to be installed inside Vim."
echo "To finish the installation, open Vim and run the command:"
echo "    :PlugInstall"
echo ""

read -r -p "Do you want to run Vim now to install the plugins? (y/N): " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Starting Vim. Type :PlugInstall and press ENTER in the Vim window."
    vim "+PlugInstall"
fi

echo "Script finished."
