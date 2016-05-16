setlocal iskeyword=@,_,-,?,!,%,#,48-57,192-255
setlocal textwidth=120

function! PutDeclarationsOnIndividualLines()
    execute "normal! 0f}i\<CR>\<ESC>k0f{a\<CR>\<ESC>"
    while getline(".") =~ ";.*;"
        execute "normal! 0f;a\<CR>\<ESC>"
    endwhile
    call SortAlphabeticallyInBraces()
endfunction

function! PutDeclarationsOnOneLine()
    call SortAlphabeticallyInBraces()
    " Put declarations on one line:
    execute "normal! $va{J"
endfunction

function! SortAlphabeticallyInBraces()
    " Sort alphabetically:
    execute "normal! $vi{:sort\<CR>"
endfunction

noremap gqh 0120lF;a<CR><ESC>
noremap gqj :call PutDeclarationsOnOneLine()<CR>
noremap gqk :call PutDeclarationsOnIndividualLines()<CR>
