"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Jeffrey Wu
" Sections:
"       -> Vundle Plugin
"       -> Themes
"       -> General
"       -> Text, tabs
"       -> Visual
"       -> Highlight
"       -> Vim interface
"       -> Files
"       -> Moving around
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
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
" Vim Airline themes
Plugin 'vim-airline/vim-airline-themes'
" Syntastic
" Plugin 'scrooloose/syntastic'
" Color Schemes
Bundle "daylerees/colour-schemes", { "rtp": "vim/" }

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOLARIZED
" let g:solarized_termcolors=256
"set background=dark     " dark background
"set background=light    " light background
"colorscheme solarized
colorscheme Tomorrow-Night
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open .vimrc
nnoremap <leader>v :tabnew ~/.vimrc<CR>

" page up and page downs
nnoremap <leader>o <C-D>
nnoremap <leader>p <C-U>

" copy to system clipboard
nnoremap <leader>i "+

" clipboard
set clipboard=unnamed

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
" let mapleader = ","
" let g:mapleader = ","

" Fast undo
nnoremap <leader>z :u<cr>

" Fast saving
nmap <leader>w :w!<cr>

syntax enable    " syntax on
set mouse=a      " enable use of mouse

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"set hidden
"set linebreak

" set font size
if has('gui_running')
  set guifont=Menlo:h13
endif

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


""""""""""""""""""""""""""""""
" => Highlight
""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" Don't redraw while executing macros (good performance config)
set lazyredraw 
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch 
:nmap \q :nohlsearch<CR>


"""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""
set wildmenu
set cmdheight=2
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

""""""""""""""""""""""""""""
" Files, backup
"""""""""""""""""""""""""""
" Turn off backup
set noswapfile

" default is unix, never crlf
set fileformats=unix,dos

" don't beep
set noeb vb t_vb=

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

""""""""""""""""""""""""""""
" Moving around
""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

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

" move around screen
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>h <C-W>h
nnoremap <leader>r <C-W>r

" NERDTree toggle
map <leader>nt :NERDTreeToggle<CR>

" Syntastic
"let g:syntastic_auto_loc_list=1
"let g:syntastic_disabled_filetypes=['html']
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_open=1
"let g:syntastic_enable_signs=1

" Airline fix
set laststatus=2
set ttimeoutlen=50

" You complete me
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py'
autocmd CompleteDone * pclose
