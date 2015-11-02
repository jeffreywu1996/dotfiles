set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Solarized Theme
Plugin 'altercation/vim-colors-solarized'
" NERD Commenter
Plugin 'scrooloose/nerdcommenter'
" NERD Tree
Plugin 'scrooloose/nerdtree'
" Vim Airline
Plugin 'bling/vim-airline'
" You Complete Me
Plugin 'Valloric/YouCompleteMe'
" Ctrlp
Plugin 'kien/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"let g:solarized_termcolors=256
"set background=dark " set background
set background=dark
colorscheme solarized

syntax enable    " syntax on
set mouse=a      " turn on mouse

set shortmess+=I " no splash
set nocompatible " vim only, no vi
set title        " terminal title = buffer title
set modeline     " always show modeline

set number       " linum
set ruler		 " shows char and line number
set showcmd      " show command info in minibuffer
set showmatch    " highlight matching parens
" set lisp         " lisp mode (conflicts with cindent)

" highlight 80 chars overflow, red bar down the 80th col
set colorcolumn=80

" autoindent!!
"set cindent 
set ai " auto indent
set si " smart indent
set expandtab
set smarttab

" uncomment & experiment for personal tab preferences
set tabstop=4
"set tw=4
"set softtabstop=4
"set expandtab   " tabs to spaces
set shiftwidth=4

set hidden
set linebreak
set wrap

" default is unix, never crlf
set fileformats=unix,dos

" don't beep
set noeb vb t_vb=

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Highlight search terms...
:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:set incsearch
:nmap \q :nohlsearch<CR>

"""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""
set wildmenu
set cmdheight=2
""""""""""""""""""""""""""""
" Files, backup
"""""""""""""""""""""""""""
" Turn off backup
set noswapfile

""""""""""""""""""""""""""""
" Moving around
""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" jj is escape
inoremap jj <esc>
