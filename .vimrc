" ~/.vimrc
"
" created by:       Harold Bradley III
" email:            hbradleyiii@gmail.com
"

set nocompatible

    " - KEY MAPPINGS {{{
" Leader key
let mapleader=","  " By default ',' just repeats latest f, t, F or T in opposite direction
" Map \ to do what ',' used to do
nnoremap \ ,
vnoremap \ ,

" Omnicompletion (C-space
inoremap <C-Space> <C-x><C-o>
inoremap <C-o> <C-x><C-o>
" Sometimes the terminal seees C-space as C-@
inoremap <C-@> <C-x><C-o>
" Use C-j and C-k for navigating matches
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

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
inoremap jj <ESC>l
inoremap hh <ESC>^i
inoremap kk <ESC>$a
noremap <Enter> o<ESC>
" Natural up and down movements
nnoremap j gj
nnoremap k gk

" Make (un)indenting one keypress
nnoremap > >>
nnoremap < <<
" Keep visual selection when indenting text
vnoremap > >gv
vnoremap < <gv

" Playback in register 'q' (record: qq)
nnoremap Q @q

" Make tg the opposite of gt
noremap tg :tabprevious <CR>

" Highlight last inserted text
nnoremap gV `[v`]

" Yank all the contents of the file
nnoremap ya :%y+<Enter>

" Put the register contents register in current buffer
nnoremap yp ggdG"0pkdd

" Delete contents of entire file
nnoremap da ggdG

" Clone a paragraph
noremap cp yap<S-}>p

" Align current paragraph
noremap <Leader>a =ip

" Forces creation of a file if it doesn't exist
noremap gf :e <cfile><CR>

" Forces reloading the file
noremap  <Leader>re :e!<CR>

" Moving in the buffer
noremap <silent> <Leader>b :bp<CR>
noremap <silent> <Leader>n :bn<CR>
noremap <silent> <Leader>m :b#<CR>

" Ctrl mappings to change windows
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Jump to tags
" alternative to <C-]>
nnoremap <Leader>] :tag /<C-r>=expand('<cword>')<CR><CR>
" alternative to <C-w>}
nnoremap <Leader>} :ptag /<C-r>=expand('<cword>')<CR><CR>

" Searching keymaps
nnoremap <C-/> :grep -R<space>


" 'e'dit 'v'imrc
noremap <silent> <Leader>sv :so $MYVIMRC<CR>
noremap <silent> <Leader>ev :tabedit $HOME/.vimrc<CR>
noremap <silent> <Leader>ee :tabedit $HOME/.emacs<CR>
" 'e'dit 'b'ashrc
noremap <silent> <Leader>sb :!rebash<CR>
noremap <silent> <Leader>eb :tabedit $HOME/.bashrc<CR>
noremap <silent> <Leader>ep :tabedit $HOME/.bash_profile<CR>

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
" Pastetoggle works in both normal and insert mode.
" Not using <Leader><space> as this could be in the text being pasted.
set pastetoggle=<F6>
noremap <Leader><SPACE> :set paste!<CR>
noremap <Leader>l :set list!<CR>
inoremap <Leader>l <ESC>:set list!<CR>a
noremap <Leader>w :set wrap!<CR>
inoremap <Leader>w <ESC>:set wrap!<CR>a
noremap <Leader>. :set relativenumber!<CR>
inoremap <Leader>. <ESC>:set relativenumber!<CR>a
noremap <SPACE> :call ToggleSHighlights()<CR>

if $MAC_OS == 'true'
    " set clipboard=unnamed " Needed??
    noremap <Leader>c :!tee >(pbcopy)<CR>
    noremap <Leader>v :set paste<CR>:r!pbpaste<CR>:set nopaste<CR>
    inoremap <Leader>v <ESC>:set paste<CR>:r!pbpaste<CR>:set nopaste<CR>a
endif



let g:s_highlights = 0
function! ToggleSHighlights()
    if g:s_highlights
        set nohlsearch
        set nocursorline
        set nocursorcolumn
        let g:s_highlights = 0
    else
        set hlsearch
        set cursorline
        set cursorcolumn
        let g:s_highlights = 1
    endif
endfunction

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


" Reset keymap by default
set keymap=

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
        set keymap=hebrew_tiro
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

Plugin 'airblade/vim-gitgutter'
Plugin 'alfredodeza/pytest.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-php-manual'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ap/vim-css-color'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'conradirwin/vim-bracketed-paste'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'hail2u/vim-css3-syntax'
"Plugin 'jceb/vim-orgmode'
Plugin 'joonty/vdebug.git'
Plugin 'junegunn/gv.vim'
Plugin 'jwalton512/vim-blade'
"Plugin 'klen/python-mode'
Plugin 'lepture/vim-jinja'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-vinegar'
"Plugin 'yuttie/comfortable-motion.vim'
Plugin 'vim-scripts/timestamp.vim'
call vundle#end()  " Must be AFTER plugin list

