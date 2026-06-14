#!/usr/bin/env bash
#
# Post-install assertions, run INSIDE the test container after ./install.sh.
# Verifies what the top-level installer produces: config symlinks, vim-plug,
# node (required by coc.nvim), and the CLI tools it installs.
#
# NOTE: ./install.sh only wires in vim (via install-vim.sh) + symlinks. The
# oh-my-zsh / zsh-plugins / tmux-plugins setup lives in install-zsh.sh and
# install-tmux.sh, which install.sh does not call — so those are NOT asserted here.
#
set -uo pipefail

fail=0
ok()  { printf '\033[1;32m  ok\033[0m  %s\n' "$*"; }
bad() { printf '\033[1;31mFAIL\033[0m  %s\n' "$*"; fail=1; }

check_link() {
  if [ -L "$1" ]; then ok "symlink $1 -> $(readlink "$1")"; else bad "missing symlink $1"; fi
}
check_cmd() { if command -v "$1" >/dev/null; then ok "cmd $1"; else bad "missing cmd $1"; fi; }

echo "== symlinks =="
check_link "$HOME/.zshrc"
check_link "$HOME/.vimrc"
check_link "$HOME/.tmux.conf"

echo "== vim-plug =="
if [ -f "$HOME/.vim/autoload/plug.vim" ]; then ok "vim-plug installed"; else bad "vim-plug missing"; fi

echo "== tools install.sh provides =="
for c in vim node rg fzf tmux; do check_cmd "$c"; done

echo
if [ "$fail" -eq 0 ]; then
  printf '\033[1;32mIntegration checks passed.\033[0m\n'
else
  printf '\033[1;31mIntegration checks failed.\033[0m\n'
fi
exit "$fail"
