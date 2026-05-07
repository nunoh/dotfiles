Guide to setting up a new macbook.

## Checklist before fresh install
- [x] remember FF password
- [x] remember Google password
- [x] remember Apple account password
- [x] check dotfiles repo for local changes
- [x] export Raycast settings & data
- [x] `mackup backup`
- [x] full disk time machine backup to external drive
- [x] backup raycast settings

## Setup
- Remove all from dock
  ```
  defaults write com.apple.dock persistent-apps -array && defaults write com.apple.dock persistent-others -array && killall Dock
  ```
- Install dev tools
  ```
  xcode-select --install
  ```
- Install [brew.sh](https://brew.sh/)
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- Install brew packages
```
brew install \
	antidote \
	autoconf \
	cloc \
	cmake \
	coreutils \
	ffmpeg \
	gh \
	git \
	htop \
	imagemagick \
	jq \
	mackup \
	neovim \
	pre-commit \
	qlmarkdown \
	qlvideo \
	quicklook-json \
	sqlite \
	stow \
	terminal-notifier \
	tldr \
	tree \
	uv \
	vim \
	watch \
	wget
```
- Install brew casks
```
brew install --cask \
	appcleaner \
	audacity \
	calibre \
	dropbox \
	firefox \
	flux-app \
	font-fira-code-nerd-font \
	ghostty \
	google-chrome \
	google-drive \
	hammerspoon \
	iterm2 \
	itsycal \
	jordanbaird-ice \
	monitorcontrol \
	obsidian \
	openinterminal-lite \
	pearcleaner \
	quicklook-video \
	raycast \
	rectangle \
	rescuetime \
	slack \
	spotify \
	sublime-text \
	surfshark \
	ticktick \
	transmission \
	visual-studio-code \
	vlc
```
- Mac App Store apps (sign in to App Store GUI once, then `brew install mas`)
```
mas install \
	363738376 \
	409035833 \
	497799835
```
	- forScore (363738376), iReal Pro (409035833), Xcode (497799835)
- Manual installs (own builds, not on brew)
	- [uSwitch](https://github.com/nunoh/uSwitch)
	- [Unwind](https://github.com/nunoh/unwind)
- install [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file)
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```
- set up vim (Vundle is vim-only; neovim is installed but uses no plugin manager yet)
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall
```
- restore OSX system and app preferences with [mackup](https://github.com/lra/mackup)
```
# double check what to import on `osx/.mackup.cfg`
mackup restore
```
- set up Firefox
	- login with Firefox sync
	- remove blue dot indicator (look at `chrome` dir of previous FF profile - userChrome.css and userContent.css)
	- follow https://www.userchrome.org/how-create-userchrome-css.html
- set up Chrome
	- login
- set up vscode
	- Turn on Settings Sync
- Set up python
```
uv python install --default
```
- Set up calendar
	- add internet accounts gmail
- Restore Raycast settings & data from the pre-install export
- set up `~/.gitconfig_user`

## Terminal

### dotfiles
- Clone and bootstrap [dotfiles](https://github.com/nunoh/dotfiles)
  ```
  git clone https://github.com/nunoh/dotfiles ~/.dotfiles
  bash -c ~/.dotfiles/scripts/bootstrap
  ```

### zsh
- Plugins managed by [antidote](https://github.com/mattmc3/antidote); auto-installed on first shell start.
- Per-machine overrides go in `~/.zshrc.local`.
- Copy `.zsh_history` from the old machine.
