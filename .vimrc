" ~/.vimrc
"
" created by:       Harold Bradley III
" email:            hbradleyiii@bradleystudio.net
"

set nocompatible

    " - KEY MAPPINGS {{{
" Leader key
let mapleader=","  " By default ',' just repeats latest f, t, F or T in opposite direction
" Map ,, to do what ',' used to do
nnoremap <Leader>, ,
vnoremap <Leader>, ,

" Windows-like mods
" * is the X11 primary selection (when text is highlighted)
" + is the X11 clipboard
noremap <Leader>c :%y"*<CR>
noremap <C-c> "*
vnoremap <C-c> "*y
noremap <Leader>x "*
noremap <C-x> "*
vnoremap <C-x> "*d
noremap <Leader>v "*p
noremap <C-a> ggVG
noremap <Leader>a ggVG
noremap <F1> :tab help <CR>

" Movement Mods
nnoremap gg ggzz
" jj Escape in insert mode
inoremap jj <ESC>
inoremap hh <ESC>^i
inoremap kk <ESC>$a
noremap <Enter> o<ESC>
" Natural up and down movements
nnoremap j gj
nnoremap k gk

" Keep visual selection when indenting text
vmap > >gv
vmap < <gv

" Playback in register 'q' (record: qq)
nnoremap Q @q

" Make tg the opposite of gt
noremap tg :tabprevious <CR>

" Highlight last inserted text
nnoremap gV `[v`]

" Clone a paragraph
noremap cp yap<S-}>p

" Align current paragraph
noremap <Leader>a =ip

" Forces creation of a file if it doesn't exist
noremap gf :e <cfile><CR>

" Moving in the buffer
noremap <silent> <Leader>f :e ./<CR>
noremap <silent> <Leader>b :bp<CR>
noremap <silent> <Leader>n :bn<CR>
noremap <silent> <Leader>m :b#<CR>

" Ctrl mappings to change windows
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" 'e'dit 'v'imrc
noremap <silent> <Leader>sv :so $MYVIMRC<CR>
noremap <silent> <Leader>ev :tabedit $HOME/.vimrc<CR>
noremap <silent> <Leader>ee :tabedit $HOME/.emacs<CR>
" 'e'dit 'b'ashrc
noremap <silent> <Leader>sb :!rebash<CR>
noremap <silent> <Leader>eb :tabedit $HOME/.bashrc<CR>

" save session
noremap <Leader>s :mksession<CR>

" Insert timestamp
nnoremap <F3> a<C-r>=strftime("%b %d, %Y %H:%M")<CR><ESC>
inoremap <F3> <C-r>=strftime("%b %d, %Y %H:%M %p")<CR>

" Editing Keymappings
" Remove trailing spaces
noremap <silent> ,ss :%s/\s\+$//<Enter>
noremap  ,rr :1,$retab<CR>

" Option Toggles
noremap <Leader>l :set list!<CR>
noremap <Leader>w :set wrap!<CR>
noremap <SPACE> :set hlsearch!<CR>:set cursorline!<CR>:set cursorcolumn!<CR>
noremap <Leader><SPACE> :set paste!<CR>
nnoremap <F6> :set paste!<CR>
inoremap <F6> <ESC>:set paste!<CR>a
noremap <Leader>. :set relativenumber!<CR>
"nnoremap <C-SPACE> Use for next option toggle

" Spellcheck
noremap <F8> :set invspell<CR>

" Execute in vim the line under the cursor
noremap <Leader>ex yy:@"<CR>
" In windows, run command under cursor
noremap <Leader>ew :!start cmd /c <cfile><CR>

" Greek/Hebrew mappings
map <C-g> :call ToggleGreekKeyboard()<CR>
imap <C-g> <ESC>:call ToggleGreekKeyboard()<CR>a
map <C-y> :call ToggleHebrewKeyboard()<CR>
imap <C-y> <ESC>:call ToggleHebrewKeyboard()<CR>a

let g:greek_keyboard = 0
function! ToggleGreekKeyboard()
    if g:greek_keyboard
        set keymap=accents
        let g:greek_keyboard = 0
        let g:hebrew_keyboard = 0
    else
        set keymap=greekp
        let g:greek_keyboard = 1
        let g:hebrew_keyboard = 0
    endif
endfunction

let g:hebrew_keyboard = 0
function! ToggleHebrewKeyboard()
    if g:hebrew_keyboard
        set keymap=accents
        let g:hebrew_keyboard = 0
        let g:greek_keyboard = 0
    else
        set keymap=hebrew
        let g:hebrew_keyboard = 1
        let g:greek_keyboard = 0
    endif
endfunction

" }}}

    " - PLUGINS {{{

filetype off  " Required

" Set the runtime path to include Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim

    " -- Plugin List {{{
" Install Vundle if it isn't already installed {{{
let g:InstallVundlePlugins = 0
if empty(glob("$HOME/.vim/bundle/Vundle.vim"))
    execute "!git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim"
    let g:InstallVundlePlugins = 1
