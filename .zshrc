# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="arne"

# Aliases
## Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias la="ls -la ${colorflag}" # List all files colorized in long format, including dot files
alias crontab="crontab -i" # Add -i to every crontab command to ask everytime before deleting
## OSX aliases
if [[ $(uname -s) == 'Darwin' ]]; then
    ### (terminal_clearn, flushdns, lock and update ripped from @korni22)
    ### Cleanup terminal logfiles (http://osxdaily.com/2010/05/06/speed-up-a-slow-terminal-by-clearing-log-files/)
    alias terminal_clean="sudo rm -rf /private/var/log/asl/*.asl"

    ### Flush the DNS cache, again, cause I am a moron
    alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

    ### Lock the system
    alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

    ### Update alias to update OS X, Homebrew, Node packages and Ruby gems
    alias update="sudo -v; sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update"

    ### Firefox
    alias firefox="open /Applications/Firefox.app"
fi

# Functions
## Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}
## Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}
## Marks (http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html)
MARKPATH=$HOME/.marks
function j {
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
    rm -i $MARKPATH/$1
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# Github
git config --global user.name "Arne Bahlo"
git config --global user.email hallo@arne.me

# ZSH options
## Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_TITLE="true"

## Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sublime)

# Embed custom per-machine config
if [ -f "$HOME/.custom" ]; then
    source $HOME/.custom
fi

source $ZSH/oh-my-zsh.sh