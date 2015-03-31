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
		Plugin 'flazz/vim-colorschemes'
		Plugin 'tpope/vim-fugitive'

	call vundle#end()

	filetype plugin indent on

" }}}

" THEMES {{{

	if !has('gui_running')
		set t_Co=256
	endif

	syntax enable

	" let g:solarized_termcolors=256
	" set background=dark
	" set background=light
	" colorscheme solarized
     
	colorscheme monokai
	
" }}}

" SPACES AND TABS {{{

	set tabstop=4		" number of visual spaces per tab"
	set softtabstop=4	" number of spaces in tab when editing"
	set shiftwidth=4
	set smarttab		" indent to correct location with tab"
	set noshowmode

" }}}

" UI {{{

	set number			" show line numbers"
	set showcmd 		" show command in bottom bar"
	set cursorline		" hightlight current line"
	filetype indent on 	" load filetype-specific indent files"
	set wildmenu 		" visual autocomplete for command menu"
	set showmatch		" hightlight matching [{()}]"
	set laststatus=2	" show status line always
	set modelines=1
	set visualbell
	set nowrap

	" change cursor SHAPE BETWEEN INSERT AND NORMAL MODE IN ITERM2.APP
	if $TERM_PROGRAM =~ "iTerm"
		let &t_SI = "\<Esc>]50;CursorShape=1\x7" " vertical bar in insert mode
		let &t_EI = "\<Esc>]50;CursorShape=0\x7" " block in normal mode
	endif

" }}}

" SEARCH {{{

	set incsearch 		" search as characters are entered"
	set hlsearch 		" highlight matches"

" }}}

" FOLDING {{{

	set foldenable
	set foldmethod=indent
	set foldlevelstart=20

" }}}

" STATUS LINE {{{

   let g:lightline = {
	  \ 'colorscheme': 'jellybeans',
	  \ 'mode_map': { 'c': 'NORMAL' },
	  \ 'active': {
	  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
	  \ },
	  \ 'component_function': {
	  \   'modified': 'MyModified',
	  \   'readonly': 'MyReadonly',
	  \   'fugitive': 'MyFugitive',
	  \   'filename': 'MyFilename',
	  \   'fileformat': 'MyFileformat',
	  \   'filetype': 'MyFiletype',
	  \   'fileencoding': 'MyFileencoding',
	  \   'mode': 'MyMode',
	  \ },
		 \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
	  \ }

		function! MyModified()
	  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction

	function! MyReadonly()
	  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '\ue0a2' : ''
	endfunction

	function! MyFilename()
	  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
			\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
			\  &ft == 'unite' ? unite#get_status_string() :
			\  &ft == 'vimshell' ? vimshell#get_status_string() :
			\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
			\ ('' != MyModified() ? ' ' . MyModified() : '')
	endfunction

	function! MyFugitive()
	  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? "\ue0a0 "._ : ''
	  endif
	  return ''
	endfunction

	function! MyFileformat()
	  return winwidth(0) > 70 ? &fileformat : ''
	endfunction

	function! MyFiletype()
	  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
	endfunction

	function! MyFileencoding()
	  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
	endfunction

	function! MyMode()
	  return winwidth(0) > 60 ? lightline#mode() : ''
	endfunction

 " }}}

 " MISC {{{

	set virtualedit=all
	set encoding=utf8
	set noswapfile
	set autoindent
	set mouse=a
	
	" configure vim to write better commit messages
	autocmd Filetype gitcommit setlocal spell textwidth=72

	" so that spell check is actually readable
	hi clear SpellBad
	hi SpellBad cterm=underline

	" better visual indication until where the change word is happening
	set cpoptions+=$

	" go back to normal mode immedeatly rather than waiting a few miliseconds after escape
	set ttimeoutlen=0

	" auto complete brace in functions
	inoremap {<CR> {<CR>}<Esc>ko

	" one space after comment
	let NERDSpaceDelims=1

" }}}

" REMAPPINGS {{{

	" let mapleader = ","
	let mapleader = " "

	" avoid extra left shift press that is ruining my left hand
	nmap ç :

	nnoremap <Leader>w :w<CR>
	nnoremap <Leader>q :q<CR>
	nnoremap <Leader>o :CtrlP<CR>
	nmap <Leader><Leader> V

	noremap <silent> <leader>h <C-W>h
	noremap <silent> <leader>j <C-W>j
	noremap <silent> <leader>k <C-W>k
	noremap <silent> <leader>l <C-W>l

	" quickly edit/reload the vimrc file
	nnoremap <leader>ev :vsplit $MYVIMRC<CR>
	nnoremap <leader>sv :source $MYVIMRC<CR>

	" map Ctrl-Space for autocomplete
	" Ctrl-Space gets mapped to Nul on terminals with no gui
	inoremap <Nul> <C-n>

" }}}
