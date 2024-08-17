" vim: ft=vim fdm=marker et sts=2 sw=2

" Preamble {{{1
" -------------

" Enable the filetype plugin.
filetype plugin indent on

" Switch on syntax highlighting.
syntax enable

if !has('packages')
  " Use pathogen to load plugins if I'm using an old version Vim.
  execute pathogen#infect('pack/bundle/start/{}')
  execute pathogen#infect('pack/opt-git/start/{}')
  execute pathogen#infect('pack/opt/start/{}')
else
  command! -bar Helptags :call pathogen#helptags()
endif

" Character encoding of text used *inside* Vim (e.g., the text in buffers).
" Tweak this according your terminal emulator's needs.  We're setting this
" right in the preamble because sometimes Vim fails to understand the encoding
" of 'listchars' and 'fillchars' if the encoding is not seen before those
" options.  I first noticed this issue with a version of Vim from Nix.
set encoding=utf-8

" Settings {{{1
" -------------

" Appearance and interface {{{2
" -----------------------------

" Highlight the column after the `textwidth' column.  (May make things slow.)
set colorcolumn=+1

" Options for insert-mode completion.
set completeopt=longest,menuone

" Don't select any completions by default.
set completeopt+=noinsert

" Highlight/underline the current line.  (May make things slow.)
set cursorline

" If the last line in the current window is longer than the column width,
" truncate it and append @@@.
set display=lastline

" Read .vimrc, .exrc and .gvimrc in the current directory (if there are any).
set exrc

" Prettier Unicode borders while splitting windows vertically.
" set fillchars+=vert:│
set fillchars+=vert:║

" Marker as the foldmethod works consistently for *all* files.
set foldmethod=marker

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" Always show status bar under a window.  By default it's only shown if there's
" more than one window.
set laststatus=2

" Don't redraw the screen when macros, registers, and other commands that
" haven't been typed by the user are running.
set lazyredraw

" Prettier markers for non-printing characters such as tab, trailing
" spaces, end of line, etc.
set listchars=tab:→\ ,trail:·,eol:¬,extends:…,precedes:…

" Characters that form match highlight pairs (for matchit.vim).
set matchpairs=(:),{:},[:],<:>

" If possible, enable mouse support in all modes.
set mouse=a

" Show line numbers.
set number

" Determines the maximum number of items to show in the popup menu for
" insert mode completion.
set pumheight=12

" Show the line number relative to the line with the cursor in front of each
" line.
set relativenumber

" Prefix long wrapped lines by an indicator string.
let &showbreak = '» '

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Disable welcome message.
set shortmess+=I

" More informative, yet minimalistic statusline.
set statusline=[%n]\ %t\ [%{&ff}\|%{strlen(&fenc)?&fenc:&enc}\|%{strlen(&ft)?&ft:'none'}]\ %m%q%r%w
set statusline+=%=%<L:%l/%L,C:%c\ (%P)

" Ignore common binary files during completion.  Alternatively, use the
" 'suffixes' option to give these extensions a low priority while doing tab
" completion.  To ignore directories, append a '/' to the pattern.
" NOTE: A downside is that insert mode file name completions using
" CTRL-X_CTRL-F will also get affected (see :WildToggle).
set wildignore+=*~,*.7z,*.aac,*.anx,*.asf,*.au,*.avi,*.axa,*.axv,*.bmp,*.bz,*.bz2,*.cgm,*.class,*.com,*.deb,*.djvu,.directory,*.dl,*.dll,*.dmg,*.doc,*.docx,*.dot,*.dotx,.DS_Store,*.dvi,ehthumbs.db,*.emf,*.eps,*.exe,*.fla,*.flac,*.flc,*.fli,*.flv,.fuse_hidden*,*.gif,.git/,*.gl,*.gnumeric,*.gz,.hg/,*.ipynb,*.iso,*.jar,*.jpeg,*.jpg,latex.out/,*.m2v,*.m4a,*.m4v,__MACOSX/,*.maff,*.mid,*.midi,*.mka,*.mkv,*.mng,*.mov,*.mp3,*.mp4,*.mp4v,*.mpa,*.mpc,*.mpeg,*.mpg,*.nb,*.nuv,*.o,*.odt,*.oga,*.ogg,*.ogm,*.ogv,*.ogx,*.pcx,*.pdf,*.png,*.pps,*.ppsx,*.ppt,*.pptx,*.ps,*.psd,*.pyc,*.qt,*.ra,*.rar,*.rm,*.rmvb,*.rpm,*.rtf,*.so,.Spotlight-V100,*.spx,*.sql,*.sqlite,*.svg,*.svgz,*.swf,tags,*.tar,*.tar.gz,*.tga,*.tgz,Thumbs.db,*.tif,*.tiff,*.torrent,.Trash-*/,.Trashes,*.vob,*.wav,*.webm,*.wmv,*.xbm,*.xcf,*.xls,*.xlsx,*.xpm,*.xspf,*.xwd,*.yuv,*.zip

