" Vim filetype plugin file
" Language: Shell

" I often use comments starting with #: to `self-document' shell scripts.
setlocal comments+=b:#:

setlocal makeprg=bash\ -n\ %
setlocal errorformat=%f:\ %l:\ %.%#:\ %m
