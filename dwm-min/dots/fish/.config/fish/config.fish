#   __ _     _              
#  / _(_)___| |__  _ __ ___ 
# | |_| / __| '_ \| '__/ __|
# |  _| \__ \ | | | | | (__ 
# |_| |_|___/_| |_|_|  \___|
                 
set fish_greeting
set terminal "urxvt"
set TERM "xterm-256color"
set editor "nvim"
set reader "zathura"

# Aliases
alias vim=nvim
alias ls=exa
alias list='exa -l'
alias la='exa -a'
alias sudo=doas
alias gs='git status'
alias fishrc='$editor ~/.config/fish/config.fish'
alias nvimrc='$editor ~/.config/nvim/init.vim'
alias ..='cd ..'
alias nf=neofetch
alias scr='clear && colorscript -r'

# THEME PURE #
set fish_function_path /home/matt/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /home/matt/.config/fish/functions/theme-pure/conf.d/pure.fish
