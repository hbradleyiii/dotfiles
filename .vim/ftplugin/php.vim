setlocal iskeyword=$,@,_,-,48-57,192-255
setlocal include=\\\(require\\\|include\\\)\\\(_once\\\)\\\?
setlocal comments=sr:/*,mb:*,ex:*/,://,b:#
setlocal define=define

compiler php

setlocal cindent
setlocal cindent
setlocal cinwords=if,elseif,else,while,do,for,foreach,switch,case
setlocal cinkeys=0{,0},0),!^F,o,O,e
setlocal cinoptions=:1s,p1s,t0,)40,*40
setlocal matchpairs=(:),{:},[:]

setlocal nosmartindent " don't use smart indent