endif  " }}}

call vundle#begin()  " Vundle Initialization
Plugin 'gmarik/Vundle.vim'  " Let Vundle manage Vundle, required

Plugin 'alfredodeza/pytest.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-php-manual'
Plugin 'ap/vim-css-color'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ervandew/supertab'
Plugin 'jceb/vim-orgmode'
Plugin 'joonty/vdebug.git'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'klen/python-mode'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tommcdo/vim-exchange'
Plugin 'vim-scripts/timestamp.vim'
call vundle#end()  " Must be AFTER plugin list

" If this is a fresh install, install all initialized plugins {{{
if g:InstallVundlePlugins == 1
    execute 'VundleInstall'
endif  " }}}
" }}}

    " -- Plugin Options/Keybindings {{{

"" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 'rwc'
noremap <Leader>p :CtrlP<CR>

" Ignore spaces when searching
let g:ctrlp_abbrev = {
    \ 'abbrevs' : [
        \ {
            \ 'pattern' : ' ',
            \ 'expanded' : '',
            \ 'mode' : 'fprz',
        \ },
    \ ]
\ }


"" Fugitive
noremap <silent> <Leader>ga :Git add %<CR>
noremap <silent> <Leader>gc :Gcommit<CR>
noremap <silent> <Leader>gl :Git log<CR>
noremap <silent> <Leader>gs :Gstatus<CR>
noremap <silent> <Leader>gp :Gpull<CR>:Gpush<CR>

" Gundo
noremap <Leader>u :GundoToggle<CR>

"" NerdTree
noremap <Leader>nt :NERDTreeToggle <CR>
noremap <F2> :NERDTreeToggle <CR>

"" Syntastic
let g:syntastic_csslint_args="--ignore=universal-selector"
"let g:syntastic_css_checkers=["recess"]
let g:syntastic_css_checkers=["csslint"]
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_always_populate_loc_list = 1

noremap ge :lnext<CR>
noremap gb :lprev<CR>
noremap gl :ll<CR>


"" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
noremap <Leader>es :UltiSnipsEdit<CR>
inoremap <Leader>es <ESC>:UltiSnipsEdit<CR>

"" Vdebug
cnoremap eval :VdebugEval<CR>
cnoremap vd VdebugStart<CR>

"" Vundle
noremap <silent> <Leader>pi :PluginClean<CR>:q<CR>:PluginInstall<CR>:q<CR>

" }}}
" }}}

    " - VIM OPTIONS {{{
    " -- General Options {{{
set title
set showcmd
set history=1000
set showmode
set wildmenu
set ofu=syntaxcomplete#Complete
set lazyredraw
set scrolloff=2
set virtualedit=all
set fillchars=""  " separator chars
set mousehide
set wildignore+=*~,*.bak,*.pyc,*.swp,*.tmp,.git
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.so,*.zip
set wildignore+=.sass-cache

set splitbelow
set splitright

set shellslash
set visualbell t_vb=

" Session options
set sessionoptions=buffers,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Fold options
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Status Line
set stl=%h%w%m\ %f\ %r\ (b:%n)\ %=%30(Line:\ %l/%L\ [%p%%]\ %)%8(Col:%3c\ %)%13([%b][0x%B]%)
set laststatus=2
set number
set ruler
" }}}

    " -- File Settings {{{
if !isdirectory($HOME . "/.vim/.backup")
    call mkdir($HOME . "/.vim/.backup", "p")
endif
if !isdirectory($HOME . "/.vim/.swap")
    call mkdir($HOME . "/.vim/.swap", "p")
endif
if !isdirectory($HOME . "/.vim/.undo")
    call mkdir($HOME . "/.vim/.undo", "p")
endif
if !isdirectory($HOME . "/.vim/.viewdir")
    call mkdir($HOME . "/.vim/.viewdir", "p")
endif

set backup
set writebackup
set swapfile
set undofile
set undolevels=1000
set undoreload=10000
set backupdir=$HOME/.vim/.backup/
set directory=$HOME/.vim/.swap/
set undodir=$HOME/.vim/.undo/
set viewdir=$HOME/.vim/.viewdir/

set encoding=utf8
set ffs=unix,dos,mac
set hidden
set autochdir
set cryptmethod=blowfish
" }}}

    " -- Tabs/Indent Settings {{{
set autoindent
"set smartindent  " TODO: I'm not sure about this one...
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set backspace=2
set showbreak=»»
" TODO: fix for terminals:
set listchars=tab:>-,eol:¬,trail:•,extends:»,precedes:«,nbsp:·
" }}}

    " -- Searching {{{
set wrapscan
set ignorecase
set smartcase
set nohlsearch
set nocursorline
set nocursorcolumn
set incsearch
" }}}

    " -- Syntax Highlighting {{{
" colorscheme must be AFTER this!
filetype plugin indent on
syntax on

