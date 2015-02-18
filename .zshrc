source ~/.dotfiles/.aliases
source ~/.dotfiles/.exports
source ~/.dotfiles/.functions
source ~/.dotfiles/.path
source ~/.dotfiles/.prompt
source ~/.dotfiles/.shortcuts

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
# ZSH_THEME="awesomepanda"
# ZSH_THEME="edvardm"
# ZSH_THEME="cypher"

plugins=(git hub colored-man)

source $ZSH/oh-my-zsh.sh

setopt combining_chars
