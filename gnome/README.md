GNOME desktop configuration — shared across distros.

> Applies to any GNOME-based machine (Ubuntu, Fedora, …). These are
> desktop-environment settings, not distro-specific, so both
> [`Setup New Ubuntu.md`](../docs/Setup%20New%20Ubuntu.md) and
> [`Setup New Fedora.md`](../docs/Setup%20New%20Fedora.md) link here instead of
> duplicating them.

## Settings sync (dconf)

GNOME settings live in dconf. Rather than hand-write `gsettings set` lines, the
paths worth versioning are listed in [`manifest`](manifest),
grouped into sections (`input`, `bindings`, `interface`, `extensions`). Two
scripts move them in and out of the repo:

```sh
scripts/gnome-dump   # capture: write the manifest paths to gnome/<group>.ini
scripts/gnome-load   # restore: load every gnome/*.ini (run by setup-linux)
```

Typical flow: tweak settings on machine A → `gnome-dump` → commit → on machine B
`git pull` and `gnome-load` (or just run `setup-linux`). Group headers in each
`.ini` are absolute, so one file can span several subtrees and still restore with
a single load. Settings for extensions absent on the target remain dormant.
Interface values such as GTK, icon, and cursor themes are applied literally, so
keep those entries compatible with every distro where `gnome-load` will run.

To track something new, find its dconf path and add it under a group:

```sh
dconf dump / | grep '^\['     # list every customized subtree
```

Note: a dump only records values that are *set*; resetting a key to its default
isn't captured, but on a fresh machine the default is already in place.

## Extensions

- Install GNOME extensions
  - [Vicinae](https://github.com/dagimg-dot/vicinae-gnome-extension) — exposes clipboard and window management APIs to the [Vicinae](https://vicinae.com/) launcher.
  - [Lilypad](https://github.com/shendrew/Lilypad) — organize, hide, and reorder top bar indicators.
  - [uSwitch](https://github.com/nunoh/uSwitch) — compact Alt-Tab replacement with live thumbnails for windows on the current workspace.
  - [Control monitor brightness and volume with ddcutil](https://extensions.gnome.org/extension/6325/control-monitor-brightness-and-volume-with-ddcutil/) — top-bar sliders for external monitor brightness/volume (see the monitor controls section in the distro setup guide).
  - List currently enabled extensions with `gnome-extensions list --enabled`.
