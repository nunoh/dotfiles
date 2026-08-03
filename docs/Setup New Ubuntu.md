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
- Install GNOME extensions (browser-based) — see [`gnome/README.md`](../gnome/README.md).
- Install apps with no clean apt repo:
  - [Ghostty](https://ghostty.org/docs/install/binary#linux)
  - [Obsidian](https://obsidian.md/download)
- Log out and back in to pick up `i2c` group membership, then verify monitor
  controls (enable `DDC/CI` in the monitor's on-screen menu if needed):
  ```sh
  ddcutil detect
  ddcutil getvcp 10        # read brightness
  ddcutil setvcp 10 60     # set brightness
  ```
  Use `ddcui` for a standalone GUI, or the ddcutil GNOME extension for top-bar
  sliders (see [`gnome/README.md`](../gnome/README.md)).
- Bare metal only: reboot to activate NVIDIA drivers (`nvidia-smi` to verify).
