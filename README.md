# Dotfiles

My dotfiles.

# TODO
- Finish install-zsh.sh script
- Install github ssh keys

## Setup
1. Simple vimrc - Setup vim on new comp
```
./install-vim
```

2. Minimal vimrc - Get a minimally usable vim without plugins
```
./install-minimal
```


# Setup Files (OLD)

This includes basic setup files for vim and zsh (or bash).

## Directions

Run script `install_simple_vimrc.sh` to install a simple usable version of vimrc to make vim usable.

(Not updated) Run script `install_mac.sh` to install a full version of vimrc.

## Setting up on a new machine

#### Setup bashrc on MacOS
First check if `.bashrc`, if not, add the following line to either `.bash_profile` or `.profile`.

```
# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc
```

This line links MacOS to use `.bashrc`. Now we can just copy `.bashrc`.

#### Install Homebrew vim on MacOS
Get [Homebrew](http://brew.sh/)

```brew install macvim --override-system-vim```
```brew install vim --override-system-vi```

And `brew linkapps` or `brew link vim` to link MacOS to use the homebrew vim.

```ln -s /usr/local/bin/mvim vim```

Might work as well.

Follow this [link](http://stackoverflow.com/questions/21694327/installing-vim-with-homebrew) for more details on installing vim with homebrew.

## Setup vim

First install a plugin manager, [Plug](https://github.com/junegunn/vim-plug).

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then start vim with `vim` in command line.
Type `:PlugInstall` then enter to install all the plugins used in vimrc.

Now all plugins should be installed and ready to use.

The plugin [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) requires addition steps.
Run these command to install compile correctly.

```
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer --tern-completer
```

Ycm also requires a `ycm_extra_conf.py` file to have autocomplete working correctly. A sample of this file is placed in this directory and vimrc has it pointed to this directory (This means ycm should just work, given that this folder is placed at the root(~/)).

## Vim Colors
To get more color themes, copy the folder `colors` in this directory to `~/.vim`.

## Linking files
Run these command to symlink system's setup files to this folder. The benefit is that system's setup files will update with this folder.

Linking vimrc
```ln -sf ~/setup/vimrc ~/.vimrc```

Linking zshrc
```ln -sf ~/setup/zshrc ~/.zshrc```

Linking bashrc
```ln -sf ~/setup/bashrc ~/.bashrc```

## Python
Install python with ```brew install python```.

Install python 3 with ```brew install python3```.

### Virtualenv
Install virtualenvwrapper with ```pip install virtualenvwrapper```.
TODO... Instructions on how to set up virtual prompt for zsh(postactivate stuff)








## Instructions
### Python
#### Virtualenv
`mkvirtualenv` creates a new virtualenv
`rmvirtualenv` deletes a virtualenv
`workon virtualenv_name` transfers to that virutalenv
`deactivate` deactivates
