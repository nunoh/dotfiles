export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git colored-man-pages zsh-history-substring-search supervisor docker github node npm fasd nvm pip python brew osx battery zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

for f in ~/.dotfiles/shell/.*; do source $f; done
