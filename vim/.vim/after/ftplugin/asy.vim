" Vim filetype plugin file
" Language: Asymptote

setlocal cindent
setlocal commentstring=//%s

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
" (from .../ftplugin/c.vim)
setlocal fo-=t fo+=croql
