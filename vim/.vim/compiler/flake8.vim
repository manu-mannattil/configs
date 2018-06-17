" Vim compiler file
" Compiler: flake8

if exists('current_compiler')
  finish
endif
let current_compiler = 'flake8'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=flake8\ %
CompilerSet errorformat=%E%f:%l:\ could\ not\ compile,
                       \%-Z%p^,
                       \%A%f:%l:%c:\ %t%n\ %m,
                       \%A%f:%l:\ %t%n\ %m,
                       \%-G%.%#

let &cpo = s:save_cpo
unlet s:save_cpo
