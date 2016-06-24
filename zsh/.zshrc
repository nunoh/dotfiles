export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  git
  colored-man-pages
  zsh-history-substring-search
  supervisor
  docker
  github
  gulp
  node
  # npm # takes quite a bit
  fasd
  nvm # takes quite a bit too but necessary
  brew
  osx
  # battery
  zsh-autosuggestions
  zsh-syntax-highlighting
  per-directory-history
)

source $ZSH/oh-my-zsh.sh

# don't share command history between shell sessions
setopt APPEND_HISTORY

for f in ~/.dotfiles/shell/.*; do source $f; done

eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
