#!/usr/bin/env bash
#
# Unified dotfiles installer.
# Detects the OS, installs packages + plugin managers, and symlinks the configs.
# Safe to re-run (idempotent). Targets: macOS (Homebrew) and Debian/Ubuntu (apt).
# Synology / other: package install is skipped with a notice; symlinks still apply.
#
# Usage:  ./install.sh
#
set -euo pipefail

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Git identity used when not already configured.
GIT_NAME="Jeffrey Wu"
GIT_EMAIL="jeffreywu1996@gmail.com"

# ===========================================================================
# USER WISHLIST — edit these freely to add your own tools.
# ===========================================================================
# Extra OS packages installed via the package manager (brew on macOS, apt on
# Debian). Use the common name; add per-OS overrides below if they differ.
EXTRA_PACKAGES=(jq htop wget tree)

# Global npm CLIs (installed after node is set up).
NPM_GLOBALS=()

# Node version to install via nvm ("--lts" or e.g. "20"). Override via env.
NODE_VERSION="${NODE_VERSION:-"--lts"}"

# Install the Claude Code CLI (native installer -> ~/.local/bin/claude).
# Override via env, e.g. INSTALL_CLAUDE_CODE=false ./install.sh
INSTALL_CLAUDE_CODE="${INSTALL_CLAUDE_CODE:-true}"
# ===========================================================================

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }

OS="$(uname -s)"
PM=""   # package manager: brew | apt | none
case "$OS" in
  Darwin) PM="brew" ;;
  Linux)  command -v apt-get >/dev/null && PM="apt" || PM="none" ;;
  *)      PM="none" ;;
esac

# ---------------------------------------------------------------------------
# 1. Packages
# ---------------------------------------------------------------------------
install_packages() {
  case "$PM" in
    brew)
      if ! command -v brew >/dev/null; then
        info "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      info "Installing packages via brew"
      brew install git zsh tmux vim neovim fzf ripgrep fd bat eza zoxide curl python3 "${EXTRA_PACKAGES[@]}" || true
      ;;
    apt)
      info "Installing packages via apt"
      sudo apt-get update
      # bat ships as batcat, fd as fd-find on Debian/Ubuntu; eza may be unavailable on older releases.
      sudo apt-get install -y git zsh tmux vim neovim fzf ripgrep fd-find bat zoxide curl \
        python3 python3-pip "${EXTRA_PACKAGES[@]}" || true
      sudo apt-get install -y eza 2>/dev/null || warn "eza not in apt repos; install manually if wanted"
      ;;
    none)
      warn "Unsupported package manager (likely Synology/other)."
      warn "Install manually: git zsh tmux vim neovim fzf ripgrep fd bat eza zoxide curl python3"
      warn "Plus extras: ${EXTRA_PACKAGES[*]}"
      ;;
  esac
}

# ---------------------------------------------------------------------------
# 1b. Runtimes: nvm + node (required by coc.nvim / vim-prettier)
# ---------------------------------------------------------------------------
install_runtimes() {
  export NVM_DIR="$HOME/.nvm"
  if [ ! -s "$NVM_DIR/nvm.sh" ] && [ ! -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    info "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  fi
  # Load nvm into this shell so we can install node now.
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  # shellcheck source=/dev/null
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
  if command -v nvm >/dev/null; then
    info "Installing node ($NODE_VERSION) via nvm"
    nvm install "$NODE_VERSION" || warn "nvm install node reported an issue"
  else
    warn "nvm not loaded; skipping node install (coc.nvim needs node — install it manually)"
  fi
}

# ---------------------------------------------------------------------------
# 2. oh-my-zsh + custom zsh plugins
# ---------------------------------------------------------------------------
install_zsh_stack() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  clone_or_skip() { [ -d "$2" ] || git clone --depth=1 "$1" "$2"; }
  info "Installing zsh plugins"
  clone_or_skip https://github.com/zsh-users/zsh-autosuggestions          "$custom/plugins/zsh-autosuggestions"
  clone_or_skip https://github.com/zsh-users/zsh-syntax-highlighting      "$custom/plugins/zsh-syntax-highlighting"
  clone_or_skip https://github.com/zsh-users/zsh-history-substring-search "$custom/plugins/zsh-history-substring-search"
  clone_or_skip https://github.com/Aloxaf/fzf-tab                         "$custom/plugins/fzf-tab"
}

