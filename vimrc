""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'gmarik/vundle'
"Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'KabbAmine/vCoolor.vim'
"Plug 'marijnh/tern_for_vim'
"Plug 'mxw/vim-jsx'
"Plug 'jelera/vim-javascript-syntax'
"Plug 'pangloss/vim-javascript'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors/'

call plug#end()

filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SOLARIZED
" let g:solarized_termcolors=256
"set background=dark     " dark background
set background=light    " light background
"colorscheme solarized
colorscheme Tomorrow-Night
"colorscheme Tomorrow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open .vimrc
nnoremap <silent> <leader>v :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w<CR>:source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo ' reloaded'"<CR>>

" page up and page downs
nnoremap <leader>0 <C-D>
nnoremap <leader>9 <C-U>

" fix copy paste to clipboard
set clipboard=unnamed

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Mapping leader to ,
" let mapleader = ","
" let g:mapleader = ","

" Fast undo/redo
nnoremap <leader>z :u<cr>
nnoremap <leader>Z <C-R>

" Fast saving/close
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>wq :wq<cr>

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
nnoremap <CR> :nohlsearch<cr>

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

" Make vertical splits thinner
hi VertSplit ctermbg=NONE guibg=NONE
set fillchars+=vert:│

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

""""""""""""""""""""""""""""
" Unorganized
""""""""""""""""""""""""""""
nnoremap <leader>b          :CtrlPBuffer<CR>
nnoremap <leader>d          :NERDTreeToggle<CR>
nnoremap <leader>f          :NERDTreeFind<CR>
nnoremap <leader>t          :CtrlP<CR>
nnoremap <leader>T          :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>]          :TagbarToggle<CR>
nnoremap <leader>g          :GitGutterToggle<CR>

" NERDTree toggle
map <leader>nt :NERDTreeToggle<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

"let g:syntastic_error_symbol = '❌'
"let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Airline fix
set laststatus=2
set ttimeoutlen=50

" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/setup/ycm_extra_conf.py'
autocmd CompleteDone * pclose
let g:ycm_python_binary_path = '/usr/local/bin/python' " python completion

" Color
"let g:indent_guides_auto_colors = 0
hi IndentGuidesEven  ctermbg=grey

" JSX in js files
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Gitgutter
let g:gitgutter_enabled = 0

" showfunction
map <leader>m :TagbarToggle<CR>

" White space
map <leader>l :ToggleWhitespace<CR>
map <leader>ll :StripWhitespace<CR>
let g:strip_whitespace_on_save = 1
