#!/bin/bash
script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Mac OS install script largely stolen from @rowofpixels.

### Tap brew casks as needed ###
brew tap thoughtbot/formulae
brew tap sambadevi/powerlevel9k
brew tap homebrew/cask-fonts
### Update brew ###
brew update

### Install brew packages ###
brew install autojump
brew install asdf
brew install awscli
brew install cmake
brew install erlang
brew install elixir
brew install gcc
brew install git
brew install nvm
brew install poetry
brew install pyenv
brew install pyenv-virtualenv
brew install pipenv
brew install rcm
brew install terraform
brew install tig
brew install vim
brew install wget
brew install zsh zsh-completions
brew install powerlevel9k
brew install imagemagick
brew install postgresql
### Install applications with brew cask ###

brew install dropbox --cask
brew install docker --cask
brew install sublime-text --cask
brew install spotify --cask
brew install firefox --cask
brew install slack --cask
brew install vlc --cask
brew install postman --cask
brew install postico --cask
brew install base --cask
brew install discord --cask
brew install visual-studio-code --cask
brew install font-hack-nerd-font --cask
brew install iterm2 --cask
brew install hammerspoon --cask
### macOS specific settings ###

# Finder: show all filename extensions
# http://www.defaults-write.com/display-the-file-extensions-in-finder/
# Revert to the default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Dock: disable recents section of dock
defaults write com.apple.dock show-recents -bool false

# Disable the extension change warning in OS X Finder
# http://www.defaults-write.com/disable-the-extension-change-warning-in-os-x-finder/
# Revert to the default
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use column view in all Finder windows by default
# http://www.defaults-write.com/change-default-view-style-in-os-x-finder/
# Revert to the default
# defaults write com.apple.Finder FXPreferredViewStyle icnv
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Disable the warning before emptying the Trash
# http://www.defaults-write.com/disable-the-warning-before-emptying-the-trash/
# Revert to the default
# defaults write com.apple.finder WarnOnEmptyTrash -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Remove the Dock Auto-Hide & Show Delay
# http://www.defaults-write.com/remove-the-dock-auto-hide-show-delay/
# Revert to the default
# defaults delete com.apple.Dock autohide-delay
defaults write com.apple.dock autohide-delay -float 0

# Reduce the animation when hiding/showing the Dock to 0.5s
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable .DS_Store on mounted network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true


for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

### Terminal setup ###
if [ ! -d "$HOME/.oh-my-zsh/" ] ; then
    bash <(curl -s https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
fi

# setup theme
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ] ; then
    git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
fi

### vim setup ###

# If bundle directory for pathogen doesn't exist, create it
if [ ! -d "$HOME/.vim/bundle" ] ; then
    mkdir -p $HOME/.vim/bundle
fi
# If the pathogen directory doesn't exist, create it
if [ ! -d "$HOME/.vim/autoload" ] ; then
        mkdir -p $HOME/.vim/autoload
fi
# Download vim pathogen package manager.
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
    mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
    curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
# If vim colors directory doesn't exist, create it.
if [ ! -d "$HOME/.vim/colors" ] ; then
        mkdir -p $HOME/.vim/colors
fi
# install apprentice vim color theme
if [ ! -f "$HOME/.vim/colors/apprentice.vim" ] ; then
        cp $script_path/vim/colors/apprentice.vim $HOME/.vim/colors/
fi

### Dotfile
cd $script_path
rcup gitconfig
rcup gitignore
rcup zprofile
rcup vimrc
rcup zshrc
rcup hammerspoon