# ---------------------------------------------------------------------------
# 3. vim-plug + tpm
# ---------------------------------------------------------------------------
install_plugin_managers() {
  info "Installing vim-plug"
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  info "Installing tpm (tmux plugin manager)"
  [ -d "$HOME/.tmux/plugins/tpm" ] || \
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}

# ---------------------------------------------------------------------------
# 4. Symlink configs (back up anything pre-existing and non-symlinked)
# ---------------------------------------------------------------------------
link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    warn "Backing up $dest -> $dest.old"
    mv -f "$dest" "$dest.old"
  fi
  ln -sfn "$src" "$dest"
}

symlink_configs() {
  info "Symlinking configs"
  link "$BASE/vimrc"     "$HOME/.vimrc"
  link "$BASE/tmux.conf" "$HOME/.tmux.conf"
  link "$BASE/zshrc"     "$HOME/.zshrc"
}

# ---------------------------------------------------------------------------
# 5. Install the plugins themselves (headless)
# ---------------------------------------------------------------------------
install_plugins() {
  info "Installing vim plugins"
  vim +PlugInstall +qall || warn "vim +PlugInstall reported an issue"
  info "Installing tmux plugins"
  # tpm normally gets this from a running tmux server; set it for headless install.
  TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins" \
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "tpm install reported an issue"
}

# ---------------------------------------------------------------------------
# 6. Git identity (only if unset)
# ---------------------------------------------------------------------------
setup_git() {
  git config --global user.name  >/dev/null 2>&1 || git config --global user.name  "$GIT_NAME"
  git config --global user.email >/dev/null 2>&1 || git config --global user.email "$GIT_EMAIL"
  # Sensible defaults (set unconditionally; harmless to re-apply)
  git config --global core.editor "vim"
  git config --global init.defaultBranch "main"
  git config --global pull.rebase false
}

# ---------------------------------------------------------------------------
# 7. Default shell -> zsh (optional)
# ---------------------------------------------------------------------------
set_default_shell() {
  # Already on a zsh? Nothing to do (covers /bin/zsh vs brew zsh).
  case "${SHELL:-}" in */zsh) return 0 ;; esac
  local zsh_path; zsh_path="$(command -v zsh || true)"
  [ -n "$zsh_path" ] || return 0
  # chsh only accepts shells listed in /etc/shells.
  if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
    warn "zsh ($zsh_path) is not in /etc/shells; leaving your shell unchanged."
    warn "To switch later: echo $zsh_path | sudo tee -a /etc/shells && chsh -s $zsh_path"
    return 0
  fi
  info "Setting default shell to zsh (may prompt for password)"
  chsh -s "$zsh_path" || warn "Could not change shell automatically; run: chsh -s $zsh_path"
}

# ---------------------------------------------------------------------------
# 8. Extras: global npm CLIs + Claude Code (wishlist tools)
# ---------------------------------------------------------------------------
install_extras() {
  if [ "${#NPM_GLOBALS[@]}" -gt 0 ]; then
    if command -v npm >/dev/null; then
      info "Installing npm globals: ${NPM_GLOBALS[*]}"
      npm install -g "${NPM_GLOBALS[@]}" || warn "npm global install reported an issue"
    else
      warn "npm not found; skipping npm globals: ${NPM_GLOBALS[*]}"
    fi
  fi

  if [ "${INSTALL_CLAUDE_CODE:-false}" = true ]; then
    if command -v claude >/dev/null; then
      info "Claude Code already installed ($(command -v claude))"
    else
      info "Installing Claude Code CLI"
      curl -fsSL https://claude.ai/install.sh | bash || warn "Claude Code install reported an issue"
    fi
  fi
}

main() {
  install_packages
  install_runtimes
  install_zsh_stack
  install_plugin_managers
  symlink_configs
  install_plugins
  install_extras
  setup_git
  set_default_shell
  info "Done. Restart your shell (or 'exec zsh') to load everything."
}

# Only run when executed directly, so tests can source this file for its functions.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
