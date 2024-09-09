#!/bin/bash
# Author: @juslarsen
# Description: This is my Mac OS setup script. Largely inspired by/stolen from @rowofpixels.

script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )


# Install homebrew if it's not already installed
if ! command -v brew &> /dev/null
then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    exit
fi

# Install tools from Brewfile
brew bundle install --file=~/.dotfiles/Brewfile

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

# Restart the dock and finder to apply changes
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

### Terminal setup ###
if [ ! -d "$HOME/.oh-my-zsh/" ] ; then
    bash -c "$(curl -s https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

### Directory Setup for Multi-Identity Commits ###
### Devevelopment directory ###
if [ ! -d "$HOME/development" ] ; then
        mkdir -p $HOME/development
fi

if [ ! -f "$HOME/development/.gitconfig" ] ; then
        cp $script_path/gitconfig.development $HOME/development/.gitconfig
fi

### Personal development directory ###
if [ ! -d "$HOME/development/personal" ] ; then
        mkdir -p $HOME/development/personal
fi

if [ ! -f "$HOME/development/personal/.gitconfig" ] ; then
        cp $script_path/gitconfig.personal $HOME/development/personal/.gitconfig
fi

### Work development directory ###
if [ ! -d "$HOME/development/work" ] ; then
        mkdir -p $HOME/development/work
fi

if [ ! -f "$HOME/development/work/.gitconfig" ] ; then
        cp $script_path/gitconfig.work $HOME/development/work/.gitconfig
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

### Dotfile Linking ###
cd $script_path
rcup gitconfig
rcup gitignore
rcup zprofile
rcup vimrc
rcup zshrc
rcup hammerspoon
rcup p10k.zsh
