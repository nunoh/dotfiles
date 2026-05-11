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
| `zsh`         | `~/.zshrc.dots`, `~/.zsh_plugins.txt` | also: `cp zsh/.zshrc.example ~/.zshrc` and customize (see below) |
| `git`         | `~/.gitconfig`, `~/.gitignore_global` | also: `cp git/.gitconfig.linux ~/.gitconfig.local` or `cp git/.gitconfig.osx ~/.gitconfig.local`, then fill in |
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

## Per-host `~/.zshrc`

`zsh/.zshrc.dots` holds the shared zsh config. Each machine has its own
`~/.zshrc` (untracked) that sources it. Bootstrap from the template:

```sh
cp ~/.dotfiles/zsh/.zshrc.example ~/.zshrc
```

Then edit `~/.zshrc` to suit the host. Overrides above the source line
are read during plugin init (e.g. `ZSH_THEME`); overrides below it run
after plugins load (e.g. `PROMPT`, host-specific aliases).

## New machine setup

See the setup guides for full package, app, zsh, vim, and restore steps:

- [`docs/Setup New Mac.md`](docs/Setup%20New%20Mac.md)
- [`docs/Setup New Ubuntu.md`](docs/Setup%20New%20Ubuntu.md)
