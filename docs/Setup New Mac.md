## Before a fresh install
- [ ] check dotfiles repo for local changes
- [ ] `mackup backup`
- [ ] full Time Machine backup to an external drive
- [ ] remember Apple / Google / Firefox passwords
- [ ] backup `~/.ssh`
- [ ] backup `.zsh_history`

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-mac personal
```

Use `setup-mac work` for the smaller work-machine package set. Both profiles
install the Command Line Tools, Homebrew, their formulae/casks, the dotfiles,
Python, and clear the Dock. The personal profile also installs the Mac App Store
apps and NVM. If the script stops after the Command Line Tools install, finish
that and re-run it with the same profile.

## Manual steps after
- Set git identity in `~/.gitconfig.local`:
  ```sh
  git config -f ~/.gitconfig.local user.name "Your Name"
  git config -f ~/.gitconfig.local user.email "you@example.com"
  ```
- Restore `~/.ssh`, and `.zsh_history` from the old machine.
- Sign into Codex, ChatGPT, and the other installed apps.
- Restore macOS/app prefs with [mackup](https://github.com/lra/mackup) (review
  `osx/.mackup.cfg` first):
  ```sh
  mackup restore
  ```
- Install own builds not on Homebrew: [uSwitch](https://github.com/nunoh/uSwitch),
  [Unwind](https://github.com/nunoh/unwind).
- Firefox: log in with Sync, then restore `userChrome.css` / `userContent.css`
  from the old profile if needed.
- Chrome / VS Code: sign in to sync.
- Add Google account under System Settings → Internet Accounts for calendar.
