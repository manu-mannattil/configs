" vim: ft=vim fdm=marker et sts=2 sw=2

" GUI configuration {{{1
" ----------------------

" Font: Comano
" set guifont=Comano\ 8
" set linespace=2

" Font: Fira Mono
" set guifont=Fira\ Mono\ Regular\ 9
" set linespace=0

" Font: Source Code Pro
set guifont=Source\ Code\ Pro\ Semibold\ 9
set linespace=0

" Font: Terminus
" set guifont=Terminus\ 9
" set linespace=3

" Disable popups.
set guioptions+=c

" Always hide left scroll bar (even in split windows).
set guioptions-=L

" Always hide tool bar
set guioptions-=T

" Always hide menu bar.
set guioptions-=m

" Always hide right scroll bar.
set guioptions-=r

" Don't blink the cursor.
set guicursor+=a:blinkon0

" Initial window size.
set lines=42 columns=95

" Enable mouse.
set mouse=a

" Hide cursor when typing.
set mousehide

" Ask longlines to not remap keys in the GUI.  We need this for +/- increase of
" font size.
let g:longlines_keep_maps = 1

" Functions {{{1
" --------------

" Function to increase and decrease GUI font size on the fly.
" Pieced together from the function at Vim Wikia:
" http://vim.wikia.com/wiki/Change_font_size_quickly
function! s:guifontsize(amount) abort
  if has('gui_gtk') && has('gui_running')
    let fontname = substitute(&guifont, '^\(.* \)\([1-9][0-9]*\)$', '\1', '')
    let cursize = substitute(&guifont, '^\(.* \)\([1-9][0-9]*\)$', '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= 6) && (newsize <= 16)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
  endif
endfunction

" Ideally I would like to have <c--> to decrease the font size and <c-=>
" to increase it.  But for some reason, mapping them doesn't work.  So
" we compromise:
" + (plus) to increase GUI font size
" _ (underscore) to decrease GUI font size
nnoremap <silent> _ :call <SID>guifontsize(-1)<CR>
nnoremap <silent> + :call <SID>guifontsize(+1)<CR>
