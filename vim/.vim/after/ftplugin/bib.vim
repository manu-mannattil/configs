" Vim filetype plugin file
" Language: BibTeX

runtime! abbrev.vim

setlocal autochdir
setlocal keywordprg=:Sdcv
setlocal spell

" Files to ignore and give less priority.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

" Use BibTool for formatting if available.
if executable('bibtool')
  setlocal formatprg=bibtool
  noremap <buffer> Q gq
endif
