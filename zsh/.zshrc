export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  brew
  colored-man-pages
  composer
  django
  docker
  fabric
  git
  github
  history-substring-search
  per-directory-history
  pipenv
  pyenv
  python
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source ~/.z.sh

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY

eval "$(pyenv init -)"