if has('gui_running')  " Set up the gui for GVim
    " Set the cursor for various modes
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set guifont=Pragmata\ 14
    set guioptions=acer
    set ttyfast
    set nolazyredraw  " Does this have consequences?
endif

if &t_Co >= 256 || has("gui_running")  " For 256color Terminals or GVim
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
    " Invisible character colors
    highlight NonText guifg=#151515
    highlight SpecialKey guifg=#151515
    " Highlight lines over 80 chars
    highlight OverLength ctermbg=234 ctermfg=white guibg=#592929
    match OverLength /\%81v./
endif
" }}}
" }}}

    " - FUNCTIONS AND AUTOCOMMANDS {{{

    " -- Reopen files on last used line {{{
autocmd BufLeave,BufWrite,WinLeave * :call Make_the_view()
function! Make_the_view()
    if expand('%') != '' && &buftype !~ 'nofile'
        mkview
    endif
endfunction
autocmd BufEnter * :call Load_the_view()
function! Load_the_view()
    if expand('%') != '' && &buftype !~ 'nofile'
        silent loadview
        cd %:h  " Force cd to dir of current file.
    endif
endfunction
" }}}

    " -- General file edits and cleanup {{{
augroup general_edit_group
    autocmd!
    autocmd BufWritePre * :let b:winview=winsaveview()
    " Remove all trailing whitespace before saving
    autocmd BufWritePre * :%s/\s\+$//e
    " Replace tabs with spaces before saving
    autocmd BufWritePre * :1,$retab<CR>
    autocmd BufWritePre * :call PromptSetUnixLineEndings()
    autocmd BufWritePre * :call winrestview(b:winview)
augroup END
" }}}

    " -- Prompt to change line endings to Unix format {{{
function! PromptSetUnixLineEndings()
    if &fileformat != 'unix'
        let l:prompt = input('Change line endings to Unix format? [n] ')
        if l:prompt == 'y' || 'Y'
            set fileformat=unix
            execute '%s//\r/ge'
        endif
    endif
endfunction
" }}}

    " -- Toggle the diff of currently open buffers/splits {{{
noremap <F4> :call DiffMe()<CR>
let $diff_me=0
function! DiffMe()
    windo diffthis
    if $diff_me>0
        let $diff_me=0
    else
        windo diffoff
    let $diff_me=1
    endif
endfunction
" }}}

    " -- Write function to check for write access and SudoWrite if necessary {{{
noremap <C-s> W
command! W call Write()
function! Write()
    let file = expand('%:p')
    let directory = expand('%:h')
    if filewritable(file)
        write  " File exists and is writable
        return
    endif

    if !filereadable(file) && filewritable(directory)
        write  " File does not exist, but directory is writable
        return
    endif

    if exists('b:write_with_sudo')
        call SudoWrite()  " Already answered yes to prompt; autocmd already set up.
        return
    endif

    let l:prompt = input('File cannot be written. Use sudo? [n] ')
    if !l:prompt == 'y' || 'Y'
        return  " Don't save anything.
    endif
    let b:write_with_sudo = 'y'  " Set a buffer 'flag' saving the answer

    set noro
    call SudoWrite()

    " If write_with_sudo is set, when entering buffer, unset RO flag
    " This makes entering and leaving the buffer easier.
    autocmd BufEnter * call CheckRO()
    function! CheckRO()
        if exists('b:write_with_sudo')
            set noro
        endif
    endfunction
endfunction
" }}}

    " -- Mapping for sudo write (without unnecessary prompts and output) {{{
cnoremap w!! call SudoWrite()
function! SudoWrite()
    set bt=nowrite
    mkview
    silent write !sudo tee '%' >/dev/null
    edit
    set bt=
endfunction
" }}}

    " -- Follow symlinked file {{{
" Adapted from:
" http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" Changes the working directory to be that of the actual file.
function! FollowSymlink()
  let current_file = expand('%:p')
  " Check if file type is a symlink
  if getftype(current_file) == 'link'
    " If it is a symlink resolve to the actual file path and open it.
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
    " Write itself with itself; else, you'd have to :w! for the first write.
    silent! execute 'w!'
  end
endfunction
autocmd BufRead * call FollowSymlink()
" }}}

    " -- Remove file {{{
command! Rm call Rm()
function! Rm()
    let file = expand('%:p')

    if !filereadable(file) " Nothing to do, file doesn't exist (or isn't readable)
        bdelete
        echom "File (" . file . ") doesn't exist"
        return
    endif

    if filewritable(file)
        bdelete
        execute 'silent !rm -i "' . file . '"'
        redraw!
    else
        bdelete
        execute 'silent !sudo rm -i "' . file . '"'
        redraw!
    endif
endfunction
" }}}

    " -- Functions to map to frequent typos {{{
command! Tabnew tabnew
command! Q q
command! Qa qall
command! E e
" }}}
" }}}

" vim:set fdm=marker:
