" vim:foldmethod=marker:foldlevel=0

" PLUGINS {{{

    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim

    call vundle#begin()

        " Vundle better than Pathogen they say
        Plugin 'gmarik/Vundle.vim'
        
        " UI
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'Yggdroot/indentLine'
        Plugin 'bling/vim-airline'
        Plugin 'kien/rainbow_parentheses.vim'

        " IDE like stuff
        Plugin 'scrooloose/nerdtree'
        Plugin 'majutsushi/tagbar'
        Plugin 'mhinz/vim-startify'
        Plugin 'vim-scripts/TaskList.vim'
        Plugin 'kien/ctrlp.vim'
        Plugin 'terryma/vim-multiple-cursors'
        Plugin 'Shougo/unite.vim'
        Plugin 'xolox/vim-easytags'

        " web stuff
        Plugin 'mattn/emmet-vim'
        Plugin 'rstacruz/sparkup'
        Plugin 'digitaltoad/vim-jade'
        Plugin 'jaxbot/browserlink.vim'
        
        " text manipulation
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'tpope/vim-commentary'
        Plugin 'tpope/vim-surround'
        Plugin 'tpope/vim-repeat'
        Plugin 'junegunn/vim-easy-align'
        Plugin 'godlygeek/tabular'
        Plugin 'SirVer/ultisnips'
        Plugin 'honza/vim-snippets'

        " git stuff
        Plugin 'airblade/vim-gitgutter'
        Plugin 'tpope/vim-fugitive'

        " linters and completion
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'scrooloose/syntastic'

        " markdown
        Plugin 'junegunn/goyo.vim'
        Plugin 'junegunn/limelight.vim'
        Plugin 'junegunn/vim-xmark'
        " Plugin 'suan/vim-instant-markdown'
        " Plugin 'plasticboy/vim-markdown'
        Plugin  'nelstrom/vim-markdown-folding'

        " colors / themes
        Plugin 'altercation/vim-colors-solarized'
        Plugin 'guns/xterm-color-table.vim'
        Plugin 'xolox/vim-colorscheme-switcher'
        Plugin 'flazz/vim-colorschemes'

        " misc
        Plugin 'tpope/vim-sensible'
        Plugin 'editorconfig/editorconfig-vim'
        Plugin 'tmux-plugins/vim-tmux'
        Plugin 'christoomey/vim-tmux-navigator'
        Plugin 'xolox/vim-misc'
        Plugin 'junegunn/vim-emoji'
        Plugin 'moll/vim-bbye'
        Plugin 'regedarek/ZoomWin'
        Plugin 'sjl/gundo.vim'

        " so that I don't forget
        " Plugin 'tmhedberg/SimpylFold'
        " Plugin 'jeetsukumaran/vim-buffergator'
        " Plugin 'klen/python-mode'
        " Plugin 'HTML-AutoCloseTag'
        " Plugin 'jerrymarino/xcodebuild.vim'
        " Plugin 'rosenfeld/conque-term'
        " Plugin 'fholgado/minibufexpl.vim'
        " Plugin 'notpratheek/Pychimp-vim'

    call vundle#end()

    filetype plugin indent on

" }}}

" THEME {{{

    syntax enable

    let g:solarized_menu = 1

    colorscheme solarized
    " colorscheme pychimp
    " colorscheme Tomorrow-Night
    " colorscheme monokai

    if $ITERM_PROFILE == "Solarized Dark"
        set background=dark
    endif

    if $ITERM_PROFILE == "Solarized Light"
        set background=light
    endif

    " more transparent color when selecting text
    hi clear Visual
    hi Visual ctermbg=238

    " clean text when folded
    hi Folded cterm=NONE
    
    " get rid of tildes for 'blank' lines
    hi NonText guifg=bg
    hi NonText ctermfg=bg

    " only underline mispelled words
    hi clear SpellBad
    hi SpellBad cterm=underline

    " remove big vertical border
    hi VertSplit guifg=fg guibg=bg
    hi VertSplit guifg=fg ctermbg=bg

    set listchars=tab:▸\ ,eol:¬ " nicer tab symbol and show eol when visual line

" }}}

" SPACES AND TABS {{{

    set tabstop=4       " how many spaces to render a hard tab stop
    set expandtab       " expand tabs into spaces
    set softtabstop=4   " number of spaces in tab when in insert mode
    set shiftwidth=4    " how many spaces to insert or remove when pressing < or >

" }}}

