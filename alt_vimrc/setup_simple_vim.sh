#!/bin/bash
echo "Checking basic environment"
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
vim +PlugInstall +qall

echo "Cloning vimrc repo"
cd ~/
git clone https://github.com/jeffreywu1996/setup.git
ln -sf ~/setup/alt_vimrc/simple_vimrc ~/.vimrc
vim +PlugInstall +qall

echo "Copying Tomorrow theme colors"
mkdir -p ~/.vim/colors
cp ~/setup/colors/Tomorrow.vim ~/.vim/colors
cp ~/setup/colors/Tomorrow-Night.vim ~/.vim/colors

echo "Setup Done."
