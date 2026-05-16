" Basics
set nocompatible encoding=utf-8
set noswapfile autoread
set backspace=indent,eol,start
syntax enable
filetype plugin indent on

" UI
set number ruler laststatus=2 cursorline
set scrolloff=5 nowrap showmatch
set shortmess+=I     " skip intro screen
let &t_SI = "\e[6 q" " bar in insert mode
let &t_EI = "\e[2 q" " block in normal mode

" Search
set incsearch hlsearch ignorecase smartcase

" Indentation
set autoindent expandtab tabstop=4 shiftwidth=4
