# Time Machine

The Mac backs up to bee with Time Machine, once a week. bee then copies the
backup to B2 every night. The goal is insurance: get most files back if the
Mac is lost. A new Mac is a fresh install with `setup-mac`, not a restore.

Server side (dataset, share, B2 copy): `pve/backups/time-machine.md` in the
bee repo.

## What is backed up

The data volume (home folder, `/Library`, `/opt/homebrew/etc`,
`/opt/homebrew/var`, `/etc`) without:

- **Time Machine's own exclusions:** caches, swap, temp files, the macOS
  system volume.
- **[`scripts/tm-exclude`](../scripts/tm-exclude):** apps, Homebrew packages,
  toolchains, package stores, model downloads, cloud-synced folders
  (Dropbox, iCloud Drive), MacPorts (`/opt/local`) and large browser and
  Electron app data.
- **[asimov](https://github.com/AsimovMac/asimov):** dependency folders next
  to their project file, such as `node_modules` (`package.json`), `target`
  (`Cargo.toml`) and `Pods` (`Podfile`).

Estimate (2026-11-15): ~38 GB of a 177 GB data volume.

## Setup

1. Exclusions and asimov:

   ```sh
   brew install asimov
   brew services start asimov     # runs daily, adds sticky exclusions
   ~/.dotfiles/scripts/tm-exclude
   ```

2. Destination: System Settings → General → Time Machine → Add Backup Disk
   → `TimeMachine on storage`. Sign in as `nuno` with the Samba password.
   If it does not show, connect once in Finder to
   `smb://storage.local/TimeMachine`.
3. Options: **Back up frequency → Automatically Every Week**. Optionally
   turn on encryption for the backup.
4. First backup on wired Ethernet (it copies everything once):

   ```sh
   caffeinate -i tmutil startbackup --block
   ```

## Folders asimov does not know

For a build folder with a generic name (`dist`, `build`, `release`), add a
sticky exclusion once. It stays on the folder, also when you move it:

```sh
tmutil addexclusion ~/Code/<repo>/release
```

## Browse and restore

- **Mac still works:** Finder → the folder → Time Machine in the menu bar →
  Browse Time Machine Backups.
- **Other Mac:** connect to `smb://storage.local/TimeMachine` and open the
  `.sparsebundle`. It mounts as a disk with one folder per backup.
- **bee lost:** restore the sparsebundle from B2 with restic first (see the
  bee runbook), then open it.

## Commands

```sh
tmutil destinationinfo                       # destination and its ID
tmutil latestbackup                          # last finished backup
tmutil startbackup --auto                    # back up now
tmutil isexcluded <path>                     # check one path
~/.dotfiles/scripts/tm-exclude --list        # fixed-path exclusions
sudo tmutil removeexclusion -p <path>        # undo one
```

`tmutil` needs Full Disk Access for the terminal app for some commands
(System Settings → Privacy & Security → Full Disk Access).
