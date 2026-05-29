GNOME desktop configuration — shared across distros.

> Applies to any GNOME-based machine (Ubuntu, Fedora, …). These are
> desktop-environment settings, not distro-specific, so both
> [`Setup New Ubuntu.md`](Setup%20New%20Ubuntu.md) and
> [`Setup New Fedora.md`](Setup%20New%20Fedora.md) link here instead of
> duplicating them.

- Set keyboard repeat delay
  ```sh
  gsettings set org.gnome.desktop.peripherals.keyboard delay 200
  ```
- Set GNOME keyboard shortcuts
  ```sh
  gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
  gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"
  gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>Down']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Alt>Tab']"
  gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-down
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control>Left']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control>Right']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Super>Tab']"
  gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
  gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Super><Shift>q']"
  ```
- Hide Home folder on desktop
  ```sh
  gsettings set org.gnome.shell.extensions.ding show-home false
  ```
- Backup and restore dock settings
  ```sh
  mkdir -p ~/.dotfiles/gnome
  dconf dump /org/gnome/shell/extensions/dash-to-dock/ > ~/.dotfiles/gnome/dash-to-dock.ini
  dconf load /org/gnome/shell/extensions/dash-to-dock/ < ~/.dotfiles/gnome/dash-to-dock.ini
  ```
- Install GNOME extensions
  - [Vicinae](https://github.com/dagimg-dot/vicinae-gnome-extension) — exposes clipboard and window management APIs to the [Vicinae](https://vicinae.com/) launcher.
  - [Lilypad](https://github.com/shendrew/Lilypad) — organize, hide, and reorder top bar indicators.
  - [uSwitch](https://github.com/nunoh/uSwitch) — compact Alt-Tab replacement with live thumbnails for windows on the current workspace.
  - [Control monitor brightness and volume with ddcutil](https://extensions.gnome.org/extension/6325/control-monitor-brightness-and-volume-with-ddcutil/) — top-bar sliders for external monitor brightness/volume (see the monitor controls section in the distro setup guide).
  - List currently enabled extensions with `gnome-extensions list --enabled`.
