" Vim compiler file
" Compiler: badprose (https://github.com/manu-mannattil/scripts)

if exists('current_compiler')
  finish
endif
let current_compiler = 'badprose'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=badprose\ %
CompilerSet errorformat=%f:%l:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo
