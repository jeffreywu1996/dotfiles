"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SIMPLE VIMRC

" Maintainer:
"       Jeffrey Wu
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'davidhalter/jedi-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'posva/vim-vue'
Plug 'jiangmiao/auto-pairs'

" AutoComplete
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" Lint
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Color Themes
Plug 'chriskempson/vim-tomorrow-theme'

call plug#end()

filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme Tomorrow-Night

" disable Background Color Erase on windows ubuntu subsystem
if &term =~ '256color'
    set t_ut=
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set encoding
set encoding=utf-8

" open .vimrc
nnoremap <silent> <leader>v :tabnew ~/.vimrc<CR>
nnoremap <silent> <leader>vs :w<CR>:source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo ' reloaded'"<CR>>

" fix copy paste to clipboard
set clipboard=unnamedplus

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Fast undo/redo
nnoremap <leader>z :u<cr>
nnoremap <leader>Z <C-R>

" Fast saving/close
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>wq :wq<cr>

syntax enable    " syntax on
set mouse+=a      " enable use of mouse
if !has('nvim')
  set ttymouse=xterm2
endif


set shortmess+=I " no splash
set nocompatible " vim only, no vi
set title        " terminal title = buffer title
set modeline     " always show modeline

set number       " linum
set ruler		 " shows char and line number
set showcmd      " show command info in minibuffer
set showmatch    " highlight matching parens

set colorcolumn=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab

set shiftwidth=2
set tabstop=2

set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" set font size
if has('gui_running')
  set guifont=Menlo:h13
endif

autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType vue setlocal ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""
" => Highlight
""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
nnoremap <CR> :nohlsearch<cr>


"""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""
set wildmenu
set cmdheight=1
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=1

" Make vertical splits thinner
hi VertSplit ctermbg=NONE guibg=NONE

""""""""""""""""""""""""""""
" Files, backup
"""""""""""""""""""""""""""
set noswapfile
set fileformats=unix,dos
set noeb vb t_vb=
set backspace=indent,eol,start


""""""""""""""""""""""""""""
" Moving around
""""""""""""""""""""""""""""
map j gj
map k gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

nnoremap B ^
nnoremap E $

inoremap jj <esc>

nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>h <C-W>h
nnoremap <leader>r <C-W>r


""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""
" Python Folding
set foldmethod=indent
set nofoldenable


""""""""""""""""""""""""""""
" Unorganized
""""""""""""""""""""""""""""
nnoremap <leader>d          :NERDTreeToggle<CR>
nnoremap <leader>f          :Ag<CR>
nnoremap <leader>t          :FZF<CR>

" NERDTree toggle
map <leader>nt :NERDTreeToggle<CR>

" White space
map <leader>l :ToggleWhitespace<CR>
map <leader>ll :StripWhitespace<CR>
let g:strip_whitespace_on_save = 1

" Airline fix
set laststatus=2
set ttimeoutlen=50
let g:airline_powerline_fonts=1

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

" ALE linter
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:airline#extensions#ale#enabled = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay=50
let g:python3_host_prog = '/usr/bin/python3.6'  "Setting python 3.6
" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
" let $NVIM_PYTHON_LOG_LEVEL="DEBUG"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Tmux
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]


" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

" set default comment string to be #
set commentstring=#\ %s
