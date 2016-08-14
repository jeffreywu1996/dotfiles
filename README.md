# .vimrc .bashrc setup

Now using symlink to link vimrc and bashrc files

colors folder includes Tomorrow Color Theme

ycm config file

# Setting up new machine
ToDo....
## MacOS
Check if .bashrc exists, if not add the following line to either .bash_profile or .profile
`# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc`
This line links MacOS to use .bashrc. Now we can just copy .bashrc.

### Install vim
Get Homebrew
`brew install macvim --override-system-vim`
`brew install vim --override-system-vi`
`brew linkapps`
`brew link vim`
http://stackoverflow.com/questions/21694327/installing-vim-with-homebrew

### Linking files
Linking vimrc
ln -sf ~/setup/vimrc ~/.vimrc

Linking zshrc
ln -sf ~/setup/zshrc ~/.zshrc

Linking bashrc
ln -sf ~/setup/bashrc ~/.bashrc
