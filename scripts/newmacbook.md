Step 0: Install [brew](brew.sh).

### Brew

  - Dependencies

  ```bash
  brew install \
    core-utils \
    htop \
    hub \
    vim
  ```

  - Casks

  ```bash
  brew cask install \
      anki \
      appcleaner \
      atom \
      awareness \
      bartender \
      day-o \
      dropbox \
      evernote \
      firefox \
      flux \
      flycut \
      google-drive \
      iterm2 \
      rescuetime \
      skype \
      spectacle \
      spotify \
      sublime-text \
      vlc
  ```

### Manual installs

  Some apps don't (didn't) work as casks install.
  - utorrent
  - TotalSpaces2

### Terminal
  - [ ] `git clone https://github.com/nunoh/dotfiles ~/.dotfiles`
  - [ ] Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
    - [ ] Install [zsh-autosuggestions](zsh-users/zsh-autosuggestions)
    - [ ] Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)  
  - [ ] Install [Vundle](https://github.com/VundleVim/Vundle.vim)
  - [ ] Open vim and run `:PluginInstall`
  - [ ] Set iterm prefs to load/save to/from dotfiles folder

### Misc

 - [ ] Turn on FileVault
 - [ ] Disable SIP with `csrutil enable --without debug`
 - [ ] Install [sindresorhus/quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins)
 - [ ] Import old keychain
 - [ ] Do Time Machine backup

### Development Libraries

   - Python
     - `brew install python3`

   - Node
     - `brew install node`
     - `npm install -g n && n lts`

   - openFrameworks
     - `brew cask install android-studio`
     - `git clone openFrameworks`

### App Store

  - Pages
  - Keynote
  - Numbers
  - Xcode

### OSX customizations

  _(override to same sane hacker defaults)_
  - [ ] Map Caps Lock key to Escape

### Keyboard shortcuts

  _TODO_
