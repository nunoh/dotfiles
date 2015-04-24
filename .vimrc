" vim:foldmethod=marker:foldlevel=0

" PLUGINS {{{

	set nocompatible
	filetype off

	set rtp+=~/.vim/bundle/Vundle.vim

	call vundle#begin()

		" Vundle better than Pathogen they say
		Plugin 'gmarik/Vundle.vim'
		
		" UI
		Plugin 'itchyny/lightline.vim'
		Plugin 'scrooloose/nerdtree'
		Plugin 'majutsushi/tagbar'
		Plugin 'kien/ctrlp.vim'
		Plugin 'vim-scripts/TaskList.vim'
		Plugin 'nathanaelkane/vim-indent-guides'
		Plugin 'altercation/vim-colors-solarized'
		Plugin 'junegunn/goyo.vim'
		Plugin 'junegunn/limelight.vim'
		Plugin 'junegunn/vim-emoji'
		Plugin 'mhinz/vim-startify'

		" web stuff
		Plugin 'mattn/emmet-vim'
		Plugin 'rstacruz/sparkup'
		Plugin 'digitaltoad/vim-jade'
		
		" text manipulations
		Plugin 'scrooloose/nerdcommenter'
		Plugin 'tpope/vim-surround'
		Plugin 'tpope/vim-repeat'

		" git stuff
		Plugin 'airblade/vim-gitgutter'
		Plugin 'tpope/vim-fugitive'

		" linters and completion
		Plugin 'Valloric/YouCompleteMe'
		Plugin 'scrooloose/syntastic'
		
		" misc
		Plugin 'tpope/vim-sensible'
		Plugin 'editorconfig/editorconfig-vim'
		Plugin 'tmux-plugins/vim-tmux'
		Plugin 'christoomey/vim-tmux-navigator'
		Plugin 'terryma/vim-multiple-cursors'
		Plugin 'plasticboy/vim-markdown'
		Plugin 'junegunn/vim-xmark'

		" so that I don't forget
		" Plugin 'HTML-AutoCloseTag'
		" Plugin 'jerrymarino/xcodebuild.vim'
		" Plugin 'rosenfeld/conque-term'
		" Plugin 'suan/vim-instant-markdown'

	call vundle#end()

	filetype plugin indent on

" }}}

" THEME {{{

	if !has('gui_running')
		set t_Co=256
	endif

	syntax enable

	" let g:solarized_termcolors=16
	" set background=dark
	" set background=light
	" colorscheme solarized
     
	" colorscheme molokai
	colorscheme monokai

	" let g:molokai_original = 1
	" let g:rehash256 = 1
	
" }}}

" SPACES AND TABS {{{

	set tabstop=4		" number of visual spaces per tab"
	set softtabstop=4	" number of spaces in tab when editing"
	set shiftwidth=4
	set smarttab		" indent to correct location with tab"
	set noshowmode

" }}}

"   UI {{{

	set number			" show line numbers"
	set showcmd 		" show command in bottom bar"
	" set cursorline		" hightlight current line"
	filetype indent on 	" load filetype-specific indent files"
	set wildmenu 		" visual autocomplete for command menu"
	set showmatch		" hightlight matching [{()}]"
	set laststatus=2	" show status line always
	set modelines=1
	set visualbell
	set nowrap
	set scrolloff=5		" always have 5 lines below the cursor (or above) when scrolling
	
	" remove big vertifcal border
	" hi VertSplit guifg=fg guibg=bg
	" hi VertSplit guifg=fg ctermbg=bg

	" get rid of tildes for 'blank' lines
	hi NonText guifg=bg
	hi NonText ctermfg=bg

	" change cursor shape between insert and normal mode in iterm2.app
	if $TERM_PROGRAM =~ "iTerm"
		let &t_SI = "\<Esc>]50;CursorShape=1\x7" " vertical bar in insert mode
		let &t_EI = "\<Esc>]50;CursorShape=0\x7" " block in normal mode
	endif

	if exists('$TMUX')
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	endif

	" upon hitting escape to change modes,
	" send successive move-left and move-right
	" commands to immediately redraw the cursor
	inoremap <special> <Esc> <Esc>hl

	" don't blink the cursor
	set guicursor+=i:blinkwait0

" }}}

" SEARCH {{{

	set incsearch 		" search as characters are entered"
	set hlsearch 		" highlight matches"
	set ignorecase
	set smartcase

	" make search results appear in the middle of the screen
	nnoremap n nzz
	nnoremap N Nzz
	nnoremap * *zz
	nnoremap # #zz
	nnoremap g* g*zz
	nnoremap g# g#zz 

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

" AUTOCOMMANDS {{{

	" disable automatic comment insertion
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" autocmd BufEnter *.cpp set makeprg=xcodebuild
	" autocmd BufEnter *.h set makeprg=xcodebuild

	autocmd BufEnter *.md :Goyo
	
	" autocmd QuickfixCmdPost make call AfterMakeC()
	" function! AfterMakeC()
	" " No any error after make
	" if len(getqflist()) == 0
		" !open bin/gamultOSX.app
	" endif
	" " :~)
	" endfunction

	" remove these mappings so that can use <Leader>h for switching windows
	autocmd VimEnter * nunmap <Leader>hp
	autocmd VimEnter * nunmap <Leader>hr
	autocmd VimEnter * nunmap <Leader>hs

	" get rid of all the nerdcommenter mappings
	autocmd VimEnter * unmap <Leader>ca
	autocmd VimEnter * unmap <Leader>cA
	autocmd VimEnter * unmap <Leader>c$
	autocmd VimEnter * unmap <Leader>cu
	autocmd VimEnter * unmap <Leader>cb
	autocmd VimEnter * unmap <Leader>cl
	autocmd VimEnter * unmap <Leader>cy
	autocmd VimEnter * unmap <Leader>cs
	autocmd VimEnter * unmap <Leader>ci
	autocmd VimEnter * unmap <Leader>cn
	autocmd VimEnter * unmap <Leader>cm
	autocmd VimEnter * unmap <Leader>cc
	" autocmd VimEnter * unmap <Leader>c<Leader>

	" autocmd VimEnter * NERDTree
	" autocmd VimEnter * TagbarOpen

