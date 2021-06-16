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

# nvm versions directory setup
export NVM_DIR="$HOME/.nvm"
mkdir -p $NVM_DIR
# Execute nvm shell script.
. "/opt/homebrew/opt/nvm/nvm.sh"

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

eval "$(pyenv init -)"