
# -----------------------------------------------
# CUSTOM BASHRC: Minimalist and Aesthetic
# -----------------------------------------------

# --- 1. BASIC SETUP (Keep these standard) ---
# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# Enable globstar for recursive matching (e.g., ls **/*.txt)
shopt -s globstar

# --- 2. THE CUSTOM PROMPT (PS1) ---

# Function to safely parse Git branch status
parse_git_branch() {
    # Check if git is installed and if we are in a git repository
    if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Use __git_ps1 if available (from git-completion) for robust status, otherwise simple parse
        if type __git_ps1 &>/dev/null; then
            GIT_PS1_SHOWDIRTYSTATE=true
            GIT_PS1_SHOWUNTRACKEDFILES=true
            GIT_PS1_DESCRIBE_STYLE='branch'
            __git_ps1 " [%s]"
        else
            git branch --show-current 2>/dev/null | awk '{print " [" $1 "]"}'
        fi
    fi
}

# The modern, colorful PS1.
# Components:
# \[\e[32m\] : Green (User/Host)
# \[\e[34m\] : Blue (Working Directory)
# \[\e[91m\] : Bright Red (Git Branch Status)
# \[\e[0m\] : Reset Color

# Prompt format: [user@host:directory/path] [GIT_BRANCH]
# \n\$ separates the prompt from the command line for clarity.
PS1='\[\e[32m\]\u@\h:\[\e[34m\]\w\[\e[0m\]\[\e[91m\]$(parse_git_branch)\[\e[0m\]\n\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac


# --- 3. COLORS AND UTILITIES ---

# Enable color support for ls and other utilities using dircolors.
# This is necessary for colorful output even if specific aliases (like ll) are defined externally.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # The default ls, grep, fgrep, and egrep aliases are kept to ensure color support is active.
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# --- 4. LOAD CUSTOM ALIASES (Your existing logic) ---

# Load custom aliases from ~/dotfiles/aliases
if [ -d "$HOME/dotfiles/aliases" ]; then
  for file in "$HOME/dotfiles/aliases/"*.sh; do
    [ -r "$file" ] && . "$file"
  done
fi

# --- 5. BASH COMPLETION ---

# Enable programmable completion features (if not enabled elsewhere)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- FZF (Fuzzy Finder) Configuration ---
# Source the FZF key bindings and completion scripts for interactive search.
if [ -f /usr/share/bash-completion/completions/fzf ]; then
    . /usr/share/bash-completion/completions/fzf
fi
# Alternative location check (less common, but safe)
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

