" Vim filetype plugin file
" Language: LaTeX

runtime! abbrev.vim

setlocal spell
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal keywordprg=:Sdcv

" Files to ignore and give less priority.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

" Vimtex maps K to 'lookup keyword using texdoc'.
nunmap <buffer> K
