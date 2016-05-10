setlocal iskeyword=@,_,-,?,!,%,#,48-57,192-255
setlocal textwidth=120

function! PutDeclarationsOnIndividualLines()
    execute "normal! 0f}i\<CR>\<ESC>k0f{a\<CR>\<ESC>"
    while getline(".") =~ ";.*;"
        execute "normal! 0f;a\<CR>\<ESC>"
    endwhile
endfunction

function! PutDeclarationsOnOneLine()
    execute "normal! $va{J"
endfunction

noremap gqh 0120lF;a<CR><ESC>
noremap gqj :call PutDeclarationsOnIndividualLines()<CR>
noremap gqk :call PutDeclarationsOnOneLine()<CR>
