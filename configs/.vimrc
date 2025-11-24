" --- General ---
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

" --- Plugins ---
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

" File tree + icons
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Status line
Plug 'itchyny/lightline.vim'

" Autocompletion / LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Better syntax
Plug 'sheerun/vim-polyglot'

" Useful editing enhancements
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" NerdTree toggle
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
nnoremap <C-l> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")) | q | endif


" FZF shortcuts
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>


" UI
set number              " line numbers
set relativenumber      " relative numbers
set ruler               " show cursor position
set showmatch           " highlight matching bracket
set cursorline          " highlight current line
set termguicolors       " 24-bit colors in terminal
set background=dark

" Indentation
set expandtab           " use spaces, not tabs
set shiftwidth=4        " indent size
set tabstop=4           " how many spaces a <Tab> counts for
set smartindent         " simple auto-indenting

" Searching
set ignorecase          " case-insensitive search...
set smartcase           " ...unless search has capitals
set incsearch           " search as you type
set hlsearch            " highlight matches

" Editing
set backspace=indent,eol,start
set clipboard=unnamedplus   " use system clipboard
set mouse=a                 " enable mouse

" Status / command line
set laststatus=2        " always show statusline
set showcmd             " show partial commands

" File handling
set hidden              " allow unsaved buffers in background
set undofile            " persistent undo
set undodir=~/.vim/undo

if !isdirectory($HOME . "/.vim/undo")
    silent! call mkdir($HOME . "/.vim/undo", "p")
endif

" Default colorscheme (simple, built-in)
colorscheme desert

" --- Theme selection for Vim ---
" Choose one of these:

" Gruvbox dark hard
let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox

" Nord
" colorscheme nord

" Pick one:
" colorscheme gruvbox
colorscheme nord
