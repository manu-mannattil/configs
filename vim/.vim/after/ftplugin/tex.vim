" Vim filetype plugin file
" Language: LaTeX

runtime! abbrev.vim

setlocal spell
setlocal keywordprg=:Sdcv
setlocal iskeyword+=-,:

" Make use of the default ftplugin's concealment feature.
setlocal conceallevel=2

" Files to ignore and give less priority.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

let g:longlines_keep_maps = 1
