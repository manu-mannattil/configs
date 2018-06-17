" Vim filetype plugin file
" Language: reStructuredText

runtime! ftplugin/text.vim

" From $VIMRUNTIME/compiler/rst.vim
setlocal errorformat=%f:%l:\ (%tEBUG/0)\ %m,
                    \%f:%l:\ (%tNFO/1)\ %m,
                    \%f:%l:\ (%tARNING/2)\ %m,
                    \%f:%l:\ (%tRROR/3)\ %m,
                    \%f:%l:\ (%tEVERE/3)\ %m,
                    \%D%*\\a[%*\\d]:\ Entering\ directory\ `%f',
                    \%X%*\\a[%*\\d]:\ Leaving\ directory\ `%f',
                    \%DMaking\ %*\\a\ in\ %f

setlocal makeprg=rst2pseudoxml\ --report=2\ %\ /dev/null
