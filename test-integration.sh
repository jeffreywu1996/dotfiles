#!/usr/bin/env bash
#
# Post-install assertions, run INSIDE the test container after ./install.sh.
# Verifies the install produced the symlinks, plugin managers, and tools we expect.
#
set -uo pipefail

fail=0
ok()  { printf '\033[1;32m  ok\033[0m  %s\n' "$*"; }
bad() { printf '\033[1;31mFAIL\033[0m  %s\n' "$*"; fail=1; }

check_link() {  # $1 = path that should be a symlink
  if [ -L "$1" ]; then ok "symlink $1 -> $(readlink "$1")"; else bad "missing symlink $1"; fi
}
check_dir() { if [ -d "$1" ]; then ok "dir $1"; else bad "missing dir $1"; fi; }
check_cmd() { if command -v "$1" >/dev/null; then ok "cmd $1"; else bad "missing cmd $1"; fi; }

echo "== symlinks =="
check_link "$HOME/.zshrc"
check_link "$HOME/.vimrc"
check_link "$HOME/.tmux.conf"

echo "== plugin managers / plugins =="
check_dir "$HOME/.oh-my-zsh"
check_dir "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
check_dir "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
check_dir "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search"
check_dir "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
check_dir "$HOME/.tmux/plugins/tpm"
if [ -f "$HOME/.vim/autoload/plug.vim" ]; then ok "vim-plug installed"; else bad "vim-plug missing"; fi

echo "== core tools =="
for c in git zsh tmux vim fzf rg; do check_cmd "$c"; done

echo "== node (required by coc.nvim) =="
# nvm installs node into the shell, not onto PATH for non-login shells, so source it.
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
check_cmd node

echo "== zshrc actually loads under zsh =="
if zsh -ic 'exit' >/dev/null 2>&1; then ok "interactive zsh starts"; else bad "interactive zsh failed"; fi

echo
if [ "$fail" -eq 0 ]; then
  printf '\033[1;32mIntegration checks passed.\033[0m\n'
else
  printf '\033[1;31mIntegration checks failed.\033[0m\n'
fi
exit "$fail"
