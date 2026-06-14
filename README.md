# Dotfiles

Portable vim / tmux / zsh config and a one-command installer.

## Quickstart

```sh
git clone https://github.com/jeffreywu1996/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
exec zsh
```

`install.sh` detects your OS, installs the packages, runtimes (nvm + node, needed
by coc.nvim), and plugin managers, then symlinks `vimrc`, `tmux.conf`, and `zshrc`
into `$HOME` (backing up any existing files to `*.old`). It is safe to re-run.

Want vim without any plugins? `./install-minimal` symlinks a stripped-down vimrc.

### Adding your own tools

Edit the **USER WISHLIST** block near the top of `install.sh`:

```sh
EXTRA_PACKAGES=(jq htop wget tree)   # installed via brew/apt
NPM_GLOBALS=(typescript)             # installed via npm -g after node is set up
NODE_VERSION="--lts"                 # nvm node version
INSTALL_CLAUDE_CODE=true             # Claude Code CLI -> ~/.local/bin/claude
```

Each is also overridable per-run via env, e.g. `INSTALL_CLAUDE_CODE=false ./install.sh`.

## Supported machines

| Machine                | Support | Package manager        |
| ---------------------- | ------- | ---------------------- |
| macOS (Apple Silicon)  | Full    | Homebrew               |
| WSL (Debian/Ubuntu)    | Full    | apt                    |
| Raspberry Pi (Debian)  | Full    | apt                    |
| mac mini               | Full    | Homebrew               |
| Synology DSM           | Manual  | none — see below       |

The configs themselves are portable (no hardcoded paths); only the package
install differs per OS. On **Synology**, `install.sh` skips package install and
just symlinks — install `git zsh tmux vim fzf ripgrep fd bat zoxide` yourself via
[Entware](https://github.com/Entware/Entware)/`opkg` first.

## What you get

- **Prompt** shows the hostname when you're on an SSH session (e.g. `raspberrypi ~ »`),
  so it's always clear which box you're on. Local sessions keep the clean minimal prompt.
- **Modern CLI tools**, aliased only when installed: `eza` (ls), `bat` (cat),
  `zoxide` (smart cd), `fzf` + `ripgrep` + `fd`.
- **vim** with coc.nvim (pyright/tsserver/eslint/prettier/json), fzf, NERDTree,
  gitgutter, lightline, tmux navigation, solarized.
- **tmux** with prefix `C-a`, mouse on, vim copy-mode, cross-platform clipboard via
  tmux-yank, and resurrect/continuum session save-restore.

### Handy keys

- tmux: `C-a` prefix · `=` / `-` split · `Alt-arrows` switch pane · `prefix r` reload ·
  copy-mode `v` select, `y` yank to system clipboard.
- vim: `<leader>t` files · `<leader>f` ripgrep · `<leader>d` NERDTree · `jj` escape ·
  `gd` go-to-definition.
- shell: `fs` fuzzy-switch tmux session · `Rg <pattern>` ripgrep + open in editor.

## Testing

```sh
./test.sh                              # fast static checks (run before committing)
docker build -f Dockerfile.test -t dotfiles-test .   # full install on clean Debian
```

- **`test.sh`** — runs `shellcheck` on the shell scripts, `zsh -n`/`bash -n` syntax
  checks, `vint` on `vimrc`, and a `tmux.conf` load test. Missing tools are skipped,
  not failed. Install the linters with `brew install shellcheck` and
  `pipx install vim-vint && pipx inject vim-vint "setuptools<81"`.
- **`Dockerfile.test`** — runs `install.sh` end-to-end on a fresh Debian container,
  then `test-integration.sh` asserts the symlinks, plugin managers, and tools exist.
  A green build means a clean machine would install correctly.
- **CI** — `.github/workflows/ci.yml` runs the lint suite on Ubuntu **and** macOS and
  the Docker integration test on every push/PR.

vint is gated on errors only (see `.vintrc.yaml`); Google-style-guide warnings are
ignored intentionally.

## Layout

```
install.sh           unified installer (macOS + Debian)
install-minimal      no-plugin vim fallback
vimrc tmux.conf zshrc  the configs that get symlinked
test.sh              static checks; Dockerfile.test + test-integration.sh  e2e
.github/workflows/   CI
alt_vimrc/           minimal vimrc + bash aliases
old/                 archived bashrc/zshrc (reference only)
```
