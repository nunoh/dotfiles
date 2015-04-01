source ~/.dotfiles/.aliases
source ~/.dotfiles/.exports
source ~/.dotfiles/.functions
source ~/.dotfiles/.path
source ~/.dotfiles/.shortcuts

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
# ZSH_THEME="awesomepanda"
# ZSH_THEME="edvardm"
# ZSH_THEME="cypher"

plugins=(git hub autojump colored-man brew brew-cask osx npm bower)

source $ZSH/oh-my-zsh.sh

setopt combining_chars

# enable vi mode bindings in terminal too
bindkey -v

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
