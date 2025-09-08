# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Human readable du/df
alias du='du -kh'
alias df='df -kTh'
# For seeing used space.
alias diskspace="du -S | sort -n -r |more"
# Get Libpath
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
# Full LS print
alias lss='ls -larth'
alias ls="ls -la"
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'
# Display path
alias path='echo -e ${PATH//:/\\n}'

# From the tldp.org
function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# exports
export CLICOLOR=1

# Use grep color without deprecated GREP_OPTIONS
alias grep='grep --color=auto'

export PATH=/usr/local/sbin:$PATH
eval $(/opt/homebrew/bin/brew shellenv)


# Configure GPG to accept passphrase from terminal
export GPG_TTY=$(tty)
