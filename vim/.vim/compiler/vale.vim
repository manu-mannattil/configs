" Vim compiler file
" Compiler: vale <https://github.com/errata-ai/vale>

if exists('current_compiler')
  finish
endif
let current_compiler = 'vale'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=vale\ --output\ line\ %
CompilerSet errorformat=%f:%l:%c:%m

let &cpo = s:save_cpo
unlet s:save_cpo
