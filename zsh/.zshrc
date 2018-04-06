export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  brew
  colored-man-pages
  git
  github
  per-directory-history
  ng
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY
