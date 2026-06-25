# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Compile the completion dump in the background to speed up startup.
{
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Keep PATH entries unique (no duplicates).
typeset -U path PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
command -v go >/dev/null && export PATH="$PATH:$(go env GOPATH)/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  fzf-tab
  docker
  docker-compose
  extract
  zsh-syntax-highlighting
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

_venv_prompt_info() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "(${VIRTUAL_ENV:t}) "
}

setopt PROMPT_SUBST
PROMPT='$(_venv_prompt_info)%2~ $(vcs_status)»%b '

# Show the server hostname in the prompt over SSH so it's clear which box you're on.
# We compute the git branch ourselves (synchronously) rather than using oh-my-zsh's
# git_prompt_info: recent oh-my-zsh makes that function async (it only echoes a cache
# populated by a background worker after the first render), so calling it from a hook
# returns empty. A direct `git symbolic-ref` is reliable and simple. Mirrors the
# minimal theme's [branch●] format (● = dirty).
if [[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" ]]; then
  autoload -Uz add-zsh-hook
  _ssh_prompt_precmd() {
    local branch gitinfo=""
    branch=$(command git symbolic-ref --short HEAD 2>/dev/null) \
      || branch=$(command git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      local dirty=""
      [[ -n "$(command git status --porcelain 2>/dev/null)" ]] && dirty="%F{red}●%f"
      gitinfo="%F{white}[%f${branch}${dirty}%F{white}]%f "
    fi
    PROMPT="$(_venv_prompt_info)%F{yellow}%m%f %2~ ${gitinfo}»%b "
  }
  add-zsh-hook precmd _ssh_prompt_precmd
fi

# History: large, shared across sessions, written immediately.
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY      # record timestamps
setopt INC_APPEND_HISTORY   # append as you go, not just on exit
setopt SHARE_HISTORY        # share history across running shells

# Preferred editor
export EDITOR='vim'

# Key bindings: Ctrl-arrow word nav, up/down history-substring search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -x '/Applications/Tailscale.app/Contents/MacOS/Tailscale' ] && \
  alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
alias gitb='git branch --sort=committerdate'
alias gst='git status'
alias gl='git pull'
alias gp='git push'

# Modern CLI replacements, only if installed (names differ on Debian: bat=batcat, eza)
command -v eza >/dev/null && alias ls='eza' && alias ll='eza -la' && alias tree='eza --tree'
command -v batcat >/dev/null && alias bat='batcat'
command -v bat >/dev/null && alias cat='bat --paging=never'
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
autoload -U compinit && compinit

Rg() {
  local preview_script="$HOME/.vim/plugged/fzf.vim/bin/preview.sh"
  local preview_cmd
  if [ -f "$preview_script" ]; then
    preview_cmd="$preview_script {}"
  elif command -v bat >/dev/null; then
    preview_cmd='bat --color=always {}'
  else
    preview_cmd='cat {}'
  fi
  local selected=$(
    rg --column --line-number --no-heading --color=always --smart-case "$1" |
      fzf --ansi --preview "$preview_cmd"
  )
  [ -n "$selected" ] && ${EDITOR:-vim} "$selected"
}

# Switch tmux-sessions
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}


if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git --exclude node_modules'
fi

source <(fzf --zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"

# nvm: source from Homebrew (Apple Silicon) or the default/manual install location
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity (mac-only paths; guarded so they no-op elsewhere)
[ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
[ -d "$HOME/.antigravity-ide/antigravity-ide/bin" ] && export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

# Machine-local overrides — not in the repo, never touched by git pull/install.sh.
# Put per-box aliases, PATH additions, or prompt tweaks in ~/.zshrc.local.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
