" Vim filetype plugin file
" Language: LaTeX

runtime! abbrev.vim

setlocal autochdir
setlocal keywordprg=:Sdcv
setlocal spell

" Files to ignore and give less priority.
setlocal wildignore+=*.Notes.bib,*.acn,*.acr,*.alg,*.aux,*.bcf,*.blg,*.dvi,*.fdb_latexmk,*.fls,*.glg,*.glo,*.gls,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.maf,*.mtc,*.mtc0,*.nav,*.nlo,*.out,*.pdfsync,*.ps,*.run.xml,*.snm,*.synctex.gz,*.synctex.gz(busy),*.tdo,*.toc,*.vrb,*.xdy
setlocal suffixes+=*.bbl,*.sty,*.bst,*.cls

let b:longlines_keep_maps = 1

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
      \ { 'lhs' : 'A',  'rhs' : '\forall' },
      \ { 'lhs' : 'E',  'rhs' : '\exists' },
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
      \ { 'lhs' : 'vq', 'rhs' : '\vartheta' },
      \ { 'lhs' : 'vr', 'rhs' : '\varrho' },
      \ { 'lhs' : g:vimtex_imaps_leader,
      \   'rhs' : repeat(g:vimtex_imaps_leader, 2),
      \   'wrapper' : 'vimtex#imaps#wrap_trivial'},
      \]

for item in b:vimtex_imaps_list
  call vimtex#imaps#add_map(item)
endfor

" Quick snippets using my fork of snipmate.
inoremap <buffer> <silent> #b <ESC>:call QuickSnippet('\mathbb{${1}}${2}')<CR>i
inoremap <buffer> <silent> #c <ESC>:call QuickSnippet('\mathcal{${1}}${2}')<CR>i
inoremap <buffer> <silent> ^ <ESC>:call QuickSnippet('^{${1}}${2}')<CR>i
inoremap <buffer> <silent> _ <ESC>:call QuickSnippet('_{${1}}${2}')<CR>i
inoremap <buffer> <silent> `( <ESC>:call QuickSnippet('\left(${1}\right)${2}')<CR>i
inoremap <buffer> <silent> `/ <ESC>:call QuickSnippet('\frac{${1}}{${2}}${3}')<CR>i
inoremap <buffer> <silent> `2 <ESC>:call QuickSnippet('\sqrt{${1}}${2}')<CR>i
inoremap <buffer> <silent> `[ <ESC>:call QuickSnippet('\left[${1}\right]${2}')<CR>i
inoremap <buffer> <silent> `^ <ESC>:call QuickSnippet('\hat{${1}}${2}')<CR>i
inoremap <buffer> <silent> `{ <ESC>:call QuickSnippet('\left\{${1}\right\}${2}')<CR>i
inoremap <buffer> <silent> `~ <ESC>:call QuickSnippet('\tilde{${1}}${2}')<CR>i
