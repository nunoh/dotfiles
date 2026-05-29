## Before a fresh install
- [ ] check dotfiles repo for local changes
- [ ] backup `~/.ssh`
- [ ] backup `.zsh_history`

```sh
git clone https://github.com/nunoh/dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-linux         # add --vm if inside a VM
```

## Manual steps after
- Set git identity in `~/.gitconfig.local`:
  ```sh
  git config -f ~/.gitconfig.local user.name "Your Name"
  git config -f ~/.gitconfig.local user.email "you@example.com"
  ```
- Restore `~/.ssh`, and `.zsh_history` from the old machine.
- Sign into the coding agents: run `claude` and `codex` once to authenticate.
- Install GNOME extensions (browser-based) — see [`GNOME.md`](GNOME.md).
- Bare metal only: reboot to activate NVIDIA drivers, and log out/in to pick up
  `i2c` group membership for monitor controls.
