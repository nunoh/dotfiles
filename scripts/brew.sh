# NOT TESTED

# Ask for the administrator password upfront.
sudo -v

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install vim --override-system-vi
brew install git
brew install imagemagick --with-webp
brew install tree

# Remove outdated versions from the cellar.
brew cleanup
