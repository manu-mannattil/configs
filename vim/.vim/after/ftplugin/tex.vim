" Vim filetype plugin file
" Language: LaTeX

runtime! abbrev.vim

setlocal autochdir
"setlocal iskeyword+=-
setlocal keywordprg=:Sdcv
setlocal spell

" Files to ignore and give less priority.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

let b:longlines_keep_maps = 1

" Quick snippets using my fork of snipmate.
inoremap <silent> `/ <ESC>:call QuickSnippet('\frac{${1}}{${2}}${3}')<CR>i
inoremap <silent> `2 <ESC>:call QuickSnippet('\sqrt{${1}}${2}')<CR>i
inoremap <silent> `~ <ESC>:call QuickSnippet('\tilde{${1}}${2}')<CR>i
inoremap <silent> `^ <ESC>:call QuickSnippet('\hat{${1}}${2}')<CR>i
