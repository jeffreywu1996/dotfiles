# CLAUDE.md

Guidance for AI agents working in this repo. User-facing setup docs live in
[README.md](README.md) — don't duplicate them here. This file is for how to work
on the dotfiles safely and the non-obvious traps discovered the hard way.

## What this repo is

Portable vim / tmux / zsh configs plus a single `install.sh` that bootstraps a
fresh machine. Targets macOS (Homebrew) and Debian/Ubuntu (apt): local Mac, mac
mini, WSL, Raspberry Pi. Synology is best-effort (symlinks only, no package mgr).

The configs (`vimrc`, `tmux.conf`, `zshrc`) are **symlinked** into `$HOME` by
`install.sh`. So editing a file in the repo changes the live config immediately;
`git pull` alone updates a machine's configs (re-run `install.sh` only to pick up
new tools/plugins).

## Workflow rules

- **Run `./test.sh` before every commit/push.** It's fast (<2s) and gates on
  shellcheck, `zsh -n`/`bash -n`, `vint vimrc`, and a tmux load test.
- **Keep everything portable.** No hardcoded `/Users/...` or OS-specific paths in
  the configs — use `$HOME` and guard OS/tool-specific blocks with
  `command -v <tool>` or `[ -d <path> ]` so the same file is a no-op elsewhere.
- **`install.sh` must stay non-interactive.** Fresh/unattended installs (and CI)
  hang on any prompt. Preserve: `DEBIAN_FRONTEND=noninteractive` + `sudo -E` for
  apt, `NONINTERACTIVE=1` for Homebrew, `--unattended` for oh-my-zsh,
  `</dev/null` for `vim +PlugInstall`, and the `[ ! -t 0 ]` tty-skip for `chsh`.
- **`install.sh` is idempotent** — guard clones/installs with existence checks so
  re-runs are safe.

## Testing

- `./test.sh` — static lint suite (run locally before pushing). `vint` needs
  `pipx install vim-vint && pipx inject vim-vint "setuptools<81"` (it imports the
  deprecated `pkg_resources`).
- `Dockerfile.test` — runs `install.sh` end-to-end on clean Debian, then
  `test-integration.sh` asserts symlinks/plugins/tools exist. This is the fresh-Pi
  / fresh-WSL parity check.
- `.github/workflows/ci.yml` — lint on Ubuntu+macOS, Docker integration on Ubuntu.
  Jobs have `timeout-minutes` so a hang fails fast instead of running 45 min.
- No Docker locally? Reproduce container behavior on a real Linux box (e.g. the Pi)
  by unsetting the relevant env, e.g. `env -u SSH_CONNECTION -u SSH_TTY zsh -ic ...`.

## Gotchas (don't relearn these)

- **oh-my-zsh `git_prompt_info` is async** on recent versions — it only echoes a
  cache filled by a background worker after first render. Calling it from a
  `precmd`/hook returns empty. The SSH prompt in `zshrc` computes the branch
  itself with `git symbolic-ref` synchronously for this reason. Don't "simplify"
  it back to `git_prompt_info`.
- **No-PTY zsh warning.** `zsh -ic` without a terminal (CI/Docker) makes zle-based
  plugins print `can't change option: zle`, and that non-zero status leaks through
  a bare `exit`. The interactive-load check in `test-integration.sh` greps for a
  sentinel echo instead of trusting the exit code. Keep it that way.
- **apt's fzf is too old** (0.38) for the `fzf --zsh` shell integration oh-my-zsh
  uses (needs ≥0.48). `install.sh` installs fzf from GitHub releases on Linux;
  don't move fzf back into the apt package list.
- **`.npmrc` `prefix`/`globalconfig` conflicts with nvm.** A system/nodesource npm
  writes these and nvm refuses to run. `install.sh` strips those lines before
  `nvm install`.
- **Headless vim throws on missing plugins.** `vim +PlugInstall` runs before
  plugins exist, so `colorscheme solarized` would abort with E185. It's
  `silent! colorscheme solarized` for that reason. Same class of issue: don't add
  bare plugin-dependent commands at vimrc top level without a guard.
- **Don't lint vimrc with headless `vim -es`** — it reports colorscheme/plugin
  errors that never happen interactively. Use `vint` (static) instead.
- **zsh plugin order matters:** `zsh-syntax-highlighting` must be last (or
  second-to-last), with `zsh-history-substring-search` after it.
- **tmux clipboard is `tmux-yank` + `set -g set-clipboard on`** (cross-platform,
  incl. OSC 52 passthrough). Don't reintroduce `reattach-to-user-namespace`
  (legacy macOS-only) or `default-shell /usr/bin/zsh` (breaks macOS).

## Layout

```
install.sh             unified installer (macOS + Debian); USER WISHLIST block at top
install-minimal        no-plugin vim fallback (uses alt_vimrc/minimal_vimrc)
vimrc tmux.conf zshrc   configs symlinked into $HOME
test.sh                static lint suite
test-integration.sh    post-install assertions (run inside Dockerfile.test)
Dockerfile.test        fresh-Debian end-to-end install + assert
.github/workflows/ci.yml  CI
```
