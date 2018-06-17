" Vim filetype plugin file
" Language: mail

runtime! ftplugin/text.vim
setlocal spell

" Allows reformatting quoted paragraphs starting with `|'.
setlocal comments+=n:\\|

function! s:clean()
  let winview = winsaveview()

  " We need this because when replying to a message without a subject, Mutt
  " uses `Re: your mail' as the subject.  Now, this is fine if you're using
  " sensible email clients that group messages according to the Message ID
  " and/or References.  But Gmail groups messages according to their subject
  " lines instead of the Message ID, and a lot of people (unfortunately) still
  " use Gmail's web interface.  So we need to change `Re: your mail' to just
  " `Re:'.
  silent %s/^Subject: Re: your mail$/Subject: Re:/e

  " Remove zero-width space, right-to-left mark, left-to-right mark, and
  " nonbreaking space that so many email clients spew without restriction.
  silent %s/\(\%u200b\|\%u200f\|\%u200e\|\%u00a0\)//ge

  call winrestview(winview)
endfunction
autocmd BufWinEnter <buffer> call s:clean()

" Delete quoted text.  The regex must be tweaked according to the value of
" the `attribution' option in Mutt.
nnoremap <buffer> <silent> dq :/.*said on \(Sun\\|Mon\\|Tue\\|Wed\\|Thu\\|Fri\\|Sat\),.* \d\{2\}, \d\{4\} at .*[-+]\d\+:/,$delete<CR>
