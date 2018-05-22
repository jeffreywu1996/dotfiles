#!/bin/bash
echo "Adding some basic aliases to this machine's bashrc..."

if [ ! -f ~/.bashrc ]; then
  echo ".bashrc not found on this machine!"
  echo "Aliases cannot be added"
  exit 1
fi

cat bash_alias >> ~/.bashrc

echo "Done."
