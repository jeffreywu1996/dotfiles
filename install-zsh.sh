#!/usr/bin/env bash

set -e  # Exit on error
set -u  # Exit on undefined variable

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print with color
print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_error() {
    echo -e "${RED}==>${NC} Error: $1"
}

print_success() {
    echo -e "${GREEN}==>${NC} $1"
}

# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    INSTALL_CMD="brew install"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    INSTALL_CMD="sudo apt-get install -y"
    # Update package list
    print_status "Updating package list..."
    sudo apt-get update
else
    print_error "Unsupported operating system"
    exit 1
fi

# Install zsh if not already installed
if ! command -v zsh >/dev/null 2>&1; then
    print_status "Installing zsh..."
    $INSTALL_CMD zsh
    print_status "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
else
    print_success "zsh is already installed"
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_success "Oh My Zsh is already installed"
fi

# Install required packages
PACKAGES=(
    "fzf"
    "ripgrep"
    "tmux"
)

# macOS specific packages
if [ "$OS" = "macos" ]; then
    PACKAGES+=("fd")
fi

# Linux specific packages
if [ "$OS" = "linux" ]; then
    PACKAGES+=("fd-find")
fi

# Install packages
for package in "${PACKAGES[@]}"; do
    if ! command -v "$package" >/dev/null 2>&1; then
        print_status "Installing $package..."
        $INSTALL_CMD "$package"
    else
        print_success "$package is already installed"
    fi
done

# Install Oh My Zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    print_status "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    print_status "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
fi

# Install zsh-history-substring-search
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-history-substring-search" ]; then
    print_status "Installing zsh-history-substring-search..."
    git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"
fi

# Backup existing zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    print_status "Backing up existing .zshrc..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Link zshrc
print_status "Linking zshrc..."
ln -sf "$(pwd)/zshrc" "$HOME/.zshrc"

# Set up Git configuration
print_status "Configuring Git..."
git config --global user.name "Jeffrey Wu"
git config --global user.email "jeffreywu1996@gmail.com"

# Additional Git configurations
git config --global core.editor "vim"
git config --global init.defaultBranch "main"
git config --global pull.rebase false

print_success "Installation complete! Please restart your terminal or run 'source ~/.zshrc'"
