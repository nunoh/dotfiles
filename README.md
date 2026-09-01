# dotfiles

Personal dotfiles, managed with stow.

## Install

### macOS / Linux (Desktop)

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/bootstrap
git config -f ~/.gitconfig.local user.name "Your Name"
git config -f ~/.gitconfig.local user.email "you@example.com"
```

- [`docs/Setup New Mac.md`](docs/Setup%20New%20Mac.md)
- [`docs/Setup New Ubuntu.md`](docs/Setup%20New%20Ubuntu.md)
- [`docs/Setup New Fedora.md`](docs/Setup%20New%20Fedora.md)
- [`gnome/README.md`](gnome/README.md) — shared GNOME config (Ubuntu + Fedora)

### Server (Debian/Ubuntu)

Installs base packages, stows Vim and tmux, configures a lean server-specific
zsh environment, clones antidote, and switches the login shell to zsh.

```sh
sudo apt install -y git
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-server
```

## Directories

### Stowed packages

- `zsh`: shared shell startup files, aliases, functions, and plugin setup.
- `git`: shared Git config and ignore rules.
- `vim`: shared Vim config.
- `shell`: shared shell aliases, exports, helper functions, and paths.
- `ghostty`: shared Ghostty config and key bindings.
- `cmux`: cmux-specific shortcuts.
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

### Configs that an app writes back

`cmux` writes to `~/.config/cmux/cmux.json` when you save its Settings window,
including its automation socket password. The file is stowed, so there is only
ever one copy and it cannot drift, but it is git-ignored so the password stays
off GitHub. `cmux.json.example` tracks the settings themselves; refresh it with
`cp cmux/.config/cmux/cmux.json cmux/.config/cmux/cmux.json.example` and remove
`automation.socketPassword` before committing.

If an app replaces a stowed symlink with a real file, `scripts/bootstrap`
reports it and saves a `*.pre-stow.bak` copy before restowing, so the outside
changes can be merged back.
