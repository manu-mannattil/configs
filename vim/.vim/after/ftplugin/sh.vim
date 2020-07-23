" Vim filetype plugin file
" Language: Shell

" I often use comments starting with #: to `self-document' shell scripts.
setlocal comments+=b:#:
setlocal shiftwidth=4
setlocal softtabstop=4

setlocal makeprg=bash\ -n\ %
setlocal errorformat=%f:\ %l:\ %.%#:\ %m
