#!/bin/bash
echo "Adding some basic aliases to this machine's bashrc..."

if [ ! -f ~/.bashrc ]; then
  echo ".bashrc not found on this machine!"
  echo "Aliases cannot be added"
  exit 1
fi


cd ~/
git clone https://github.com/jeffreywu1996/setup.git
cat ~/setup/alt_vimrc/bash_alias >> ~/.bashrc

echo "Done."
