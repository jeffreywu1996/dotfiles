# Performance optimization - compile zcompdump in background
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="minimal"

# Disable marking untracked files under VCS as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Better path management
typeset -U path PATH
path=(
  /usr/local/bin
  $HOME/bin
  $path
)

# History configuration
export HISTSIZE=10000000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY       # Write to the history file immediately
setopt SHARE_HISTORY           # Share history between all sessions

# Plugins
plugins=(
  git
  zsh-autosuggestions
  docker
  docker-compose
  extract
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
autoload -U compinit && compinit

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Aliases
alias ll='ls -lah'
alias zshconfig="$EDITOR ~/.zshrc"
alias sshconfig="$EDITOR ~/.ssh/config"
alias dotfiles='cd $HOME/.dotfiles'
alias gst='git status'
alias gl='git pull'
alias gp='git push'

# Utility Functions
Rg() {
  local selected=$(
    rg --column --line-number --no-heading --color=always --smart-case "$1" |
      fzf --ansi --preview "~/.vim/plugged/fzf.vim/bin/preview.sh {}"
  )
  [ -n "$selected" ] && $EDITOR "$selected"
}

# Switch tmux-sessions
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# Quick directory jumping
j() {
  [ $# -gt 0 ] && cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# FZF configuration
if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git --exclude node_modules'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
