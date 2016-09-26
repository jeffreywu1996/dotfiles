#!/bin/bash

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

echo "Installing vim plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall

echo "Cloning vimrc repo"
cd ~/
git clone https://github.com/jeffreywu1996/setup.git
ln -sf ~/setup/vimrc ~/.vimrc
vim +PlugInstall

echo "Copying theme colors"
cp -r ~/setup/colors ~/.vim/

echo "Installing YouCompleteMe"
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer --tern-completer

echo "Setup Done."
