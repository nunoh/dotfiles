# Antidote — zsh plugin manager. https://github.com/mattmc3/antidote
# Plugins listed in ~/.zsh_plugins.txt.
# macOS: `brew install antidote`
# Linux: `git clone --depth=1 https://github.com/mattmc3/antidote ~/.antidote`
if [[ "$OSTYPE" == darwin* ]]; then
  source $(brew --prefix)/share/antidote/antidote.zsh
else
  source $HOME/.antidote/antidote.zsh
fi

ZSH_THEME="${ZSH_THEME:-robbyrussell}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

antidote load

for f in ~/.dotfiles/shell/.*; do source $f; done

# don't share command history between shell sessions
setopt APPEND_HISTORY

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Host-specific zsh overrides live outside the repo.
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

# Show user@host in prompt when over SSH. The theme redraws PROMPT during
# precmd, so keep this hook persistent.
if [[ -n "$SSH_CONNECTION" ]]; then
  autoload -U add-zsh-hook
  _ssh_prompt_prefix() {
    PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg_bold[yellow]%}%n@%m%{$reset_color%} %{$fg[cyan]%}%c%{$reset_color%} \$(git_prompt_info)"
  }
  add-zsh-hook precmd _ssh_prompt_prefix
fi
