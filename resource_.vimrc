"Written by Benjamin Mayes

"set term=linux
set number
set backspace=2
set nocompatible
set smartindent
set hlsearch

set noerrorbells
set ruler
set ignorecase

"w automatic formatting is to be done
set formatoptions=tcrqn
" take indent for new line from previous line
set autoindent
" smart autoindenting for C programs
set smartindent
" do c-style indenting
set cindent
" tab spacing (settings below are just to unify it)
set tabstop=4
" unify
set softtabstop=4
" unify
set shiftwidth=4
" fake tabs please!
set expandtab

"set columns=80
set matchtime=5
set report=0

set visualbell

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [COL=%c]
set laststatus=2
syntax on

"REMAPS
"F1 quick exit
map <F1> :q<cr>
map! <F1> <esc>:q<cr>

"F2 quick save
map  <F2> :w<cr>
map! <F2> <esc>:w<cr>i<right>

"F3 quick save and exit
map <F3> :wq<cr>
map! <F3> <esc>:wq<cr>

"CTRL+C undo
map <C-C> :undo<cr>
map! <C-C> <esc>:undo<cr>i

map <BS> :d<cr>

"F12 remove dos  characters
map <F12> :1,$s///g<cr>
map! <F12> <esc>:1,$s///g<cr>