" Ignore case while completing file names and directories.
set wildignorecase

" Enable fancy completion in command-line mode.
set wildmenu

" List all matches and complete first match.
set wildmode=list:full

" These options change how text is displayed.  They don't alter the actual text
" in the buffer, but only affect how it's displayed on the screen.  The text is
" soft-wrapped to fit the editor window without breaking up words.
set wrap
set linebreak

" Colors {{{2
" -----------

" If the `distinguished' colorscheme isn't available, don't
" bother with a colorscheme.
try
  colorscheme distinguished
catch /^Vim\%((\a\+)\)\=:E185/
  set background=dark
  syntax off
endtry

" Highlight `bad' words so that they *always* stand out boldly.
if has('gui_running') || &t_Co >= 256
  hi SpellBad   ctermfg=255 ctermbg=124 guifg=#eeeeee guibg=#af0000 cterm=underline gui=undercurl
  hi SpellCap   ctermfg=255 ctermbg=90  guifg=#eeeeee guibg=#870087 cterm=underline gui=undercurl
  hi SpellLocal ctermfg=232 ctermbg=72  guifg=#080808 guibg=#5faf87 cterm=underline gui=undercurl
  hi SpellRare  ctermfg=232 ctermbg=215 guifg=#080808 guibg=#ffaf5f cterm=underline gui=undercurl
else
  hi SpellBad   ctermfg=white ctermbg=darkred    cterm=underline
  hi SpellCap   ctermfg=white ctermbg=darkblue   cterm=underline
  hi SpellLocal ctermfg=white ctermbg=darkgreen  cterm=underline
  hi SpellRare  ctermfg=white ctermbg=darkyellow cterm=underline
endif

" Editing {{{2
" ------------

" Copy indent from current line when starting a new line.
set autoindent

" Make backspacing more intuitive by allowing to backspace over everything in
" insert mode.
set backspace=indent,eol,start

" Specifies how insert mode completion works when CTRL-P or CTRL-N are used in
" terms of flags.  Note that *only* CTRL-P and CTRL-N follow these rules.  In
" particular, i_CTRL-X_CTRL-N and i_CTRL-X_CTRL-P don't follow these rules.
set complete=.,w,b,u,t,i,kspell

" Optimize diffs for readability rather than speed.
" https://vimways.org/2018/the-power-of-diff/
set diffopt+=internal,algorithm:patience,indent-heuristic,iwhiteall

" Encoding of file *on disk*.  When 'fileencoding' is different from
" 'encoding', conversion will be done when writing the file.
set fileencoding=utf-8

" Auto insert comment leader and join comments intelligently.
set formatoptions+=rj

" Put single letter words on the next line when formatting.
set formatoptions+=1

" Disable autowrapping of text (code is considered as text).
set formatoptions-=t

" Adjust the case of the match in insert-mode completion according to the case
" of the typed text when ignorecase is also set.
set infercase

" Do not recognize octal numbers for Ctrl-A and Ctrl-X.  Without this using
" CTRL-A on '007' results in '010'.
set nrformats-=octal

" Always report the number of lines changed when using ':' commands,
" irrespective of the actual number of lines changed.
set report=0

" Insert tabs in front of a line inserts according to 'shiftwidth'.  'tabstop'
" or 'softtabstop' is used in other places.  A backspace will delete
" a 'shiftwidth' worth of space at the start of the line.
set smarttab

" We're all living in Amerika, Amerika ist wunderbar!
set spelllang=en_us,in

" Text wrapping width in columns.
set textwidth=100

