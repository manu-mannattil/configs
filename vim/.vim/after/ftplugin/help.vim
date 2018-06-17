" Vim filetype plugin file
" Language: help

setlocal nospell
setlocal keywordprg=:help

" <left>/<right> buffer navigation is annoying in help files.
nnoremap <buffer> <left> <left>
nnoremap <buffer> <right> <right>
