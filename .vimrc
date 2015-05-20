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
		" Plugin 'mhinz/vim-startify'
		Plugin 'moll/vim-bbye'
		Plugin 'tmhedberg/SimpylFold'
		Plugin 'jeetsukumaran/vim-buffergator'
		" Plugin 'fholgado/minibufexpl.vim'

		" web stuff
		Plugin 'mattn/emmet-vim'
		Plugin 'rstacruz/sparkup'
		Plugin 'digitaltoad/vim-jade'
		
		" text manipulations
		Plugin 'scrooloose/nerdcommenter'
		Plugin 'tpope/vim-surround'
		Plugin 'tpope/vim-repeat'
		Plugin 'junegunn/vim-easy-align'
		Plugin 'godlygeek/tabular'

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
		Plugin 'klen/python-mode'
		Plugin 'Shougo/unite.vim'

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

	let g:solarized_termcolors=16
	set background=dark
	" set background=light
	colorscheme solarized
     
	" colorscheme monokai

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

	set listchars=tab:┊\ 
	
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
	set foldnestmax=1

    " remember folds after closing
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent loadview 

" }}}

" STATUS LINE {{{

   let g:lightline = {
	  \ 'colorscheme': 'solarized',
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

	" autocmd BufEnter *.md :Goyo

	" nice higlighting for some custom dotfiles that don't get detected
	autocmd BufEnter .aliases set syntax=sh
	autocmd BufEnter .astylerc set syntax=sh
	autocmd BufEnter .exports set syntax=sh
	autocmd BufEnter .functions set syntax=sh
	autocmd BufEnter .path set syntax=sh
	autocmd BufEnter .shortcuts set syntax=sh

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
	nnoremap <Leader>w :w<CR>
	nnoremap <Leader>q :q<CR>
	" nnoremap <silent> <Leader>d :bd<CR>
	nnoremap <silent> <Leader>d :Bdelete<CR>
    
	" enter visual line easily
	nmap <Leader><Leader> V

	" so that toggling is really easy and fast
	nmap <Leader>c <Plug>NERDCommenterToggle<Esc>
	vmap <Leader>c <Plug>NERDCommenterToggle gv<Esc>

	" auto complete brace in functions
	inoremap {<CR> {<CR>}<Esc>ko

	noremap <silent> j gj
	noremap <silent> k gk

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
	" noremap <silent> <Leader>f <C-W>o " for fullscreen

	" show NERDTree and CtrlP
	nmap <Leader>nt :NERDTreeToggle<CR>
	nmap <Leader>tb :TagbarToggle<CR>
	nnoremap <Leader>o :CtrlP<CR>

	" quickly edit common configuration files
	nnoremap <Leader>ev :edit $MYVIMRC<CR>
	nnoremap <Leader>et :edit ~/.tmux.conf<CR>
	nnoremap <Leader>ez :edit ~/.zshrc<CR>
	nnoremap <Leader>ea :edit ~/.dotfiles/.aliases<CR>
	nnoremap <Leader>ec :edit ~/.dotfiles/cheatsheets/vim.md<CR>

	" quickly source common configuration files
	nnoremap <Leader>sv :source $MYVIMRC<CR>
	nnoremap <silent> <Leader>st :!tmux source-file ~/.tmux.conf<CR>

	" alternate with source and header files
	map <Leader>a :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

	" map Ctrl-Space for autocomplete
	" Ctrl-Space gets mapped to Nul on terminals with no gui
	inoremap <Nul> <C-n>

	" tab mappings
	nmap <Leader>tn :tabnew<CR>
	nmap <Leader>tc :tabclose<CR>
	nmap <Leader>tl :tabnext<CR>
	nmap <Leader>th :tabprevious<CR>

	" make
	" nmap <Leader>m :!clear && make<CR>
	nmap <Leader>m :make<CR>

	map <Leader>tl :TaskList<CR>

	" for entering empty lines without leaving normal mode
	nmap <CR> O<esc>
	" nmap <S-CR> o<esc> " not possible to map shift-enter in terminal vim
	" nmap <C-CR> o<esc> " this didn't seem to work as well 

	map <silent> <Leader>gy :Goyo<CR>

	nnoremap <Leader>+ 10<C-W>>
	nnoremap <Leader>- 10<C-W><

	" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
	vmap <Enter> <Plug>(EasyAlign)

	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)

	" nnoremap <C-l> :tabnext<CR>
	" nnoremap <C-h> :tabprevious<CR>
	" nnoremap <C-t> :tabnew<CR>

	" Move to the previous buffer with "gp"
	nnoremap gp :bp<CR>

	" Move to the next buffer with "gn"
	nnoremap gn :bn<CR>

	" List all possible buffers with "gl"
	nnoremap gl :ls<CR>

" }}}

 " MISC {{{

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

	set tags=.tags
	
	" better visual indication until where the change word is happening
	set cpoptions+=$

	" go back to normal mode immedeatly rather than waiting a few miliseconds after escape
	set ttimeoutlen=0

	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	" syncronize vim register and system clipboard 
	set clipboard^=unnamed

	set omnifunc=emoji#complete

	" so that spell check is actually readable
	hi clear SpellBad
	hi SpellBad cterm=underline

	" TODO: ideally this would prompt if wanting to revert before last opening file
	" set undofile
	" set undodir=$HOME/.vimundo/

" }}}

" PLUGIN CONFIGURATIONS {{{

	let g:ycm_global_ycm_extra_conf = '~/.dotfiles/.ycm_extra_conf.py'
	
	" sane ignore for ctrlp
	let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|build\|tmp\|env\|bin\|node_modules\|bower_components\|gamultOSX.xcodeproj\|bin\',
	\ 'file': '\.exe$\|\.so$\|\.ttf$\|\.pdf$\|\.pyc$\|\.dat$'
	\ }
	let g:ctrlp_reuse_window = 'netrw' " so that ctrp files open in same window and not in a new split

	
	" proper C comments by default
	let g:NERDCustomDelimiters = {
        \ 'c': { 'left': '//' },
        \ 'less': { 'left': '//' }
    \ }
	let g:NERDSpaceDelims=1 " one space after comment

	let g:NERDTreeIgnore = ['\.pyc$']
	let g:NERDTreeMinimalUI=1

	let g:tlTokenList = ["TODO", "NOTE", "FIXME"]

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
	let g:syntastic_html_checkers=['']

	let g:goyo_width=140
	let g:goyo_margin_top=0
	let g:goyo_margin_bottom=0

	let g:gitgutter_realtime=1
	" silent! if emoji#available()
		" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
		" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
		" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
		" let g:gitgutter_sign_modified_removed = emoji#for('collision')
	" endif

	let g:SimpylFold_docstring_preview = 1
	let g:SimpylFold_fold_docstring = 0

	let g:pymode_lint_ignore="E701,E501,E203,E201,E202,C901"

	map <Leader>f :Unite file<CR>
	map <Leader>b :Unite buffers<CR>

" }}}
