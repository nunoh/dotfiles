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
  heroku
  history-substring-search
  npm
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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# autocomplete ssh with Host first instead of HostName
zstyle ':completion:*:ssh:*' hosts off
