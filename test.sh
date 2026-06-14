#!/usr/bin/env bash
#
# Static validation for the dotfiles. Fast (<1s) — run before committing.
# Checks: shellcheck on the install scripts, syntax-parse of zshrc, a vint lint
# of vimrc, and a clean load of tmux.conf. Exits non-zero on the first failure.
#
# Usage:  ./test.sh
#
set -uo pipefail

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE" || exit 1

fail=0
pass() { printf '\033[1;32m  ok\033[0m  %s\n' "$*"; }
bad()  { printf '\033[1;31mFAIL\033[0m  %s\n' "$*"; fail=1; }
skip() { printf '\033[1;33mskip\033[0m  %s\n' "$*"; }

SCRIPTS=(install.sh install-vim.sh install-tmux.sh install-zsh.sh install-minimal test.sh test-integration.sh)

echo "== shellcheck =="
if command -v shellcheck >/dev/null; then
  for f in "${SCRIPTS[@]}"; do
    if shellcheck -x "$f"; then pass "$f"; else bad "$f"; fi
  done
else
  skip "shellcheck not installed (brew install shellcheck / apt install shellcheck)"
fi

echo "== shell syntax =="
if command -v zsh >/dev/null; then
  if zsh -n zshrc; then pass "zsh -n zshrc"; else bad "zsh -n zshrc"; fi
else
  skip "zsh not installed"
fi

echo "== vimrc lint =="
# Static vimscript lint (analog of shellcheck). `vim -es` is avoided: in headless
# Ex mode plugins/colorschemes throw errors that never occur interactively.
if command -v vint >/dev/null; then
  if vint vimrc; then pass "vint vimrc"; else bad "vint vimrc"; fi
else
  skip "vint not installed (pipx install vim-vint && pipx inject vim-vint 'setuptools<81')"
fi

echo "== tmux loads =="
if command -v tmux >/dev/null; then
  if tmux -f tmux.conf -L dotfiles_test new-session -d 2>/dev/null; then
    pass "tmux loads tmux.conf"
    tmux -L dotfiles_test kill-server 2>/dev/null
  else
    bad "tmux loads tmux.conf"
  fi
else
  skip "tmux not installed"
fi

echo
if [ "$fail" -eq 0 ]; then
  printf '\033[1;32mAll checks passed.\033[0m\n'
else
  printf '\033[1;31mSome checks failed.\033[0m\n'
fi
exit "$fail"
