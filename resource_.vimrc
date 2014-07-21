set showmatch
set number

set visualbell
set hlsearch

set ai
set smartindent
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set backspace=2
set cursorline

set ruler
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [COL=%c]
set laststatus=2
set tags=$PROJ_PATH/tags,./tags

map <F2> :set syntax=c<CR>
noremap <F3> :set softtabstop=2<CR>:set tabstop=2<CR>:set shiftwidth=2<CR>
noremap <F4> :set softtabstop=4<CR>:set tabstop=4<CR>:set shiftwidth=4<CR>

function! s:DiffWithGITCheckedOut()
    let filetype=&ft
    diffthis
    vnew | exe "%!git diff " . expand("#:p:h") . "| patch -p 1 -Rs -o /dev/stdout"
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    endfunction
com! DiffSaved call s:DiffWithSaved()
