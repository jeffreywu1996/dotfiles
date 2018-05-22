#!/bin/bash
echo "This script installs vimrc and its plugin to ~/."

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Checking if homebrew exists ..."
    if ! hash brew 2> /dev/null; then
        echo "Installing homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if [ `command -v vim` != "/usr/local/bin/vim" ]; then
        echo "Installing homebrew vim"
        brew install vim --override-system-vi
        brew install macvim --override-system-vim
        brew link vim
        ln -s /usr/local/bin/mvim vim
    fi
fi

echo "Installing vim plug"
curl -ss -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


echo "Cloning vimrc repo"
#ln -sf alt_vimrc/simple_vimrc ~/.vimrc
cp alt_vimrc/simple_vimrc ~/.vimrc
vim +PlugInstall +qall

echo "Setup Done"
