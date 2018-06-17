" Vim compiler file
" Compiler: lacheck

if exists('current_compiler')
  finish
endif
let current_compiler = 'lacheck'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=lacheck\ %
CompilerSet errorformat="%f",\ line\ %l:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo
