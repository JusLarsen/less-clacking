POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=35
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"
ZSH_THEME="powerlevel9k/powerlevel9k"

# load plugins
plugins=(
  git
  autojump
  poetry
)

# load zsh
export MY_USER=$(whoami)
export ZSH="/Users/$MY_USER/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Custom complication flags for brew installs of zlib and sqlite
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"


# Aliases
unalias grv
#alias dockerenv=export $(grep -v '^#' .env | xargs)

. $(brew --prefix asdf)/asdf.sh

export PATH="$HOME/.poetry/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
