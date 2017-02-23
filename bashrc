# bash file
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#export TERM=xterm-256color

# Python
#export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
# Virtual Env
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper_lazy.sh
# pip should only run if there is a virutalenv activated
export PIP_REQUIRE_VIRTUALENV=true
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

#Mongo
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

# React Android_home
#export ANDROID_HOME=/Users/jeffreywu/Library/Android/sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
#export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Java Classpath for JUnit
export JAVA_HOME="$(/usr/libexec/java_home)"
#export JUNIT_HOME="$HOME/java"
#export PATH="/usr/local/bin:$PATH:$JUNIT_HOME"
#export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

# Use macvim
#alias vim='mvim '

# Colors
#solar=gxfxbEaEBxxEhEhBaDaCaD
#linux=gxBxhxDxfxhxhxhxhxcxcx
#export CLICOLOR=1
#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Alias for short commands
alias hs="history | grep "  # Automatically filter your bash history
alias l='ls'  # Colorized listing
alias ls='ls -G' # ls color
alias la='ls -a'  # List all files
alias ld='ls -F | grep /$' # List directories
alias ll='ls -l' # Long list of files
alias lla='ls -la' # Long list of files

alias cdd='cd ~/Desktop' # Goes to Desktop
alias cdown='cd ~/Downloads' # Goes to Downloads
alias cs='cd ~/cs' # Goes to cs
alias cdrive='cd /Volumes/Transcend/Google\ Drive' # Goes to Google Drive
alias cdocs='cd /Volumes/Transcend/Google\ Drive/Documents' # Goes to Documents
alias trans='cd /Volumes/Transcend'

alias mv='mv -i'
alias cp='cp -i'

# Make logging into your account a breeze:
#username30pi=pi@spispis-30ffl.local
#alias sshpi='ssh -X pi@jeffreywu.duckdns.org'

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'

# Show hidden files
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# brew updates
alias update='brew update && brew upgrade'

export NVM_DIR="/Users/jeffreywu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias whichenv='echo $VIRTUAL_ENV'
alias timeout='gtimeout'

alias cqlstart='launchctl start homebrew.mxcl.cassandra'
alias cqlstop='launchctl stop homebrew.mxcl.cassandra'
