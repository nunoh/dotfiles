# Set up a new Mac

## Before

- Commit and push dotfile changes.
- Back up `~/.ssh` and `.zsh_history`.
- Make a Time Machine backup.

## Work

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-mac work
```

## Personal

Sign into the Mac App Store first, then run:

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-mac personal
```

Personal also installs personal apps, Mac App Store apps, and NVM.

If macOS opens the Command Line Tools installer, finish it and rerun the same
command.

## Symlinks

`setup-mac` runs this automatically. If setup stops early, or to refresh the
links, run:

```sh
~/.dotfiles/scripts/bootstrap
```

## Finish

```sh
gh auth login
git config -f ~/.gitconfig.local user.name "Your Name"
git config -f ~/.gitconfig.local user.email "you@example.com"
```

- Restore `~/.ssh` and `.zsh_history`.
- Open Hammerspoon and grant Accessibility permission.
- Sign into the installed apps.
- On a personal Mac, install uSwitch and LaunchKnife.