" UI {{{

    set number          " show line numbers"
    set showcmd         " show command in bottom bar"
    set cursorline        " hightlight current line"
    filetype indent on  " load filetype-specific indent files"
    set wildmenu        " visual autocomplete for command menu"
    set showmatch       " hightlight matching [{()}]"
    set laststatus=2    " show status line always
    set modelines=1
    set visualbell
    set nowrap
    set scrolloff=5     " always have 5 lines below the cursor (or above) when scrolling

    " set listchars=tab:┊\ 
    

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

    set incsearch       " search as characters are entered"
    set hlsearch        " highlight matches"
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

    " set foldenable
    set foldmethod=syntax
    set foldlevelstart=10
    set foldnestmax=20
    
    function! MyFoldText()
        let nl = v:foldend - v:foldstart + 1
        let comment = substitute(getline(v:foldstart),"^ *","",1)
        " let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
        " let txt = strpart(comment, 0, strlen(comment)-2) . ' ' . nl . ' lines '
        " let txt = strpart(comment, 0, strlen(comment)-1)
        let txt = strpart(comment, 0, strlen(comment))
        return txt
    endfunction
    set foldtext=MyFoldText()

    " syn match MyEmptyLines "\(^\s*\n\)\+" fold
    " syn sync fromstart

    " remember folds after closing
    " autocmd BufWinLeave *.* mkview
    " autocmd BufWinEnter *.* silent loadview 

    set fillchars=
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

    autocmd Filetype mkd setlocal wrap 
    autocmd Filetype mkd setlocal spell spelllang=en_us
    autocmd Filetype mkd setlocal linebreak
    
    " so that quotes in json files are not hidden
    autocmd BufEnter *.json setlocal conceallevel=0

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
    " nnoremap <Leader>ev :edit $MYVIMRC<CR>
    nnoremap <Leader>ev :edit ~/.dotfiles/.vimrc<CR> " so that I can use fugitive
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
    " nmap <CR> O<esc>

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
    nnoremap gp :bp!<CR>

    " Move to the next buffer with "gn"
    nnoremap gn :bn!<CR>

    " List all possible buffers with "gl"
    nnoremap gl :ls<CR>

    map <F8>  :NextColorScheme<CR>
    map <F9>  :PrevColorScheme<CR>
    map <F10> :RandomColorScheme<CR>

    " make the jump list more like back and forward buttons in a browser
    nnoremap <C-i> <C-o>
    nnoremap <C-o> <C-i>

    " vim to a whole another level
    nmap <Leader>gs :Gstatus<CR>
    nmap <Leader>gc :Gcommit<CR>
    nmap <Leader>ga :Gwrite<CR>
    nmap <Leader>gl :Glog<CR>
    nmap <Leader>gd :Gdiff<CR>
    nmap <Leader>gp :Gpush<CR>

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

    " set tags=.tags

    " better visual indication until where the change word is happening
    set cpoptions+=$

    " go back to normal mode immedeatly rather than waiting a few miliseconds after escape
    set ttimeoutlen=0

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    function! OpenFoldOrNot()
        if foldclosed(line(".")) == -1
            normal! l
        else
            normal! lzO 
        endif
    endfunction

    nmap <silent> l :call OpenFoldOrNot()<CR>

    " syncronize vim register and system clipboard 
    set clipboard^=unnamed

    set omnifunc=emoji#complete

    " so that spell check is actually readable
    " TODO: ideally this would prompt if wanting to revert before last opening file
    " set undofile
    " set undodir=$HOME/.vimundo/

    " Show syntax highlighting groups for word under cursor
    nmap <F10> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunc

" }}}

" PLUGIN CONFIGURATIONS {{{

    let g:ycm_global_ycm_extra_conf = '~/.dotfiles/.ycm_extra_conf.py'
    let g:ycm_filetype_blacklist = {
    \ 'cpp' : 1
    \}

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
    let g:syntastic_cpp_checkers=['']
    let g:syntastic_javascript_checkers = ['jshint']
    let g:syntastic_css_csslint_args="--ignore=ids"

    let g:goyo_width=80
    let g:goyo_margin_top=0
    let g:goyo_margin_bottom=0

    let g:gitgutter_realtime=1

    let g:pymode_lint_ignore="E701,E501,E203,E201,E202,E221,C901"

    map <Leader>f :Unite file<CR>
    map <Leader>b :Unite buffers<CR>

    let g:pymode = 1
    let g:pymode_folding = 1

    let g:easytags_suppress_report = 1 " surpress how long it took to generate the tags everytime you save a file

    let g:airline_powerline_fonts = 1
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline#extensions#tabline#left_sep = ''
    " let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#hunks#enabled = 0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#tagbar#enabled = 0
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_inactive_collapse=1
    let g:airline_section_y = ''
    let g:airline_section_z = '%l:%c'
    " Just show the filename (no path) in the tab
    let g:airline#extensions#tabline#fnamemod = ':t'
    " otherwise it's realtime and it lags

    " let g:instant_markdown_slow = 1

    let g:UltiSnipsExpandTrigger="<c-b>"
    " let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " let g:vim_markdown_folding_disabled=1

    " let g:UltiSnipsExpandTrigger               <tab>
    " let g:UltiSnipsListSnippets                <c-tab>
    " let g:UltiSnipsJumpForwardTrigger          <c-j>
    " let g:UltiSnipsJumpBackwardTrigger         <c-k>

    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

" }}}