" If this is a fresh install, install all initialized plugins {{{
if g:InstallVundlePlugins == 1
    execute 'VundleInstall'
endif  " }}}

" Once a month, update and clean plugins {{{
let g:last_plugin_update = getftime($HOME . "/.vim/bundle/Vundle.vim/doc/tags")
if g:last_plugin_update + 2628000 < localtime()
    echom 'Last updated: ' . strftime('%c', g:last_plugin_update)
    execute 'VundleClean'
    execute 'VundleUpdate'
    :q
endif  " }}}
" }}}

    " -- Plugin Options/Keybindings {{{

"" Awk
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"" CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 'rwc'
noremap <Leader>p :CtrlP<CR>
noremap <Leader>t :CtrlPTag<CR>
noremap <C-t> :CtrlPTag<CR>
noremap <Leader>f :CtrlPMRUFiles<CR>

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

"" Comfortable Motion
let g:comfortable_motion_interval = 1000.0 / 20
let g:comfortable_motion_friction = 200.0
let g:comfortable_motion_air_drag = 0.0

"" Fugitive
noremap <silent> <Leader>ga :Git add %<CR>
noremap <silent> <Leader>gc :Gcommit -v -q<CR>
noremap <silent> <Leader>gi :Git add -i<CR>
noremap <silent> <Leader>gt :Git add --patch %<CR>
noremap <silent> <Leader>gl :Git l1<CR>
noremap <silent> <Leader>gs :Gstatus<CR>
noremap <silent> <Leader>gp :Gpull<CR>:Gpush<CR>
noremap <silent> <Leader>gw :Gwrite<CR><CR>
noremap <silent> <Leader>gg :Ggrep<SPACE>
noremap <silent> <Leader>gb :Git branch<SPACE>
noremap <silent> <Leader>go :Git checkout<SPACE>
noremap <silent> <Leader>g- :Silent Git stash<CR>:e<CR>
noremap <silent> <Leader>g+ :Silent Git stash pop<CR>:e<CR>

"" Git Gutter
let g:gitgutter_max_signs = 1500
let g:gitgutter_grep = 'grep'

"" Gundo
noremap <Leader>u :GundoToggle<CR>

"" PHP Manual
let g:php_manual_online_search_shortcut = '<Leader>h'

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
set mouse=a
set updatetime=100
set wildignore+=*~,*.bak,*.pyc,*.swp,*.tmp,.git
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.so,*.zip
set wildignore+=.sass-cache

set splitbelow
set splitright

set shellslash
set visualbell t_vb=

set autoread
au BufEnter * checktime
au CursorHold * checktime

" Session options
set sessionoptions=buffers,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" Fold options
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Tags
set tags=./tags,tags;

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
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set backspace=2
set showbreak=»»
if has("multi_byte")
    set listchars=tab:>-,eol:¬,trail:•,extends:»,precedes:«,nbsp:·
else
    set listchars=tab:>-,eol:$,trail:_,extends:>>,precedes:<<,nbsp:_
endif
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
set synmaxcol=256

if has('gui_running')  " Set up the gui for GVim
    " Set the cursor for various modes
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
    if $MAC_OS == 'true'
        set guifont=Monaco:h16
    else
        set guifont=Pragmata\ 16
    endif
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
    highlight Normal guibg=#090909
    " Highlight lines over 80 chars
    highlight OverLength ctermbg=234 ctermfg=red guibg=#592929
    match OverLength /\%81v./
endif
" }}}
" }}}

    " - FUNCTIONS AND AUTOCOMMANDS {{{

    " -- General file edits and cleanup {{{
noremap <F5> :call ToggleGeneralEdits()<CR>
noremap <Leader>ge :call ToggleGeneralEdits()<CR>
function! ToggleGeneralEdits()
    if !exists('#general_edit_group') || !exists('#general_edit_group#BufWritePre')
        echom "Creating general edit autocommands."
        augroup general_edit_group
            autocmd!
            autocmd BufWritePre * :let b:winview=winsaveview()
            " Remove all trailing whitespace before saving
            autocmd BufWritePre * if &ft != 'diff' && getline('$') !~ "allow_trailing_whitespace" | :%s/\s\+$//e | endif
            " Replace tabs with spaces before saving
            autocmd BufWritePre * :1,$retab
            autocmd BufWritePre * :call PromptSetUnixLineEndings()
            autocmd BufWritePre * :call winrestview(b:winview)
        augroup END
    else
        echom "Removing general edit autocommands."
        augroup general_edit_group
            autocmd!
        augroup END
    endif
endfunction
autocmd VimEnter * call ToggleGeneralEdits()
" }}}

    " -- Prompt to change line endings to Unix format {{{
function! PromptSetUnixLineEndings()
    if &fileformat == 'unix'  " Ignore if it is already unix ending
        return
    endif

    let l:prompt = input('Change line endings to Unix format? [n] ')
    if l:prompt == 'y' || 'Y'
        set fileformat=unix
        execute '%s//\r/ge'
    else
    endif
endfunction
" }}}

    " -- Reopen files on last used line {{{
