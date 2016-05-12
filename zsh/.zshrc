export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git colored-man-pages zsh-history-substring-search supervisor tmux fasd docker github node npm nvm pip python virtualenv brew osx battery zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

for f in ~/.dotfiles/shell/.*; do source $f; done
