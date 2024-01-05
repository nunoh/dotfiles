# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export ZSH=/Users/Nuno/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  brew
  colored-man-pages
  composer
  docker
  fabric
  git
  github
  heroku
  history-substring-search
  npm
  per-directory-history
  pyenv
  python
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  autoenv
)

source $ZSH/oh-my-zsh.sh

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY

eval "$(pyenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# autocomplete ssh with Host first instead of HostName
zstyle ':completion:*:ssh:*' hosts off

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
