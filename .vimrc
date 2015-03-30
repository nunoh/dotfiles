" vim:foldmethod=marker:foldlevel=0

" PLUGINS {{{

	set nocompatible
	filetype off

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
		Plugin 'rosenfeld/conque-term'

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

	set number			" show line numbers"
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

	set foldenable
	set foldmethod=indent
	set foldlevelstart=9

" }}}

" MISC {{{
	
	autocmd Filetype gitcommit setlocal spell textwidth=72

	set mouse=a		" enable mouse
	set modelines=1	" TODO
	set visualbell
	set autoindent
	set nowrap
	set encoding=utf8
	set noswapfile
	
	" so that spell check is actually readable
	hi clear SpellBad
	hi SpellBad cterm=underline

	" better visual indication until where the change word is happening
	set cpoptions+=$

	" change cursor shape between insert and normal mode in iTerm2.app
	if $term_program =~ "iterm"
		let &t_si = "\<esc>]50;cursorshape=1\x7" " vertical bar in insert mode
		let &t_ei = "\<esc>]50;cursorshape=0\x7" " block in normal mode
	endif

	" go back to normal mode immedeatly rather than waiting a few miliseconds after escape
	set ttimeoutlen=0

	inoremap {<CR> {<CR>}<Esc>ko

	" one space after comment
	let NERDSpaceDelims=1

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
