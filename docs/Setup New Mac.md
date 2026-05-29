## Before a fresh install
- [ ] check dotfiles repo for local changes
- [ ] `mackup backup`
- [ ] export Raycast settings & data
- [ ] full Time Machine backup to an external drive
- [ ] remember Apple / Google / Firefox passwords
- [ ] backup `~/.ssh`
- [ ] backup `.zsh_history`

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-mac
```

The script installs the Command Line Tools, Homebrew, all formulae/casks, the
Mac App Store apps, nvm, the dotfiles, Python, and clears the Dock. If it stops
after the Command Line Tools install, finish that and re-run it.

## Manual steps after
- Set git identity in `~/.gitconfig.local`:
  ```sh
  git config -f ~/.gitconfig.local user.name "Your Name"
  git config -f ~/.gitconfig.local user.email "you@example.com"
  ```
- Restore `~/.ssh`, and `.zsh_history` from the old machine.
- Sign into the coding agents: run `claude` and `codex` once to authenticate.
- Restore macOS/app prefs with [mackup](https://github.com/lra/mackup) (review
  `osx/.mackup.cfg` first):
  ```sh
  mackup restore
  ```
- Restore Raycast settings & data from the pre-install export.
- Mac App Store apps need a one-time App Store sign-in; if `mas install` was
  skipped, retry: `mas install 363738376 409035833 497799835` (forScore, iReal
  Pro, Xcode).
- Install own builds not on Homebrew: [uSwitch](https://github.com/nunoh/uSwitch),
  [Unwind](https://github.com/nunoh/unwind).
- Firefox: log in with Sync, then restore `userChrome.css` / `userContent.css`
  from the old profile if needed.
- Chrome / VS Code: sign in to sync.
- Add Google account under System Settings → Internet Accounts for calendar.
