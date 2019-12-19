POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=35
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"
ZSH_THEME="powerlevel9k/powerlevel9k"

# load plugins
plugins=(
  git
  autojump
)

# load zsh
export MY_USER=$(whoami)
export ZSH="/Users/$MY_USER/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# nvm versions directory setup
export NVM_DIR="$HOME/.nvm"
mkdir -p $NVM_DIR
# Execute nvm shell script.
. "/usr/local/opt/nvm/nvm.sh"

# Custom complication flags for brew installs of zlib and sqlite
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Allow pyenv to switch virtualenvs based on folder
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/justin/dev/spectrum/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/justin/dev/spectrum/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/justin/dev/spectrum/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/justin/dev/spectrum/node_modules/tabtab/.completions/sls.zsh

# Aliases
unalias grv
export PATH="/usr/local/opt/sqlite/bin:$PATH"

#alias dockerenv=export $(grep -v '^#' .env | xargs)

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/justin/dev/spectrum/services-api/refractor/core/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/justin/dev/spectrum/services-api/refractor/core/node_modules/tabtab/.completions/slss.zsh
. $(brew --prefix asdf)/asdf.sh
