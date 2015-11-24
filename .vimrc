set nocompatible

" required
filetype off

" set the runtime path to include Vundle 
set rtp+=~/.vim/bundle/Vundle.vim

" make sure Vundle is installed
let g:InstallVundlePlugins = 0
if empty(glob("~/.vim/bundle/Vundle.vim"))
    execute "!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
    let g:InstallVundlePlugins = 1
endif

" initialize Vundle
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-php-manual'
Plugin 'ap/vim-css-color'
Plugin 'ervandew/supertab'
Plugin 'jceb/vim-orgmode'
Plugin 'kien/ctrlp.vim'
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

Plugin 'joonty/vdebug.git'


" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" All of your Plugins must be added before the following line
call vundle#end()

if g:InstallVundlePlugins == 1
    execute 'VundleInstall'
endif


let g:syntastic_csslint_args="--ignore=universal-selector"
"let g:syntastic_css_checkers=["recess"]
let g:syntastic_css_checkers=["csslint"]
let g:syntastic_html_tidy_exec = 'tidy5'


" UltiSnips
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsExpandTrigger="<tab>"                                            
let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"  


set shellslash

set visualbell t_vb=

""""""""""""""""""""""""
" FILETYPE & SYNTAX HIGHLIGHTING

" colorscheme must be AFTER this!
filetype plugin indent on

syntax on


""""""""""""""""""""""""
" COLOR & GRAPHICS

if has('gui_running') " Set up the gui
    set cursorline
    " Set the cursor for various modes
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    set guifont=Pragmata:h18
   "set guifont=Monaco:h18
    set guioptions=acer " m for menu
   "set lines=35
   "set columns=85
    set ttyfast
endif

if &t_Co >= 256 || has("gui_running")
    " baycomb scite nedit2 gentooish solarized
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    colorscheme solarized
    " Invisible character colors
    highlight NonText guifg=#151515
    highlight SpecialKey guifg=#151515
endif

" Highlight lines over 80 chars
highlight OverLength ctermbg=234 ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Write a function to toggle this.
" map <silent> <leader>ml :imrc<CR>


" VIM colors see:
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim




""""""""""""""""""""""""
" FILE SETTINGS

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


""""""""""""""""""""""""
" INDENT SETTINGS

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


""""""""""""""""""""""""
" SEARCHING

set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch


""""""""""""""""""""""""
" ENVIRONMENT

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



" Session options
set sessionoptions=buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Fold options
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Status Line
set stl=%h%w%m\ %f\ %r\ (b:%n)\ %=%30(Line:\ %l/%L\ [%p%%]\ %)%8(Col:%3c\ %)%13([%b][0x%B]%)
set laststatus=2
set number
set ruler

" set lines=42
" set columns=90


let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

""""""""""""""""""""""""
" KEY MAPPINGS


" Leader key
" By default ',' just repeats latest f, t, F or T in opposite direction
" It still does if you wait a brief second
let mapleader=","
" Map CTRL-E to do what ',' used to do
nnoremap <c-e> ,
vnoremap <c-e> ,


" Windows-like mods
" TODO: Should this be * or +?
map <C-c> "*
vmap <C-c> "*y
map <C-x> "*dd<Esc>
vmap <C-x> "*d
map <leader>v "*p
imap <C-s> <Esc>:w<CR>
map <F1> :tab help <CR>


" Custom Mods
nmap gg ggzz
    " jj Escape in insert mode
imap jj <Esc>
imap hh <Esc>^i
imap kk <Esc>$a
map <Enter> o<Esc>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Do this only for notes and things with wrapping text
" This makes the natural up and down without skipping to next real line
nnoremap j gj
nnoremap k gk

" Make tg the opposite of gt
map tg :tabprevious <CR>


" Forces creation of a file if it doesn't exist, and do it in a new tab
"map gf :tabnew <cfile><CR>
map gf :e <cfile><CR>
" In windows, run command under cursor
map <leader>of :!start cmd /c <cfile><CR>
map <leader>nt :NERDTreeToggle <CR>
map <F2> :NERDTreeToggle <CR>


" Option Toggles
nmap <leader>l :set list!<CR>
nmap <leader>w :set wrap!<CR>
nmap <Space> :set hlsearch!<CR>
nmap <leader><Space> :set paste!<CR>
    " Spellcheck
map <F8> :set invspell<CR>

" Highlight last inserted text
nmap gV `[v`]

" Shortcut Keymaps
    " Remove trailing spaces
nmap <silent> ,ss :%s/\s\+$//<Enter>
    " TODO: Set up retabbing on a source file
nmap  ,rr :1,$retab<CR>
    " cd to the directory containing the file in the buffer
nmap  ,cd :lcd %:h<CR>

" Insert timestamp
nmap <F3> a<C-R>=strftime("%b %d, %Y %H:%M")<CR><Esc>
imap <F3> <C-R>=strftime("%b %d, %Y %H:%M %p")<CR>


" Execute in vim the line under the cursor
map <leader>ex yy:@"<CR>

nmap <silent> <leader>f :e ./<CR>
nmap <silent> <leader>b :bp<CR>
nmap <silent> <leader>n :bn<CR>
nmap <silent> <leader>m :b#<CR>

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ev :tabedit ~/.vimrc<CR>
nmap <silent> <leader>en :tabedit ~/env.not<CR>
nmap <silent> <leader>nv :tabedit ~/vim/index.not<CR>
nmap <silent> <leader>ni :tabedit ~/index.not<cr>

" Install and clean plugins
nmap <silent> <leader>pi :PluginClean<CR>:q<CR>:PluginInstall<CR>:q<CR>

nmap <silent> <leader>es :UltiSnipsEdit<cr>

cmap eval :VdebugEval<cr>
cmap vd VdebugStart<cr>

" Automatically reload this file after saving
"autocmd BufWritePost .vimrc source $MYVIMRC

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
