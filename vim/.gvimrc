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
set lines=40 columns=100

" Enable mouse.
set mouse=a

" Follow the mouse to focus on a window.
set mousefocus

" Hide cursor when typing.
set mousehide

" Functions {{{1
" --------------

" Function to increase and decrease GUI font size on the fly.
" Pieced together from the function at Vim Wikia:
" http://vim.wikia.com/wiki/Change_font_size_quickly
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
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
nnoremap _ :call AdjustFontSize(-1)<cr>
nnoremap + :call AdjustFontSize(+1)<cr>
