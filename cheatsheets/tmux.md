# My tmux cheat sheet

prefix is `C-a` (not the default `C-b`).

when in vim editing `.tmux.conf` hit `K` to jump to the help for that command.


### Sessions

	tmux new -s NAME    new named session
	tmux ls             list sessions
	tmux a              attach to last session
	tmux a -t NAME      attach to named session
	tmux kill-session -t NAME

	prefix d            detach
	prefix S            choose session (custom)
	prefix $            rename session


### Windows

	prefix c            new window (in current path)
	prefix ,            rename window
	prefix &            kill window
	prefix n / p        next / previous window
	prefix N            jump to window N (1-indexed)
	prefix C-a          toggle last window (custom)
	prefix w            list/choose window

	C-S-Left            swap window left   (no prefix, custom)
	C-S-Right           swap window right  (no prefix, custom)


### Panes — splits

	prefix v            split vertical, 50/50, current path  (custom)
	prefix s            split horizontal, 50/50, current path (custom)
	prefix x            kill pane (custom)
	prefix z            zoom pane (toggle)
	prefix !            break pane into its own window
	prefix {  /  }      swap pane with previous / next
	prefix space        cycle through layouts


### Panes — navigation (vim-aware, no prefix)

	C-h / C-j / C-k / C-l   move left / down / up / right

inside vim these pass through to vim splits.


### Panes — resize

	prefix H / J / K / L    resize by 5 in that direction (repeatable)


### Copy mode

	prefix y            enter copy mode (custom)
	prefix [            enter copy mode (default)
	q                   quit copy mode

inside copy mode (vi keys):

	v                   start selection
	V                   line selection
	C-v                 block selection
	y                   yank to tmux buffer
	/  ?                search forward / back
	n  N                next / prev search match
	g  G                top / bottom
	C-u  C-d            half-page up / down

	prefix ]            paste last buffer


### Misc

	prefix l            clear current buffer (custom; `l` rebound from last-window)
	prefix r            reload ~/.tmux.conf (custom)
	prefix t            big clock
	prefix ?            list all key bindings
	prefix :            command prompt


### Nested sessions

	C-b                 forwards prefix to inner tmux (custom)


### Plugins (TPM)

once installed at `~/.tmux/plugins/tpm`:

	prefix I            install plugins listed in .tmux.conf
	prefix U            update plugins
	prefix alt-u        uninstall plugins not in list

resurrect / continuum:

	prefix C-s          save session state
	prefix C-r          restore session state