" The time in milliseconds that is waited for a key code or mapped key sequence
" to complete.  Normally only 'timeoutlen' is used and 'ttimeoutlen' is -1.
" When a different timeout value for key codes is desired set 'ttimeoutlen' to
" a value >=0.
"
" A large timeout of 1000ms for key mappings.  If mappings take more than
" this time to type, they won't get executed.
set timeoutlen=1000
"
" No timeout for key codes.
set ttimeoutlen=0

" In visual mode, allow the cursor to positioned where there is no actual
" character (this can be halfway into a tab or beyond the end of the line).
set virtualedit=block

" File recovery, backups, etc. {{{2
" ---------------------------------

" Write the contents of the file, if it has been modified, on each :next,
" :make, :previous, etc., and also when a :buffer, CTRL-O, CTRL-I, '{A-Z0-9},
" or `{A-Z0-9} command takes one to another file.
set autowrite

" Vim stores the things you change in a swap file which helps in recovery.
" Swap files are stored separately in 'directory'.  A // at the end of
" 'directory' makes Vim use full paths of files while naming swapfiles, thus
" helping to avoid collisions.
set swapfile
set directory^=~/.cache/vim/swap//

" Delete old backups and backup the current file.  See 'backup-table' for more.
" Also store all backup files in a separate directory.
set backup
set nowritebackup
set backupdir^=~/.cache/vim/backup/

