" Vim compiler file
" Compiler: ChkTeX (http://www.nongnu.org/chktex/)

if exists('current_compiler')
  finish
endif
let current_compiler = 'chktex'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=chktex\ %
CompilerSet errorformat=%EError\ %n\ in\ %f\ line\ %l:\ %m,
                       \%WWarning\ %n\ in\ %f\ line\ %l:\ %m,
                       \%WMessage\ %n\ in\ %f\ line\ %l:\ %m,
                       \%Z%p^,
                       \%-G%.%#

let &cpo = s:save_cpo
unlet s:save_cpo
