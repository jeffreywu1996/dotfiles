"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Modern Vim Configuration
" Maintainer: Jeffrey Wu
" Platform: macOS & Linux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " Use Vim settings, rather than Vi
set encoding=utf-8           " Set default encoding
set history=1000             " Increase command history
set autoread                 " Auto reload changed files
set mouse=a                  " Enable mouse support
set shortmess+=I            " Disable splash screen
set signcolumn=yes          " Always show signcolumn
set updatetime=300          " Faster completion
set timeoutlen=500          " Faster key sequence completion
set title                   " Show file title in terminal
set modeline                " Enable modeline

" => File Management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noswapfile              " Disable swap files
set nobackup               " Disable backup files
set nowritebackup          " Disable backup files while editing
set fileformats=unix,dos   " Use Unix as standard file type

" => Vim-Plug Plugin Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" IDE Features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'           " Added for better git integration

" Editor Enhancement
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'tomtom/tcomment_vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank' " Added to highlight yanked text

" Language Support
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'         " Added for better syntax support

" UI Enhancement
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'

" Color Schemes
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'

call plug#end()

" => User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                  " Show line numbers
set ruler                  " Show cursor position
set cmdheight=1            " Height of command bar
set hidden                 " Allow hidden buffers
set showmatch              " Show matching brackets
set mat=2                  " Blink matching brackets
set colorcolumn=80         " Show column guide
set wildmenu               " Command completion
set showcmd               " Show incomplete commands
set noerrorbells          " No error sounds
set novisualbell          " No visual bell
set laststatus=2          " Always show status line

" => Theme Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " Enable 256 colors
set background=dark       " Dark background
colorscheme solarized     " Set color scheme

" Fix background color for tmux
if &term =~ '256color'
    set t_ut=
endif

" => Text, Tabs, and Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab             " Use spaces instead of tabs
set smarttab             " Smart tab behavior
set shiftwidth=2         " Width for autoindents
set tabstop=2           " Width of tab character
set softtabstop=2       " See multiple spaces as tabstops
set autoindent          " Auto indent
set smartindent         " Smart indent
set wrap               " Wrap lines
set linebreak          " Break lines at word
set textwidth=500      " Line wrap width

" => Search Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase          " Ignore case when searching
set smartcase          " Smart case search
set hlsearch           " Highlight search results
set incsearch          " Incremental search
set magic             " Regular expressions

" => Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving and quitting
nnoremap <leader>w :w!<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick .vimrc edit
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Better line navigation
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $

" Quick escape
inoremap jk <ESC>

" FZF mappings
nnoremap <leader>f :Rg<CR>
nnoremap <leader>t :Files<CR>
nnoremap <leader>g :Windows<CR>
nnoremap <leader>s :Lines<CR>
nnoremap <leader>ss :BLines<CR>
nnoremap <leader>hh :History:<CR>

" => Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" COC
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-pairs',
  \ 'coc-snippets'
  \ ]

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Whitespace
let g:strip_whitespace_on_save = 1
let g:better_whitespace_enabled = 1
map <leader>l :ToggleWhitespace<CR>
map <leader>ll :StripWhitespace<CR>

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

" Tab completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" => Auto Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc_autocmds
  autocmd!
  " Set indent for specific filetypes
  autocmd FileType python setlocal ts=4 sts=4 sw=4
  autocmd FileType javascript,typescript,vue,html,css setlocal ts=2 sts=2 sw=2

  " Strip whitespace on save
  autocmd BufWritePre * StripWhitespace

  " Return to last edit position when opening files
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Fix clipboard support for WSL
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
