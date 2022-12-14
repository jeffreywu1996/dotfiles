# Sets up environment with zsh and vim config

# Installs zsh
if [ -n "$ZSH_VERSION" ]; then
	echo "zsh not installed"
	echo "Installing zsh..."
	sudo apt update
	sudo apt install -y zsh
	echo "Setting zsh as default shell..."
	chsh -s $(which zsh)
fi

# Installs oh my zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh is installed"
else
 	echo "oh-my-zsh is not installed, installing..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Copy zshrc
echo "Copying zshrc"
mv ~/.zshrc ~/.zshrc.old
echo "Linking zshrc..."
ln -sf zshrc ~/.zshrc


# Install fzf
echo "Installing fzf..."
sudo apt-get install fzf


# TODO: Add more steps here
# Install tmux
sudo apt-get install tmux
