# bash file
# mongo
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

# React Android_home
export ANDROID_HOME=/Users/jeffreywu/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Java Classpath for JUnit
export JUNIT_HOME="$HOME/java"
export PATH="/usr/local/bin:$PATH:$JUNIT_HOME"
export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Use macvim
#alias vim='mvim '

# Colors
solar=gxfxbEaEBxxEhEhBaDaCaD
linux=gxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

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
alias cdrive='cd ~/Google\ Drive' # Goes to Google Drive
alias cdocs='cd ~/Google\ Drive/Documents' # Goes to Documents

alias mv='mv -i'
alias cp='cp -i'

# Make logging into your account a breeze:
username30=cs30ffl
alias cs30='ssh ${username30}@ieng6.ucsd.edu'

username30pi=pi@spispis-30ffl.local
alias sshpi='ssh -X pi@jeffreywu.duckdns.org'

alias cs100='ssh cs100wdq@ieng6.ucsd.edu'
alias cs100x='ssh -X cs100wdq@ieng6-252.ucsd.edu'

# Lazy java compile
alias j='java '
alias jc='javac '
alias junit='java org.junit.runner.JUnitCore '

# Extract files
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Show hidden files
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Search package
alias searchpackage='pkgutil --pkgs | grep'
alias searchextension='kextstat | grep'

# brew updates
alias update='brew update && brew upgrade'

export NVM_DIR="/Users/jeffreywu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

