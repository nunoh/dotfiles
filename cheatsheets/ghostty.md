# My Ghostty cheat sheet

config lives at `~/.config/ghostty/config` on macOS and Linux.
reload after edits with `cmd+shift+,` (macOS) / `ctrl+shift+,` (Linux).

most binds use `cmd` on macOS — on Linux swap `cmd` for `ctrl+shift` (Ghostty's convention there).


### Tabs

	cmd+t                   new tab
	cmd+w                   close tab / surface
	cmd+shift+] / [         next / previous tab
	cmd+1 … cmd+8           jump to tab N
	cmd+9                   last tab


### Splits

	cmd+d                   split right
	cmd+shift+d             split down


### Pane navigation (vim-style)

	ctrl+h / j / k / l      move left / down / up / right

uses plain `ctrl` so the same bind works inside tmux's vim-aware nav.


### Pane resize

	cmd+ctrl+h / j / k / l  resize by 10 in that direction


### Clear

	cmd+r                   clear visible screen, keep scrollback (sends ^L)
	cmd+k                   clear screen + scrollback (iTerm's "Clear Buffer")


### Appearance

	cmd+u                   toggle background opacity (configured ↔ fully opaque)


### Misc

	shift+enter             sends alt+enter (for apps that want a "soft newline")
	cmd+escape              toggle quick terminal (drop-down, global hotkey)
	cmd+,                   open config
	cmd+shift+,             reload config