" }}}

" MAPPINGS {{{

	let mapleader = " "

	" makes Y work like D
	map Y y$

	" avoid extra left shift press that is ruining my left hand
	nmap ç :

	" write and quit has to be really fast
	nnoremap <leader>w :w<cr>
	nnoremap <leader>q :q<cr>
	nnoremap <silent> <leader>d :bd<cr>
    
	" enter visual line easily
	nmap <Leader><Leader> V

	" so that toggling is really easy and fast
	nmap <Leader>c <Plug>NERDCommenterToggle<Esc>
	vmap <Leader>c <Plug>NERDCommenterToggle gv<Esc>

	" auto complete brace in functions
	inoremap {<CR> {<CR>}<Esc>ko

	noremap <silent> j gj
	noremap <silent> k gk

	" fast window switching
	noremap <silent> <leader>h <C-W>h
	noremap <silent> <leader>j <C-W>j
	noremap <silent> <leader>k <C-W>k
	noremap <silent> <leader>l <C-W>l

	" no arrow keys
	inoremap  <up>    <nop>
	inoremap  <down>  <nop>
	inoremap  <left>  <nop>
	inoremap  <right> <nop>
	noremap   <up>    <nop>
	noremap   <down>  <nop>
	noremap   <left>  <nop>
	noremap   <right> <nop>
	
	vmap y ygv<Esc>

	" for window fullscreen
	noremap <silent> <Leader>f <C-W>o " for fullscreen

	" show NERDTree and CtrlP
	nmap <leader>nt :NERDTreeToggle<CR>
	nmap <leader>tb :TagbarToggle<CR>
	nnoremap <Leader>o :CtrlP<CR>

	" quickly edit common configuration files
	nnoremap <leader>ev :edit $MYVIMRC<CR>
	nnoremap <leader>et :edit ~/.tmux.conf<CR>
	nnoremap <leader>ez :edit ~/.zshrc<CR>
	nnoremap <leader>ea :edit ~/.dotfiles/.aliases<CR>
	nnoremap <leader>ec :edit ~/.dotfiles/cheatsheets/vim.md<CR>

	" quickly source common configuration files
	nnoremap <leader>sv :source $MYVIMRC<CR>
	nnoremap <silent> <leader>st :!tmux source-file ~/.tmux.conf<CR>

	" alternate with source and header files
	map <leader>a :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

	" map Ctrl-Space for autocomplete
	" Ctrl-Space gets mapped to Nul on terminals with no gui
	inoremap <Nul> <C-n>

	" tab mappings
	nmap <leader>tn :tabnew<CR>
	nmap <leader>tc :tabclose<CR>
	nmap <leader>tl :tabnext<CR>
	nmap <leader>th :tabprevious<CR>

	" make
	" nmap <Leader>m :!clear && make<CR>
	nmap <Leader>m :make<CR>

	map <leader>tl :TaskList<cr>

	" for entering empty lines without leaving normal mode
	nmap <CR> O<esc>
	" nmap <S-CR> o<esc> " not possible to map shift-enter in terminal vim
	" nmap <C-CR> o<esc> " this didn't seem to work as well 

	map <silent> <leader>g :Goyo<cr>

	nnoremap <leader>+ 10<C-W>>
	nnoremap <leader>- 10<C-W><

" }}}

 " MISC {{{

	set wrap
	set updatetime=750
	set virtualedit=all
	set encoding=utf8
	set noswapfile
	set autoindent
	set mouse=a
	set splitright
	set splitbelow

	set wildignore+=*/env/**
	set wildignore+=*/tmp/**
	
	set wildignore+=*.npy
	
	" better visual indication until where the change word is happening
	set cpoptions+=$

	" go back to normal mode immedeatly rather than waiting a few miliseconds after escape
	set ttimeoutlen=0

	" so that spell check is actually readable
	hi clear SpellBad
	hi SpellBad cterm=underline

	let g:ycm_global_ycm_extra_conf = '~/.dotfiles/.ycm_extra_conf.py'
	
	let g:gitgutter_realtime=1

	" so that ctrp files open in same window and not in a new split
	let g:ctrlp_reuse_window = 'netrw'

	" sane ignore for ctrlp
	let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|build\|tmp\|env\|bin\|node_modules\|bower_components\|gamultOSX.xcodeproj\|bin\',
	\ 'file': '\.exe$\|\.so$\|\.ttf$\|\.pdf$\|\.pyc$\|\.dat$'
	\ }

	" one space after comment
	let NERDSpaceDelims=1

	" proper C comments by default
	let g:NERDCustomDelimiters = {
        \ 'c': { 'left': '//' }
    \ }

	let NERDTreeIgnore = ['\.pyc$']
	let g:tlTokenList = ["TODO", "NOTE", "FIXME"]

	" TODO: ideally this would prompt if wanting to revert before last opening file
	" set undofile
	" set undodir=$HOME/.vimundo/

	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0

	" silent! if emoji#available()
		" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
		" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
		" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
		" let g:gitgutter_sign_modified_removed = emoji#for('collision')
	" endif

	set omnifunc=emoji#complete

	let g:goyo_width=140
	let g:goyo_margin_top=1
	let g:goyo_margin_bottom=1

" }}}
