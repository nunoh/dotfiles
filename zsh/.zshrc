export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git colored-man-pages zsh-history-substring-search supervisor docker github node npm fasd nvm pip python brew osx battery zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# don't share command history between shell sessions
setopt APPEND_HISTORY

for f in ~/.dotfiles/shell/.*; do source $f; done