" Don't keep backups for common temporary files.  Also skip /dev/shm/* which is
" used by some programs (e.g., pass) to securely read/write temporary files.
set backupskip+=$TMPDIR/*,$TMP/*,$TEMP/*,/dev/shm/*

" Use the improved Blowfish cipher for encryption using :X.  (However, you
" shouldn't be using Vim to encrypt files.)
set cryptmethod=blowfish2

" How many `:' commands, and previous search patterns ought to be remembered.
set history=500

" Enable setting options locally using modelines.
set modeline

" Use persistent undo with 5000 levels of changes.  Also store all
" undofiles in a separate directory.
set undodir^=~/.cache/vim/undo/
set undofile
set undolevels=5000

" The viminfo file can be used to restore the state of the editor
" partially when re-editing a file.
set viminfo='100,<50,s10,h,n~/.cache/vim/viminfo

" Movement {{{2
" -------------

" A sentence has to be followed by two spaces after the '.', '!' or '?'.  This
" way periods used to shorten words (e.g., Ms., Mr., etc.) are skipped when
" using ( ) sentence motion.
set cpoptions+=J

" Ignore case while searching.
set ignorecase

" Show search matches as you type and highlight the nearest (forward) match.
set incsearch

" Keep cursor in the same column (if possible) when using CTRL-D, CTRL-U,
" CTRL-B, CTRL-F, 'G', 'H', 'M', 'L', gg, etc.
set nostartofline

" Start scrolling when there are only 2 lines left.
set scrolloff=2

" Override ignorecase if search contains upper case characters.  (Note that
" ignorecase must be set along with this.)
set smartcase

" Allow l, h, <Right>, and <Left> to move to the previous/next line when the
" cursor is on the first/last character in the line.
set whichwrap+=l,h,>,<

" Tabs and spaces {{{2
" --------------------

" Insert spaces instead of tabs.
" https://www.youtube.com/watch?v=SsoOG6ZeyUI
set expandtab

" Round indent to multiple of 'shiftwidth'.
set shiftround

" Number of space to use while indenting.  A value of zero tells Vim to use the
" 'tabstop' value.  But since that breaks some (old) indent plugins, we set it
" explicitly.
set shiftwidth=2

" Number of spaces that a <Tab> counts for while performing editing operations,
" like inserting a <Tab> or using <BS>.
set softtabstop=2

" An actual tab character in the buffer should be shown as 8 spaces as usual.
set tabstop=8

" Windows and buffers {{{2
" ------------------------

" Hide buffers (i.e., keep them in the memory) instead of prompting to save.
set hidden

" Put the new window below the current one when splitting horizontally.
set splitbelow

" Put the new window to the right of the current one when splitting vertically.
set splitright

" Autocommands {{{1
" -----------------

" File type related.
augroup ft_related
  autocmd!

  autocmd BufRead,BufNewFile *.bibtex set filetype=bib
  autocmd BufRead,BufNewFile *.conf set filetype=conf
  autocmd BufRead,BufNewFile *.fold set filetype=json
  autocmd BufRead,BufNewFile *.gp,*.plt set filetype=gnuplot
  autocmd BufRead,BufNewFile *.md,*.mkd set filetype=markdown
  autocmd BufRead,BufNewFile *.pdf_tex set filetype=tex
  autocmd BufRead,BufNewFile *.rkt,*.rktl set filetype=scheme
  autocmd BufRead,BufNewFile *.vcf set filetype=vcard
  autocmd BufRead,BufNewFile COPYING,INSTALL,LICENSE,README,[Rr]eadme set filetype=text

  " .m files are Mathematica files.  Who uses Matlab these days?
  autocmd BufRead,BufNewFile *.m,*.wl,*.wls set filetype=mma

  " Detect files edited with fc(1) (e.g., the file that you edit after pressing
  " <esc>v in Bash's Vi mode).
  autocmd BufRead,BufNewFile /tmp/bash-fc-* set filetype=sh

  " For "files" edited with vidir, assume that the underscore is a word
  " boundary.
  autocmd BufRead,BufNewFile /tmp/dir* setlocal iskeyword-=_

  " Detect files starting with #!/bin/dash, #!/bin/posh files as sh.
  autocmd BufRead,BufNewFile *
        \ if getline(1) =~ '#!.*\/\(da\|po\)sh$'                              |
        \   set filetype=sh                                                   |
        \ endif

  " Detect files starting with MathematicaScript, WolframScript, etc. as
  " Mathematica files.
  autocmd BufRead,BufNewFile *
        \ if getline(1) =~? '#!.*\(MathematicaScript\|WolframScript\).*$'     |
        \   set filetype=mma                                                  |
        \ endif

  autocmd BufRead,BufNewFile \*sdcv\* set filetype=sdcv

  " Enable the longlines plugin for TeX and MediaWiki files.
  autocmd FileType mail,mediawiki LongLines | setlocal norelativenumber
augroup END

" Miscellaneous.
augroup misc
  autocmd!

  " After opening files move to the last position; adapted from defaults.vim.
  autocmd BufReadPost *
        \ if line('''"') >= 1 && line('''"') <= line("$") && &ft !~# 'commit' |
        \   execute 'normal g`"'                                              |
        \ endif

  " Resize windows (i.e., splits) when the main Vim window is resized.
  autocmd VimResized * wincmd =

  " If the only window open contains the quickfix list, delete that buffer.
  autocmd WinEnter *
        \ if winnr('$') == 1 && &buftype == "quickfix"                        |
        \   bdelete!                                                          |
        \ endif
augroup END

" Show the current line only in the active window.
augroup cursor_line
  autocmd!
  autocmd VimEnter,BufWinEnter,WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Highlight TODO keywords everywhere.  Default syntax files don't always
" contain all the TODO keywords. https://stackoverflow.com/a/30552423
augroup hl_todo
    autocmd!
    autocmd Syntax *
          \ syntax keyword generalTodo TODO FIXME XXX NOTE NOTES COMMENT COMMENTS
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link generalTodo Todo

" Disable spell checking when editing password entries using pass(1).
augroup pass_entries
  autocmd!
  autocmd BufRead,BufNewFile /dev/shm/*.txt set nospell
augroup END

" Automatically open the quickfix window/location list when they're populated.
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" Commands {{{1
" -------------

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, and thus, the changes you made.  This is especially
" useful when using vidir(1).
" Adapted from: https://www.reddit.com/r/vim/comments/4ouh89/d4fx3iq
command! -nargs=0 DiffOrig
      \ vertical new                                                          |
      \ setlocal buftype=nofile                                               |
      \ setlocal bufhidden=wipe                                               |
      \ setlocal noswapfile                                                   |
      \ read #                                                                |
      \ 0delete _                                                             |
      \ let &filetype = getbufvar('#', '&filetype')                           |
      \ execute 'autocmd BufWipeout <buffer> diffoff!'                        |
      \ diffthis                                                              |
      \ wincmd p                                                              |
      \ diffthis

" WildToggle is a command to toggle the 'wildignore' option.  This is
" especially useful to complete filenames in insert mode (using CRTL-X_CTRL-F).
command! -nargs=0 WildToggle
      \ if exists('b:wildignore')                                             |
      \   let &l:wildignore = b:wildignore                                    |
      \   unlet b:wildignore                                                  |
      \   echo "wildignore on"                                                |
      \ else                                                                  |
      \   let b:wildignore = &l:wildignore                                    |
      \   setlocal wildignore&                                                |
      \   echo "wildignore off"                                               |
      \ endif

" Run mkprg and open the QuickFix window.
command! -nargs=* Make silent make! <args> | silent redraw! | cwindow
command! -nargs=* LMake silent lmake! <args> | silent redraw! | lwindow

" Titlecase the range.  Requires the Python module titlecase.
if executable('titlecase')
  command! -range TitleCase <line1>,<line2>!titlecase
endif

" Command to run helptags on all plugin directories in ~/.vim.
function! s:helptags() abort
  for dir in split(&rtp, ',')
    if dir[0:strlen($VIM)-1] !=# $VIM && isdirectory(dir.'/doc')
      helptags `=dir.'/doc'`
    endif
  endfor
endfunction

" For now, use the version supplied by vim-pathogen.
" command! -bar Helptags call s:helptags()

" Grep {{{2
" ---------

" Use ag for grepping.
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Function to run grep in a subshell.
" Adapted from https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! s:rungrep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

" Commands to populate the quickfix/location list with the output of s:rungrep().
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr s:rungrep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr s:rungrep(<f-args>)

" Hack to replace :grep and :lgrep with :Grep and :LGrep, respectively.
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" Mappings {{{1
" -------------

" ,$ strips trailing spaces.
function! s:rm_trailing_spaces() abort
  let winview = winsaveview()
  %substitute/\s\+$//e
  call winrestview(winview)
endfunction
nnoremap <silent> ,$ :call <SID>rm_trailing_spaces()<CR>

" Toggle search highlighting, spelling etc.
nnoremap <silent> ,h :set list!<CR>
nnoremap <silent> ,l :noh<CR>
nnoremap <silent> ,n :LongLines<CR>
nnoremap <silent> ,s :set spell!<CR>

" Make Y behave like C and D (and not yy).
noremap Y y$

" More intuitive window navigation.
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Reselect the visual area after changing indent in visual mode.
vnoremap < <gv
vnoremap > >gv

" Center next/previous search results.
nnoremap n nzz
nnoremap N Nzz

" Don't use Ex mode and use Q for formatting.
noremap Q gw

" Set 'typical' textwidths faster.
nnoremap <silent> ,6 :set textwidth=60<CR>
nnoremap <silent> ,7 :set textwidth=72<CR>
nnoremap <silent> ,8 :set textwidth=79<CR>
nnoremap <silent> ,0 :set textwidth=100<CR>

" Select last pasted/yanked/changed text.
nnoremap gp '[v']

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break the undo
" sequence, so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Correct the last misspelled word using the first suggestion.
inoremap <C-L> <C-G>u<ESC>[s1z=`]a<C-G>u

" Emacs-like mapping to evaluate visually selected region as Vim script.
vnoremap <C-X><C-E> <ESC>:@*<CR>

" Search for visually selected text using / in visual mode.  While doing so do
" (almost) non-regex searches.
vnoremap / <ESC>/\V<C-R>*<CR>

" Move around the changelist with ,d (backwards) and ,u (forwards).
noremap ,u g,
noremap ,d g;

" Change to the `alternate' file using backspace.
nnoremap <BS> <C-^>

" Fix broken 'gx' in netrw.
" https://github.com/felipec/vim-sanegx
function! s:gxbrowse(url)
  let redir = '>&/dev/null'
  if exists('g:netrw_browsex_viewer')
    let viewer = g:netrw_browsex_viewer
  elseif has('unix') && executable('xdg-open')
    let viewer = 'xdg-open'
  elseif has('macunix') && executable('open')
    let viewer = 'open'
  elseif has('win64') || has('win32')
    let viewer = 'start'
    redir = '>null'
  else
    return
  endif

  execute 'silent! !' . viewer . ' ' . shellescape(a:url, 1) . redir
  redraw!
endfunction
nnoremap <silent> gx :call <SID>gxbrowse(expand('<cWORD>'))<CR>

" File and buffer navigation tricks {{{2
" --------------------------------------

" Find files under the current directory recursively.
" (Equivalent to ,E and ,vE if 'autochdir' is set.)
nnoremap ,e :edit <C-R>=expand('%:p:h').'/**/*'<CR>
nnoremap ,pe :split <C-R>=expand('%:p:h').'/**/*'<CR>
nnoremap ,ve :vsplit <C-R>=expand('%:p:h').'/**/*'<CR>

