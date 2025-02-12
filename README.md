# Dotfiles

Personal dotfiles for development environment setup, supporting both macOS and Linux.

## Features
- Vim configuration with carefully selected plugins
- Tmux setup with modern features
- Zsh configuration with Oh My Zsh
- Cross-platform support (macOS and Linux)

## Quick Start
```bash
# Full installation (recommended)
./install.sh

# Vim-only installation
./install-vim.sh
```

## Manual Installation

### Prerequisites
- Git
- Vim 8.0+
- Tmux 2.7+
- Zsh
- Node.js (for CoC)

### macOS Prerequisites
```bash
# Install Homebrew if not already installed
/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"

# Install required packages
brew install \\
    ripgrep \\
    fd \\
    fzf \\
    reattach-to-user-namespace \\
    tmux
```

### Linux Prerequisites
```bash
sudo apt-get update
sudo apt-get install -y \\
    ripgrep \\
    fd-find \\
    fzf \\
    tmux
```

## Components

### Vim Setup
- Modern plugins managed by vim-plug
- CoC for code completion
- FZF for fuzzy finding
- NERDTree for file navigation
- Git integration with GitGutter
- Tmux integration
- Solarized color scheme

### Tmux Features
- Modern configuration
- Mouse support
- Vim-like keybindings
- Session persistence
- Copy-paste integration
- Solarized theme

### Zsh Configuration
- Oh My Zsh framework
- Custom plugins and themes
- Improved history
- Better completions
- FZF integration

## Installation Options

### Full Installation
Installs and configures everything:
```bash
./install.sh
```

### Component-specific Installation
```bash
# Vim only
./install-vim.sh

# Tmux only
./install-tmux.sh

# Zsh only
./install-zsh.sh
```

## Post-Installation

### Vim
1. Start vim and run `:PlugInstall`
2. For Python support: `pip install jedi`
3. For JS/TS support: `npm install -g typescript`

### Tmux
1. Start tmux with `tmux`
2. Install plugins with `prefix + I`

### Zsh
1. Install Oh My Zsh plugins
2. Restart your terminal

## File Structure
```
.
├── install.sh          # Main installation script
├── install-vim.sh      # Vim-specific installation
├── install-tmux.sh     # Tmux-specific installation
├── install-zsh.sh      # Zsh-specific installation
├── vimrc              # Vim configuration
├── tmux.conf          # Tmux configuration
└── zshrc              # Zsh configuration
```

## Customization
- Vim: Edit `vimrc`
- Tmux: Edit `tmux.conf`
- Zsh: Edit `zshrc`

## Troubleshooting

### Known Issues
1. If you see font issues in vim or tmux, install a Nerd Font:
   - macOS: `brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font`
   - Linux: Download from [Nerd Fonts](https://www.nerdfonts.com/)

2. For clipboard issues in tmux on macOS:
   - Ensure `reattach-to-user-namespace` is installed

### Common Solutions
- Run `:checkhealth` in vim for diagnostics
- Check `tmux -V` for version compatibility
- Ensure Node.js is installed for CoC functionality

## Contributing
Feel free to fork and submit pull requests.
