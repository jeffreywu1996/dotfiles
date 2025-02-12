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

    # Install macOS specific dependencies
    print_status "Installing macOS specific dependencies..."
    brew install reattach-to-user-namespace
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    INSTALL_CMD="sudo apt-get install -y"

    # Update package list
    print_status "Updating package list..."
    sudo apt-get update

    # Install Linux specific dependencies
    print_status "Installing Linux specific dependencies..."
    sudo apt-get install -y xclip
else
    print_error "Unsupported operating system"
    exit 1
fi

# Install tmux if not already installed
if ! command -v tmux >/dev/null 2>&1; then
    print_status "Installing tmux..."
    $INSTALL_CMD tmux
else
    print_success "tmux is already installed"
fi

# Backup existing tmux.conf if it exists
if [ -f "$HOME/.tmux.conf" ]; then
    print_status "Backing up existing .tmux.conf..."
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Link tmux.conf
print_status "Linking tmux.conf..."
ln -sf "$(pwd)/tmux.conf" "$HOME/.tmux.conf"

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_status "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    print_success "tmux plugin manager is already installed"
fi

# Install tmux plugins
print_status "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

# Final instructions
print_success "tmux installation complete!"
echo ""
echo "To complete the setup:"
echo "1. Start tmux by typing 'tmux'"
echo "2. Press prefix + I (capital I) to install plugins"
echo "   - The prefix is Ctrl-a"
echo ""
echo "Basic tmux commands:"
echo "- Create new window: prefix + c"
echo "- Split pane horizontally: prefix + -"
echo "- Split pane vertically: prefix + ="
echo "- Navigate panes: Alt + arrow keys or prefix + h/j/k/l"
echo "- Reload config: prefix + r"
echo ""
echo "For more information, see the comments in ~/.tmux.conf"

if [ "$OS" = "linux" ]; then
    echo ""
    echo "Note: On Linux, you may need to log out and back in for all changes to take effect."
fi
