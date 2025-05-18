#!/usr/bin/env bash

set -e  # Exit on error
set -u  # Exit on undefined variable

BASE=$(pwd)
export GIT_SSL_NO_VERIFY=true

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} Error: $1"
}

print_success() {
    echo -e "${GREEN}==>${NC} $1"
}

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    if ! command -v brew >/dev/null 2>&1; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    INSTALL_CMD="brew install"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    INSTALL_CMD="sudo apt-get install -y"
    print_status "Updating package list..."
    sudo apt-get update
else
    print_error "Unsupported operating system"
    exit 1
fi

# Install vim-plug
print_status "Installing vim-plug..."
mkdir -p ~/.vim/autoload
curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

# Git configuration
print_status "Configuring Git..."
git config --global user.name "Jeffrey Wu"
git config --global user.email "jeffreywu1996@gmail.com"

# Backup and link vimrc
print_status "Setting up vimrc..."
[ -f ~/.vimrc ] && mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf "$BASE/vimrc" ~/.vimrc

# Install Node.js (needed by coc)
if ! command -v node > /dev/null; then
    print_status "Installing Node.js..."
    if [ "$OS" = "linux" ]; then
        curl -sL https://deb.nodesource.com/setup_23.x | sudo bash -
        sudo apt-get install -y nodejs
    elif [ "$OS" = "macos" ]; then
        brew install node
    fi
fi

# Install dependencies
print_status "Installing dependencies..."
if [ "$OS" = "linux" ]; then
    sudo apt-get install -y \
        fd-find \
        ripgrep \
        fzf
elif [ "$OS" = "macos" ]; then
    brew install \
        fd \
        ripgrep \
        fzf
fi

# Install vim plugins
print_status "Installing Vim plugins..."
vim +PlugInstall +qall

print_success "Vim configuration installed successfully!"
echo ""
echo "Next steps:"
echo "1. Start vim and run :CocInstall to install all CoC extensions"
echo "2. If you're using Python, run: pip install jedi"
echo "3. For JavaScript/TypeScript support, run: npm install -g typescript"
echo ""
echo "Optional: For better icons in NERDTree, install a Nerd Font"
echo "macOS: brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font"
echo "Linux: https://www.nerdfonts.com/font-downloads"