autocmd BufLeave,BufWrite,WinLeave * :call Make_the_view()
function! Make_the_view()
    if &buftype !~ 'nofile' && expand('%') != ''
        try
            mkview
        catch  " If the view can't be made, die gracefully
        endtry
    endif
endfunction
autocmd BufEnter * :call Load_the_view()
function! Load_the_view()
    " A hack to prevent tagbar from creating an infinite loop
    if bufwinnr('__Tagbar__') != -1 && bufwinnr('__Tagbar__') == winnr('$')
        return
    endif
    " Ignore for special buffers
    if &buftype !~ 'nofile' || &buftype !~ '' || expand('%') == ''
        return
    endif
    loadview
    cd %:h  " Force cd to dir of current file.
endfunction
" }}}

    " -- Toggle the diff of currently open buffers/splits {{{
noremap <F4> :call DiffMe()<CR>
function! DiffMe()
    if !exists("w:is_diff_window")
        let w:is_diff_window = 0
    endif

    if w:is_diff_window == 0
        windo diffthis
        let w:is_diff_window = 1
    else
        windo diffoff
        let w:is_diff_window = 0
    endif
endfunction
" }}}

    " -- Write function to check for write access and SudoWrite if necessary {{{
noremap <C-s> :W<CR>
inoremap <C-s> <Esc>:W<CR>a
command! W call Write()
function! Write()
    if &readonly
        let l:prompt = input('Readonly flag is set. Write anyway? [n] ')
        if l:prompt == 'y' || 'Y'
            set noro  " Explicitly remove readonly flag
        else
            " Readonly, just quit; don't save.
            return
        endif
    endif

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
        " Don't save anything.
        return
    endif
    let b:write_with_sudo = 'y'  " Set a buffer 'flag' saving the answer

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
autocmd BufRead * call FollowSymlink()
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

    " -- Automatically source vimrc changes {{{
augroup general_edit_group
    autocmd!
    autocmd BufWritePost .vimrc source %
    autocmd BufWritePost .gvimrc source %
augroup END
" }}}

    " -- Ranger File Explorer {{{
if has('gui_running') || ! executable('ranger')
    " Ranger doesn't work in gui or MAC
    noremap <Leader>, :tabe ./<CR>
    noremap <F2> :tabe ./<CR>
else
    noremap <Leader>, :RangerExplorer<CR>
    noremap <F2> :RangerExplorer<CR>
endif
command! RangerExplorer call RangerExplorer()
function! RangerExplorer()
    exec "silent !ranger --choosefiles=$HOME/.vim/ranger_selected_file " .expand("%:p:h")
    if filereadable($HOME.'/.vim/ranger_selected_file')
        let first_file = 1
        for file in readfile($HOME.'/.vim/ranger_selected_file', '', 10)
            exec 'tabnew ' . file
            if first_file == 1
                let first_file = file
            endif
        endfor
        " Make the first file the current file.
        exec 'edit ' . first_file
        call system('rm ~/.vim/ranger_selected_file')
    endif
    redraw!
endfunction
" }}}

    " -- Functions to map to frequent typos {{{
command! -nargs=* -complete=file Tabnew tabnew <args>
command! -nargs=* -complete=file E e <args>
command! Q q
command! Qa qall
" }}}

    " -- Extra php syntax highlighting {{{
function! PhpSyntaxMod()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

let php_parent_error_close=1
let php_noShortTags = 1

augroup php_syntax
    autocmd!
    autocmd FileType php call PhpSyntaxMod()
augroup END
" }}}

autocmd BufRead,BufNewFile *.twig set filetype=jinja
autocmd BufRead,BufNewFile *.rasi setlocal filetype=css
autocmd BufRead,BufNewFile *.less setlocal filetype=css

    " -- Search Project Command {{{
command! -nargs=1 L call Search(<f-args>)
function! Search(search_string)
    execute ":Ack ".a:search_string." ".GetProjectRoot()
endfunction

command! -nargs=1 LK call SearchAdd(<f-args>)
function! SearchAdd(search_string)
    execute ":AckAdd ".a:search_string." ".GetProjectRoot()
endfunction
" }}}

    " -- Get project root {{{
" Adapted from:
" s:guessProjectRoot() in
" https://github.com/rking/ag.vim/blob/master/autoload/ag.vim
" Attempts to guess the root directory.
function! GetProjectRoot()
    let split_directories = split(getcwd(), "/")

    while len(split_directories) > 2
        let path = '/'.join(split_directories, '/').'/'

        for marker in ['.rootdir', '.git', '.hg', '.svn', 'bzr', '_darcs', 'build.xml']
            if filereadable(path.marker) || isdirectory(path.marker)
                return path
            endif
        endfor

        let split_directories = split_directories[0:-2] " Go up a directory
    endwhile

    " Fallback to current working directory
    return getcwd()
endfunction
" }}}

" }}}

if filereadable(expand("~/.vimrc_local"))
    source $HOME/.vimrc_local
endif

" vim:set fdm=marker:
