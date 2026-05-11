# dotfiles

Personal dotfiles, managed with stow.

## Install

```sh
# prerequisite
brew install stow            # macOS
sudo apt install stow        # Debian/Ubuntu
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/bootstrap
```

## Directories

### Stowed packages

- `zsh`: shared shell startup files, aliases, functions, and plugin setup.
- `git`: shared Git config and ignore rules.
- `vim`: shared Vim config.
- `shell`: shared shell aliases, exports, helper functions, and paths.
- `ghostty`: shared Ghostty config and key bindings.
- `tmux`: tmux key bindings, session behavior, and color themes.
- `osx`: macOS-specific preferences for `mackup`.
- `hammerspoon`: Hammerspoon config for macOS automation.

### Reference-only directories

- `iterm`
- `sublime`
- `vscode`
- `cheatsheets`: quick reference notes for terminal tools.
- `docs`: setup guides for new machines.
- `keyd`: Linux keyboard remapping config.

App preferences for the reference-only directories live under `~/Library/...`
and are managed via [mackup](https://github.com/lra/mackup).

## Common tasks

```sh
cd ~/.dotfiles

stow ghostty                    # install one package
stow tmux                       # install one package
stow -D hammerspoon             # uninstall (remove its symlinks)
stow -R zsh                     # restow (refresh symlinks)
stow -n -v zsh                  # dry-run, show what would happen
```

## Per-host settings

### zsh

```sh
cp ~/.dotfiles/zsh/.zshrc.local.example ~/.zshrc.local
```

## git

```sh
git config -f ~/.gitconfig.local user.name "Your Name"
git config -f ~/.gitconfig.local user.email "you@example.com"
```

## New machine setup

See the setup guides for full package, app, zsh, vim, and restore steps:

- [`docs/Setup New Mac.md`](docs/Setup%20New%20Mac.md)
- [`docs/Setup New Ubuntu.md`](docs/Setup%20New%20Ubuntu.md)
