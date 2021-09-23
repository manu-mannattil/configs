" Vim filetype plugin file
" Language: TeX

" Files to ignore.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy

" Bail out if we're not editing a *.tex file (*.sty and *.cls files
" have TeX filetypes).
if expand('%:e') !=? 'tex'
  finish
endif

" Files to give less priority if editing a *.tex file.
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

runtime! abbrev.vim

setlocal autochdir
setlocal keywordprg=:Sdcv
setlocal norelativenumber
setlocal spell

" Enable longline mode.
let b:longlines_keep_maps = 1
LongLines

" Adapted from vimtex's default imaps.
let b:vimtex_imaps_list = [
      \ { 'lhs' : '0',  'rhs' : '\emptyset' },
      \ { 'lhs' : '6',  'rhs' : '\partial' },
      \ { 'lhs' : '8',  'rhs' : '\infty' },
      \ { 'lhs' : '=',  'rhs' : '\equiv' },
      \ { 'lhs' : '\',  'rhs' : '\setminus' },
      \ { 'lhs' : '.',  'rhs' : '\cdot' },
      \ { 'lhs' : '*',  'rhs' : '\times' },
      \ { 'lhs' : '<',  'rhs' : '\langle' },
      \ { 'lhs' : '>',  'rhs' : '\rangle' },
      \ { 'lhs' : 'H',  'rhs' : '\hbar' },
      \ { 'lhs' : '+',  'rhs' : '\dagger' },
      \ { 'lhs' : 'o+', 'rhs' : '\oplus' },
      \ { 'lhs' : 'jj', 'rhs' : '\downarrow' },
      \ { 'lhs' : 'jJ', 'rhs' : '\Downarrow' },
      \ { 'lhs' : 'jk', 'rhs' : '\uparrow' },
      \ { 'lhs' : 'jK', 'rhs' : '\Uparrow' },
      \ { 'lhs' : 'jh', 'rhs' : '\leftarrow' },
      \ { 'lhs' : 'jH', 'rhs' : '\Leftarrow' },
      \ { 'lhs' : 'jl', 'rhs' : '\rightarrow' },
      \ { 'lhs' : 'jL', 'rhs' : '\Rightarrow' },
      \ { 'lhs' : 'a',  'rhs' : '\alpha' },
      \ { 'lhs' : 'b',  'rhs' : '\beta' },
      \ { 'lhs' : 'c',  'rhs' : '\chi' },
      \ { 'lhs' : 'd',  'rhs' : '\delta' },
      \ { 'lhs' : 'e',  'rhs' : '\epsilon' },
      \ { 'lhs' : 'f',  'rhs' : '\phi' },
      \ { 'lhs' : 'g',  'rhs' : '\gamma' },
      \ { 'lhs' : 'h',  'rhs' : '\eta' },
      \ { 'lhs' : 'i',  'rhs' : '\iota' },
      \ { 'lhs' : 'k',  'rhs' : '\kappa' },
      \ { 'lhs' : 'l',  'rhs' : '\lambda' },
      \ { 'lhs' : 'm',  'rhs' : '\mu' },
      \ { 'lhs' : 'n',  'rhs' : '\nu' },
      \ { 'lhs' : 'p',  'rhs' : '\pi' },
      \ { 'lhs' : 'q',  'rhs' : '\theta' },
      \ { 'lhs' : 'r',  'rhs' : '\rho' },
      \ { 'lhs' : 's',  'rhs' : '\sigma' },
      \ { 'lhs' : 't',  'rhs' : '\tau' },
      \ { 'lhs' : 'y',  'rhs' : '\psi' },
      \ { 'lhs' : 'u',  'rhs' : '\upsilon' },
      \ { 'lhs' : 'w',  'rhs' : '\omega' },
      \ { 'lhs' : 'z',  'rhs' : '\zeta' },
      \ { 'lhs' : 'x',  'rhs' : '\xi' },
      \ { 'lhs' : 'G',  'rhs' : '\Gamma' },
      \ { 'lhs' : 'D',  'rhs' : '\Delta' },
      \ { 'lhs' : 'F',  'rhs' : '\Phi' },
      \ { 'lhs' : 'G',  'rhs' : '\Gamma' },
      \ { 'lhs' : 'L',  'rhs' : '\Lambda' },
      \ { 'lhs' : 'N',  'rhs' : '\nabla' },
      \ { 'lhs' : 'P',  'rhs' : '\Pi' },
      \ { 'lhs' : 'Q',  'rhs' : '\Theta' },
      \ { 'lhs' : 'S',  'rhs' : '\Sigma' },
      \ { 'lhs' : 'U',  'rhs' : '\Upsilon' },
      \ { 'lhs' : 'W',  'rhs' : '\Omega' },
      \ { 'lhs' : 'X',  'rhs' : '\Xi' },
      \ { 'lhs' : 'Y',  'rhs' : '\Psi' },
      \ { 'lhs' : 've', 'rhs' : '\varepsilon' },
      \ { 'lhs' : 'vf', 'rhs' : '\varphi' },
      \ { 'lhs' : 'vk', 'rhs' : '\varkappa' },
      \ { 'lhs' : 'vl', 'rhs' : '\ell' },
      \ { 'lhs' : 'vq', 'rhs' : '\vartheta' },
      \ { 'lhs' : 'vr', 'rhs' : '\varrho' },
      \ { 'lhs' : g:vimtex_imaps_leader,
      \   'rhs' : repeat(g:vimtex_imaps_leader, 2),
      \   'wrapper' : 'vimtex#imaps#wrap_trivial'},
      \]

for dict in b:vimtex_imaps_list
  call vimtex#imaps#add_map(dict)
endfor

" Quick snippets using my fork of snipmate.
let b:snipmate_quick_snippets = [
      \ ['#B', '\mathbb{${1:R}}${2}'],
      \ ['#C', '\mathscr{${1}}${2}'],
      \ ['#b', '\mathbf{${1}}${2}'],
      \ ['#c', '\mathcal{${1}}${2}'],
      \ ['#e', '\emph{${1}}${2}'],
      \ ['#f', '\mathfrak{${1}}${2}'],
      \ ['#m', '\bm{${1}}${2}'],
      \ ['#s', '\mathsf{${1}}${2}'],
      \ ['^' , '^{${1}}${2}'],
      \ ['_' , '_{${1}}${2}'],
      \ ['`(', '\left(${1}\right)${2}'],
      \ ['`/', '\frac{${1}}{${2}}${3}'],
      \ ['`2', '\sqrt{${1}}${2}'],
      \ ['`[', '\left[${1}\right]${2}'],
      \ ['`^', '\hat{${1}}${2}'],
      \ ['`{', '\left\{${1}\right\}${2}'],
      \ ['`~', '\tilde{${1}}${2}'],
      \]

for snippet in b:snipmate_quick_snippets
  call call('QuickSnippet', snippet)
endfor
