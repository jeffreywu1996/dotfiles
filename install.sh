#!/usr/bin/env bash

set -e  # Exit on error

BASE=$(pwd)

# Check OS and run appropriate setup
if [ "$(uname -s)" = 'Darwin' ]; then
    echo "Setting up for macOS..."

    # Install Homebrew if not present
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install macOS specific packages
    brew install \
        ripgrep \
        fd \
        fzf \
        reattach-to-user-namespace \
        tmux

elif [ "$(uname -s)" = 'Linux' ]; then
    echo "Setting up for Linux..."
    sudo apt-get update
    sudo apt-get install -y \
        ripgrep \
        fd-find \
        fzf \
        tmux
else
    echo "Unsupported operating system"
    exit 1
fi

# zsh setup
echo "Setting up zsh configuration..."
[ -f ~/.zshrc ] && mv -v ~/.zshrc ~/.zshrc.old 2> /dev/null
ln -sf "$BASE/zshrc" ~/.zshrc

# vim setup
echo "Setting up vim configuration..."
bash ./install-vim.sh

# tmux setup
echo "Setting up tmux configuration..."
[ -f ~/.tmux.conf ] && mv -v ~/.tmux.conf ~/.tmux.conf.old 2> /dev/null
ln -sf "$BASE/tmux.conf" ~/.tmux.conf

echo "Installation complete! Please restart your terminal."