" Find files under the directory of the current file recursively.
nnoremap ,E :edit **/*
nnoremap ,pE :split **/*
nnoremap ,vE :vsplit **/*

nnoremap ,b :buffer *
nnoremap ,pb :sbuffer *
nnoremap ,vb :vertical sbuffer *
nnoremap ,B :ls<CR>:buffer<Space>
nnoremap ,pB :ls<CR>:sbuffer<Space>
nnoremap ,vB :ls<CR>:vertical sbuffer<Space>

augroup leftright
  autocmd!

  " Switch between buffers using left/right arrow keys.
  nnoremap <silent> <right> :bnext<CR>
  nnoremap <silent> <left>  :bprev<CR>

  " The above mapping isn't useful in many filetypes, but since there's no way
  " to unmap a mapping on a per-buffer basis, we re-remap it here.
  autocmd FileType help,qf,sdcv
        \ nnoremap <buffer> <left> <left>                                     |
        \ nnoremap <buffer> <right> <right>
augroup END

" Plugin settings {{{1
" --------------------

" Default ftplugins {{{2
" ----------------------

" Disable syntax error checking in POSIX sh, bash, etc.
let g:sh_no_error = 1

" gnupg.vim {{{2
" --------------

" Prefer pipes to temporary files for GPG operations.
let g:GPGUsePipes = 1

" I'm the default GPG recipient.
let g:GPGDefaultRecipients = ['0x9D5931F4']

" netrw {{{2
" ----------

" Tree-like listing for netrw.
let g:netrw_liststyle = 3

" open is my basic wrapper script around xdg-open.
let g:netrw_browsex_viewer = 'open'
let g:netrw_http_cmd = 'open'

" Vimtex {{{2
" -----------

" Use qpdfview (with instance name `LaTeX') as the PDF viewer.
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--instance LaTeX --unique @pdf\#src:@tex:@line:@col'

" Don't open quickfix on mere warnings.
let g:vimtex_quickfix_open_on_warning = 0

" Disable recursive searching of included packages.
let g:vimtex_include_search_enabled = 0

" Enable folding using Vimtex's foldexpr function.
let g:vimtex_fold_enabled = 1

" But only compute fold levels on demand, i.e., use fdm=manual.  To force
" update the fold level, reload the file or use 'zx'.
let g:vimtex_fold_manual = 1

" Disable folding for certain parts of the document.
let g:vimtex_fold_types = {
      \ 'cmd_single': {'enabled': 0},
      \ 'envs': {'enabled': 0},
      \}

" Disable some vimtex mappings. E.g., K in normal mode is more useful to run
" keywordprg than texdoc.
let g:vimtex_mappings_disable = {
      \ 'n': ['K'],
      \ }

" Don't show these errors/warnings in the quickfix.
let g:vimtex_quickfix_ignore_filters = [
      \ 'float is stuck',
      \ 'float specifier',
      \ 'LastBibItem',
      \ 'Overfull',
      \ 'Underfull',
      \ 'xcolor Warning',
      \ ]

" The bibunits package uses \defaultbibliograph{...} to include .bib files.
let g:vimtex_bibliography_commands = ['%(default|no)?bibliography', 'add%(bibresource|globalbib|sectionbib)']

" Disable folding of BiBTeX entries.
let g:vimtex_fold_bib_enabled = 0

" Remove all default imaps.  (Note that this is different from setting
" g:vimtex_imaps_enabled = 0, in which case the imaps functionality will be
" completely disabled.)
let g:vimtex_imaps_list = []

" Others {{{2
" -----------

" Filter sdcv's output using my AWK script.
let g:sdcv_filter = 'sdcv-prettify'

" Custom arguments to be passed to sdcv.
let g:sdcv_args = ['--utf8-input', '--utf8-output']

" Conceal certain elements in Wolfram/Mathematica source.
let g:mma_candy = 1
