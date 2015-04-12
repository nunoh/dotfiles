# source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.dotfiles/.aliases
source ~/.dotfiles/.exports
source ~/.dotfiles/.functions
source ~/.dotfiles/.path
source ~/.dotfiles/.shortcuts

# soucing specific autocompletion
# source ~/.dotfiles/completion/tmuxinator.zsh

# fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=($fpath /usr/local/share/zsh/site-functions)

# this is so that accents work properly in autocompletion in the terminal
setopt combining_chars

# enable vi mode bindings in terminal too
bindkey -v

# add sugar to git with hub
eval "$(hub alias -s)"
