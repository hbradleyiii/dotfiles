" ~/.vimrc
"
" created by:       Harold Bradley III
" email:            hbradleyiii@bradleystudio.net
"

set nocompatible

    " Plugins " {{{

filetype off " Required

" Set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Plugin List {{{
" Install Vundle if it isn't already installed {{{
let g:InstallVundlePlugins = 0
if empty(glob("~/.vim/bundle/Vundle.vim"))
    execute "!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
    let g:InstallVundlePlugins = 1
endif " }}}

call vundle#begin() " Vundle Initialization
Plugin 'gmarik/Vundle.vim' " Let Vundle manage Vundle, required

Plugin 'alfredodeza/pytest.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-php-manual'
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'
Plugin 'jceb/vim-orgmode'
Plugin 'joonty/vdebug.git'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
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
call vundle#end() " Must be AFTER plugin list

" If this is a fresh install, install all initialized plugins {{{
if g:InstallVundlePlugins == 1
    execute 'VundleInstall'
endif " }}}
" }}}

    "" Plugin Options/Keybindings "" {{{

"" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

"" Fugitive
nmap <silent> <leader>ga :Git add %<cr>
nmap <silent> <leader>gc :Gcommit<cr>
nmap <silent> <leader>gl :Git log<cr>
nmap <silent> <leader>gs :Gstatus<cr>
nmap <silent> <leader>gp :Gpull<cr>:Gpush<cr>

" Gundo
nnoremap <leader>u :GundoToggle<CR>

"" NerdTree
map <leader>nt :NERDTreeToggle <CR>
map <F2> :NERDTreeToggle <CR>

"" Syntastic
let g:syntastic_csslint_args="--ignore=universal-selector"
"let g:syntastic_css_checkers=["recess"]
let g:syntastic_css_checkers=["csslint"]
let g:syntastic_html_tidy_exec = 'tidy5'

"" UltiSnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
nmap <silent> <leader>es :UltiSnipsEdit<cr>

"" Vdebug
cmap eval :VdebugEval<cr>
cmap vd VdebugStart<cr>

"" Vundle
nmap <silent> <leader>pi :PluginClean<CR>:q<CR>:PluginInstall<CR>:q<CR>

" }}} }}}

    " General Vim Options " {{{

set title
set showcmd
set history=1000
set showmode
set wildmenu
set ofu=syntaxcomplete#Complete
set lazyredraw
set scrolloff=2
set virtualedit=all
set fillchars="" " separator chars
set mousehide

set shellslash
set visualbell t_vb=

" Session options
set sessionoptions=buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Fold options
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Status Line
set stl=%h%w%m\ %f\ %r\ (b:%n)\ %=%30(Line:\ %l/%L\ [%p%%]\ %)%8(Col:%3c\ %)%13([%b][0x%B]%)
set laststatus=2
set number
set ruler

    "" File Settings ""
if !isdirectory($HOME . "/.vim/.backup")
    call mkdir($HOME . "/.vim/.backup", "p")
endif
if !isdirectory($HOME . "/.vim/.swap")
    call mkdir($HOME . "/.vim/.swap", "p")
endif
if !isdirectory($HOME . "/.vim/.undo")
    call mkdir($HOME . "/.vim/.undo", "p")
endif

set backup
set writebackup
set swapfile
set undofile
set undolevels=1000
set undoreload=10000
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swap//
set undodir=~/.vim/.undo//

set encoding=utf8
set ffs=unix,dos,mac
set hidden
set autochdir
set cryptmethod=blowfish

    "" Tabs/Indent Settings ""
set autoindent
set smartindent " TODO: I'm not sure about this one...
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set backspace=2
set showbreak=»»
" TODO: fix for terminals:
set listchars=tab:>-,eol:¬,trail:•,extends:»,precedes:«,nbsp:·

    "" Searching ""
set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch


    "" Filetype & Syntax Highlighting ""

" colorscheme must be AFTER this!
filetype plugin indent on
syntax on

if has('gui_running') " Set up the gui for GVim
    set cursorline
    " Set the cursor for various modes
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set guifont=Monaco:h18
    set guifont=Pragmata:h18
    set guioptions=acer
    set ttyfast
endif

if &t_Co >= 256 || has("gui_running") " For 256color Terminals or GVim
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

    " KEY MAPPINGS " {{{

"" Leader key
" By default ',' just repeats latest f, t, F or T in opposite direction
let mapleader=","
" Map ,, to do what ',' used to do
nnoremap <leader>, ,
vnoremap <leader>, ,

"" Windows-like mods
" TODO: Should this be * or +?
map <C-c> "*
vmap <C-c> "*y
map <C-x> "*dd<Esc>
vmap <C-x> "*d
map <leader>v "*p
imap <C-s> <Esc>:w<CR>
map <F1> :tab help <CR>

"" Movement Mods
nmap gg ggzz
    " jj Escape in insert mode
imap jj <Esc>
imap hh <Esc>^i
imap kk <Esc>$a
map <Enter> o<Esc>
" Natural up and down movements
nnoremap j gj
nnoremap k gk

" Make tg the opposite of gt
map tg :tabprevious <CR>

" Highlight last inserted text
nmap gV `[v`]

" Forces creation of a file if it doesn't exist
map gf :e <cfile><CR>

" In windows, run command under cursor
map <leader>of :!start cmd /c <cfile><CR>

" Execute in vim the line under the cursor
map <leader>ex yy:@"<CR>

"" Option Toggles
nmap <leader>l :set list!<CR>
nmap <leader>w :set wrap!<CR>
nmap <Space> :set hlsearch!<CR>
nmap <leader><Space> :set paste!<CR>
nmap <leader>. :set relativenumber!<CR>

" Spellcheck
map <F8> :set invspell<CR>

"" Editing Keymappings
" Remove trailing spaces
nmap <silent> ,ss :%s/\s\+$//<Enter>
" TODO: Set up retabbing on a source file
nmap  ,rr :1,$retab<CR>

" Insert timestamp
nmap <F3> a<C-R>=strftime("%b %d, %Y %H:%M")<CR><Esc>
imap <F3> <C-R>=strftime("%b %d, %Y %H:%M %p")<CR>

nmap <silent> <leader>f :e ./<CR>
nmap <silent> <leader>b :bp<CR>
nmap <silent> <leader>n :bn<CR>
nmap <silent> <leader>m :b#<CR>

"" 'e'dit 'v'imrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ev :tabedit ~/.vimrc<CR>

"" 'e'dit 'b'ashrc
nmap <silent> <leader>sb :!rebash<CR>
nmap <silent> <leader>eb :tabedit ~/.bashrc<CR>

"" save session
nnoremap <leader>s :mksession<CR>
" }}}

    " Functions and AutoCommands " {{{

" Remove all trailing whitespace before saving
autocmd BufWritePre * :%s/\s\+$//e
" Replace tabs with spaces before saving
autocmd BufWritePre * :1,$retab<CR>

" Press F4 to toggle the diff of currently open buffers/splits.
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

"" Mapping to sudo write (without unnecessary prompts and output)
cnoremap ws exec SudoWrite()
function! SudoWrite()
    :set bt=nowrite
    :w !sudo tee % >/dev/null
    :e
    :set bt=
endfunction

" Follow symlinked file
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

" vim:set fdm=marker:
