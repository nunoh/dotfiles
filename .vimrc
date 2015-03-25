" vim:foldmethod=marker:foldlevel=0

" PLUGINS {{{
set nocompatible	" be iMproved, required
filetype off		" required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'gmarik/Vundle.vim'
	Plugin 'itchyny/lightline.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'HTML-AutoCloseTag'
	Plugin 'mattn/emmet-vim'
	Plugin 'kien/ctrlp.vim'
	Plugin 'rstacruz/sparkup'
	Plugin 'scrooloose/nerdcommenter'
call vundle#end()

filetype plugin indent on
" }}}

" COLORS {{{
" colorscheme solarized
colorscheme monokai
set background=dark
syntax enable
" }}}

" SPACES AND TABS {{{
set tabstop=4		" number of visual spaces per tab"
set softtabstop=4	" number of spaces in tab when editing"
set shiftwidth=4		
set smarttab		" indent to correct location with tab"
" }}}

" UI {{{
set number 		" show line numbers"
set showcmd 		" show command in bottom bar"
" set cursorline		" hightlight current line"
filetype indent on 	" load filetype-specific indent files"
set wildmenu 		" visual autocomplete for command menu"
set showmatch		" hightlight matching [{()}]"
set laststatus=2	" show status line always
" }}}

" SEARCH {{{
set incsearch 		" search as characters are entered"
set hlsearch 		" highlight matches"
" }}}

" FOLDING {{{
set foldenable 		" enable folding"
set foldmethod=indent	" fold based on indent level"
set foldlevelstart=1
" }}}

" MISC {{{
autocmd Filetype gitcommit setlocal spell textwidth=72
set mouse=a
set modelines=1
set visualbell
set autoindent
set nowrap " lines of code will not wrap to the next line
set encoding=utf8
" so that spell check is actually readable
hi clear SpellBad
hi SpellBad cterm=underline
set noswapfile
set cpoptions+=$

" Chhange cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

set ttimeoutlen=0 " go back to normal mode immedeatly rather than waiting a few miliseconds after escape

"inoremap { {<CR>}<Esc>ko
inoremap {<CR> {<CR>}<Esc>ko
" }}}

" REMAPPINGS {{{

" changing default leader key from "\" to ","
:let mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nmap <D-S-c> <Plug>NERDCommenterToggle
nmap <D-s> :w

" map Ctrl-Space for autocomplete
" Ctrl-Space gets mapped to Nul on terminals with no gui
inoremap <Nul> <C-n>

" }}}
