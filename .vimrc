" vim:foldmethod=marker:foldlevel=0

" COLORS {{{ 
colorscheme solarized
set background=dark
syntax enable 
" }}}

" SPACES AND TABS {{{ 
set tabstop=4		" number of visual spaces per tab"
set softtabstop=4	" number of spaces in tab when editing"
" }}}

" UI {{{ 
set number 		" show line numbers"
set showcmd 		" show command in bottom bar"
set cursorline		" hightlight current line"
filetype indent on 	" load filetype-specific indent files"
set wildmenu 		" visual autocomplete for command menu"	
set showmatch		" hightlight matching [{()}]"
" }}}

" SEARCH {{{ 
set incsearch 		" search as characters are entered"
set hlsearch 		" highlight matches"
" }}}

" FOLDING {{{ 
set foldenable 		" enable folding"
set foldmethod=indent	" fold based on indent level"
" }}}

autocmd Filetype gitcommit setlocal spell textwidth=72
set mouse=a

" PLUGINS "
set runtimepath^=~/.vim/bundle/ctrlp.vim
