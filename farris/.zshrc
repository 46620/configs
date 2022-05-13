# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mia/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="fox"

# ZSH Auto Updater
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

# Plugins
plugins=(
    git
    zsh-autosuggestions
    )

# Extra Sources
source $ZSH/oh-my-zsh.sh
source ~/.aliases
source ~/.exports
