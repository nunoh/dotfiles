# Antidote — zsh plugin manager. https://github.com/mattmc3/antidote
# Plugins listed in ~/.zsh_plugins.txt.
# macOS: `brew install antidote`
# Linux: `git clone --depth=1 https://github.com/mattmc3/antidote ~/.antidote`
if [[ "$OSTYPE" == darwin* ]]; then
  source $(brew --prefix)/share/antidote/antidote.zsh
else
  source $HOME/.antidote/antidote.zsh
fi

ZSH_THEME="robbyrussell"

# nvm — lazy-loaded by lukechilds/zsh-nvm to keep shell startup fast.
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true

antidote load

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
