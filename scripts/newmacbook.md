Step 0: Install [brew](brew.sh).

### Brew

  - Dependencies

  ```bash
  brew install \
    coreutils \
    htop \
    hub \
    vim \
    wget
  ```

  - Casks

  ```bash
  brew cask install \
      android-file-transfer \
      atom \
      awareness \
      bartender \
      day-o \
      dropbox \
      evernote \
      firefox \
      flux \
      flycut \
      iterm2 \
      rescuetime \
      skype \
      spectacle \
      spotify \
      sublime-text \
      hyperswitch \
      mendeley \
      visual-studio-code \
      vlc
  ```

### Manual installs

  Some apps don't (didn't) work as casks install.
  - utorrent
  - TotalSpaces2
  - audacity
  - battery monitor
  - Github Desktop
  - HyperSwitch
  - Microsoft Office
  - MonitorControl
  - Pd-extended
  - Sonic Pi
  - Latex
  - Thyme  

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

### App Store

  - Pages
  - Keynote
  - Numbers
  - Xcode
