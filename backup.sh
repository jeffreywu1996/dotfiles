

echo "backing up vimrc, bashrc"
cd ..
mv .vimrc vimrcBackup
mv .bashrc bashrcBackup
mv vimrcBackup bashrcBackup setup
cd setup

DiffVim=$(diff vimrc vimrcBackup)
DiffBash=$(diff bashrc bashrcBackup)

if [ "$DiffVim" == "" ]
then
    rm vimrcBackup
    echo "vimrc not modified"
fi

if [ "$DiffBash" == "" ]
then
    rm bashrcBackup
    echo "bashrc not modifed"
fi

echo "backup complete"

