" Vim filetype plugin file
" Language: Text

setlocal complete+=kspell
setlocal formatoptions+=n,t
setlocal textwidth=72

" Recognize lists with Roman numerals, single letters, digits, etc.
setlocal formatlistpat=^\\s*[\\[({]\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[.+o*-]\\s\\+

runtime! abbrev.vim

if &ft == "text"
  setlocal comments=
endif

setlocal keywordprg=:Sdcv

" Call vim-unicoder.
Unicoder
