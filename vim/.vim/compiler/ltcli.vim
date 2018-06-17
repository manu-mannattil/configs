" Vim compiler file
" Compiler: ltcli (https://github.com/manu-mannattil/scripts)

if exists('current_compiler')
  finish
endif
let current_compiler = 'ltcli'

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=ltcli\ %
CompilerSet errorformat=%f:%l:%c:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo
