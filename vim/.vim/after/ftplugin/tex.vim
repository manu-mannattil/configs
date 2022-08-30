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
setlocal complete+=kspell
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
      \ { 'lhs' : 'jh', 'rhs' : '\gets' },
      \ { 'lhs' : 'jH', 'rhs' : '\Leftarrow' },
      \ { 'lhs' : 'jl', 'rhs' : '\to' },
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
      \ { 'lhs' : 'T',  'rhs' : '^\mathsf{T}' },
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
      \ ['#b', '\mathbb{${1}}${2}'],
      \ ['#B', '\mathbf{${1}}${2}'],
      \ ['#c', '\mathcal{${1}}${2}'],
      \ ['#C', '\mathscr{${1}}${2}'],
      \ ['#d', '\dd{${1}}\,${2}'],
      \ ['#e', '\emph{${1}}${2}'],
      \ ['#m', '\bm{${1}}${2}'],
      \ ['#s', '\mathsf{${1}}${2}'],
      \ ['#t', '^\mathsf{T}'],
      \ ['#<', '\bra{${1}}${2}'],
      \ ['#>', '\ket{${1}}${2}'],
      \ ['#\|', '\braket{${1}}${2}'],
      \ ['#*', '\star'],
      \ ['^' , '^{${1}}${2}'],
      \ ['_' , '_{${1}}${2}'],
      \ ['`(', '\left(${1}\right)${2}'],
      \ ['`-', '\bar{${1}}${2}'],
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

" Function to strip a TeX command.  Consider the following situation
" where you want to just remove the outer \hl{ ... } highlighting.
"
"   \hl{This is \emph{emphasized} and highlighted}.
"
" Regexes won't help here, or you need clunky recursive regexes, e.g.,
" see https://tex.stackexchange.com/q/298019.  Using the TeXStrip
" command defined below, \hl{ ... } can be removed via :TeXStrip hl
function! s:texstrip(cmd)
  let winview = winsaveview()
  let i = 1 " to prevent infinite loops
  while search('\V\\' . a:cmd . '{', 'w') && i <= 1000
    let m = getpos('.')
    " Move to open brace, find matching brace, and then cut
    " to black hole register.
    normal! f{%"_x
    " Move back and delete to open brace.
    call cursor(m[1], m[2])
    normal! "_df{
    let i = i + 1
  endwhile
  call winrestview(winview)
endfunction

command! -nargs=1 TeXStrip silent call s:texstrip(<f-args>)
