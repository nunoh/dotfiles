# source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.dotfiles/shell/.aliases
source ~/.dotfiles/shell/.exports
source ~/.dotfiles/shell/.functions
source ~/.dotfiles/shell/.path
source ~/.dotfiles/shell/.shortcuts

# soucing specific autocompletion
# source ~/.dotfiles/completion/tmuxinator.zsh
source ~/.dotfiles/completion/fab-completion.zsh
source /Users/Nuno/.gulp-autocompletion-zsh/gulp-autocompletion.zsh
fpath=($fpath /usr/local/share/zsh/site-functions)

# this is so that accents work properly in autocompletion in the terminal
setopt combining_chars
# unsetopt incappendhistory
setopt append_history no_inc_append_history no_share_history

# enable vi mode bindings in terminal too
bindkey -v

# so that git and hub autocomplete coexist
autoload -U compinit && compinit

# add sugar to git with hub
eval "$(hub alias -s)"
