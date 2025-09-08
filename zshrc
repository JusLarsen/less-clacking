# Determine if we're in vscode to protect our precious LLM friends from our human friendly terminal
export IN_VSCODE=0
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  . "$(code --locate-shell-integration-path zsh)"
  export IN_VSCODE=1
fi

# load zsh
export MY_USER=$(whoami)
export ZSH="/Users/$MY_USER/.oh-my-zsh"

# Enable Powerlevel10k instant prompt when not in VSCode
if [[ $IN_VSCODE -eq 0 ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load plugins
  plugins=(
    asdf
    autojump
    git
  )
  
if [[ $IN_VSCODE -eq 0 ]]; then
  source $ZSH/oh-my-zsh.sh
fi

# Aliases
if [[ $IN_VSCODE -eq 0 ]]; then
  unalias grv # git plugin and grv conflict
fi
. $(brew --prefix asdf)/libexec/asdf.sh 

export PATH="/usr/local/opt/sqlite/bin:$PATH"


# Load powerlevel10k when not in VSCode
if [[ $IN_VSCODE -eq 0 ]]; then
  source $(brew --prefix powerlevel10k)/share/powerlevel10k/powerlevel10k.zsh-theme
fi


function get_gitlab_token() {
      security find-generic-password -a $USER -s gitlab-pat -w
    }

export GITLAB_TOKEN=$(get_gitlab_token)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ $IN_VSCODE -eq 0 ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

. "$HOME/.local/bin/env"

# pnpm
export PNPM_HOME="/Users/jlarsen/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
