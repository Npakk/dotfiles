# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# dot files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# autoload
export FPATH="$ZDOTDIR/autoload/:$FPATH"
