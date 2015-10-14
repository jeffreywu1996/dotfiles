# bash file

# Java Classpath for JUnit

export JUNIT_HOME="$HOME/java"
export PATH="/usr/local/bin:$PATH:$JUNIT_HOME"
export CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"

# Use macvim
alias vim='mvim '

# Alias for short commands
alias hs="history | grep "  # Automatically filter your bash history
alias l='ls -G'  # Colorized listing
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
username15=cs15sahk  # Store username as a variable
alias cs15='ssh -X ${username15}@ieng6.ucsd.edu'

username12=cs12sig
alias cs12='ssh ${username12}@ieng6.ucsd.edu'

username30=cs30ffl
alias cs30='ssh ${username30}@ieng6.ucsd.edu'

alias sshpi='ssh pi@spispis-30ffl.local'

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

# Brew Cask
alias gimp='open ~/Applications/"GIMP.app"'
alias chrome='open ~/Applications/"Google Chrome.app"'
alias vlc='open ~/Applications/"VLC.app"'
alias firefox='open ~/Applications/"Firefox.app"'
alias bt='open ~/Applications/"Transmission.app"'
