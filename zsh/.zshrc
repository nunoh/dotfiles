export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  brew
  colored-man-pages
  django
  git
  github
  per-directory-history
  pipenv
  pyenv
  zsh-autosuggestions
  history-substring-search
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

source ~/.z.sh

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY

eval "$(rbenv init -)"
# eval "$(pyenv init -)"
