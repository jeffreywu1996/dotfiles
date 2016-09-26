#!/bin/bash
echo "Copying minimal vimrc repo."
cd ~/
git clone https://github.com/jeffreywu1996/setup.git
cp ~/setup/alt_vimrc/minimal_vimrc ~/.vimrc
rm -rf ~/setup

echo "Setup Done."
