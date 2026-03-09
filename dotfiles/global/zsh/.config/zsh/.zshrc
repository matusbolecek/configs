#         _              
#  _______| |__  _ __ ___ 
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__ 
# /___|___/_| |_|_|  \___|

# Sets
setopt autocd
stty stop undef	
export KEYTIMEOUT=1

# Setting locales to fix artifacts
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# mac
export PATH=/opt/homebrew/bin:$PATH

# History
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Default programs and .local/bin
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export BROWSER="firefox"
export READER="zathura"

# Source aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# Source python specific
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshpyrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshpyrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use lf to switch directories and bind it to ctrl-f
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^f' 'lfcd\n'

# Load the Starship prompt
eval "$(starship init zsh)"

# zsh plugins folder autodetection (works on mac and linux)
function source_plugin() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            source "$file"
            return 0
        fi
    done
}

# Autosuggestions
source_plugin \
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/share/zsh/site-functions/zsh-autosuggestions.zsh" \
    "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Vi mode 
source_plugin \
  "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh" \
  "/opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.zsh" \
  "/usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.zsh"

# Ensure autosuggestions work with vim mode
ZVM_INIT_MODE=sourcing

# Syntax highlighting
source_plugin \
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh" \
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

