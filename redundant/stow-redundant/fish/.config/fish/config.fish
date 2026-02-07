#! /bin/sh
#   __ _     _              
#  / _(_)___| |__  _ __ ___ 
# | |_| / __| '_ \| '__/ __|
# |  _| \__ \ | | | | | (__ 
# |_| |_|___/_| |_|_|  \___|
                 
# Exports
export EDITOR=nvim || export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Sets 
set fish_greeting
set editor "nvim"
set TERM "xterm-256color"
set reader "zathura"
set browser "librewolf"

# Aliases
alias vim=nvim
alias ls='exa || ls'
alias ll='exa -l || ls -l'
alias la='exa -a || ls -a'
alias gs='git status'
alias nf=neofetch
alias stow='stow -t ~'
alias ..='cd ..'

# Configs
alias fishrc='$editor ~/.config/fish/config.fish'
alias nvimrc='$editor ~/.config/nvim/init.vim'
alias alacritty.yml='$editor ~/.config/alacritty/alacritty.yml'
alias make.conf='sudo $editor /etc/portage/make.conf'

# Youtube-dl
alias playlist-dl="youtube-dl -cio '%(autonumber)s-%(title)s.%(ext)s'"
alias yt='youtube-dl'
alias ytv='yt -f bestvideo'
alias yta='yt -f bestaudio'

# startx wm aliases
alias dwm='WM=dwm startx'
alias spectrwm='WM=spectrwm startx'
alias sp='WM=spectrwm startx'

# Random shell color script on startup
colorscript -r 

# Initialize the Starship shell prompt
starship init fish | source
