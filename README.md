# dotfiles

Personal dotfiles, managed with [GNU stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow *package* — its contents mirror the layout
they should have in `$HOME`. Running stow on a package symlinks its files into
place.

## Install

```sh
# prerequisite
brew install stow            # macOS
sudo apt install stow        # Debian/Ubuntu

git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/bootstrap
```

`scripts/bootstrap` reaps any leftover absolute-path symlinks from the old
`ln -sfv` setup and then stows the right packages for your OS.

## Packages

| Package       | Symlinks into                  | Notes                |
|---------------|--------------------------------|----------------------|
| `zsh`         | `~/.zshrc`                     |                      |
| `git`         | `~/.gitconfig`, `~/.gitignore_global` | also: `cp git/.gitconfig_user.example ~/.gitconfig_user` and fill in |
| `vim`         | `~/.vimrc`, `~/.ycm_extra_conf.py` |                  |
| `shell`       | `~/.aliases`, `~/.exports`, `~/.functions`, `~/.path`, `~/.shortcuts`, `~/.hushlogin` | sourced by zsh |
| `ghostty`     | `~/.config/ghostty/config`     | macOS + Linux        |
| `osx`         | `~/.mackup.cfg`                | macOS only           |
| `hammerspoon` | `~/.hammerspoon/init.lua`      | macOS only           |

Reference-only directories (not stowed): `iterm`, `sublime`, `vscode`, `tmux`,
`cheatsheets`, `docs`. App preferences for those live under `~/Library/...`
and are managed via [mackup](https://github.com/lra/mackup).

## Common tasks

```sh
cd ~/.dotfiles

stow ghostty                    # install one package
stow -D hammerspoon             # uninstall (remove its symlinks)
stow -R zsh                     # restow (refresh symlinks)
stow -n -v zsh                  # dry-run, show what would happen
```

## New machine setup

See [`docs/Setup New Mac.md`](docs/Setup%20New%20Mac.md) for the full
brew/casks/zsh-plugins/vim list.
