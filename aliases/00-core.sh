# --- navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cdh='cd ~'
alias cdd='cd ~/dotfiles'
alias cdc='cd ~/.config'

# --- ls variants ---
alias l='ls -lah --group-directories-first'
alias ll='ls -lAh'
alias la='ls -A'

alias cls='clear'
alias c='clear'

# --- system ---
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install'
alias autoremove='sudo apt autoremove'
alias sctl='sudo systemctl'
alias jctl='journalctl -xe'
