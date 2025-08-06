" Author:     Kim Silkebækken
" Upstream:   https://github.com/Lokaltog/vim-distinguished
" Changes:    1. Removed all bold attributes.
"             2. Tweaked colors of statuslines and vertical splits.
"             3. Comments now have same background color as normal text.
"             4. Low-contrast cursorcolumn, cursorline, colorcolumn,
"                nontext, etc.
"             5. Removed all mismatches between terminal and gui colors.
"             6. Added more hi links.

set background=dark

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'distinguished'

" Bail out if we cannot have all colors.
if !has('gui_running') && &t_Co != 256
  finish
endif

" Color dictionary parser.
function! s:ColorDictParser(color_dict)
  for [group, group_colors] in items(a:color_dict)
    exec 'hi ' . group
      \ . ' ctermfg=' . (group_colors[0] == '' ? 'NONE' :       group_colors[0])
      \ . ' ctermbg=' . (group_colors[1] == '' ? 'NONE' :       group_colors[1])
      \ . '   cterm=' . (group_colors[2] == '' ? 'NONE' :       group_colors[2])
      \
      \ . '   guifg=' . (group_colors[3] == '' ? 'NONE' : '#' . group_colors[3])
      \ . '   guibg=' . (group_colors[4] == '' ? 'NONE' : '#' . group_colors[4])
      \ . '     gui=' . (group_colors[5] == '' ? 'NONE' :       group_colors[5])
  endfor
endfunction

"    | Highlight group                |  CTFG |  CTBG |    CTAttributes | || |   GUIFG |    GUIBG |   GUIAttributes |
"    |--------------------------------|-------|-------|-----------------| || |---------|----------|-----------------|
call s:ColorDictParser({
  \   'Normal'                      : [    231,     16,               '',      'ffffff',  '000000',               '']
  \ , 'Visual'                      : [    240,    253,               '',      '585858',  'dadada',               '']
  \
  \ , 'Conceal'                     : [    231,    237,               '',      'ffffff',  '3a3a3a',               '']
  \ , 'Cursor'                      : [     '',     '',               '',      'ffffff',  'dd4010',               '']
  \ , 'lCursor'                     : [     '',     '',               '',      'ffffff',  '89b6e2',               '']
  \
  \ , 'CursorLine'                  : [    '',     235,               '',            '',  '262626',               '']
  \ , 'CursorLineNr'                : [    253,    238,               '',      'dadada',  '444444',               '']
  \ , 'CursorColumn'                : [    '',     234,               '',            '',  '1c1c1c',               '']
  \
  \ , 'Folded'                      : [    249,    234,               '',      'b2b2b2',  '1c1c1c',               '']
  \ , 'FoldColumn'                  : [    243,    234,               '',      '767676',  '1c1c1c',               '']
  \ , 'SignColumn'                  : [    231,    233,               '',      'ffffff',  '121212',               '']
  \ , 'ColorColumn'                 : [      '',   235,               '',            '',  '262626',               '']
  \
  \ , 'StatusLine'                  : [    232,     65,               '',      '080808',  '5f875f',               '']
  \ , 'StatusLineNC'                : [    235,    242,               '',      '262626',  '6c6c6c',               '']
  \
  \ , 'LineNr'                      : [    240,    234,               '',      '585858',  '1c1c1c',               '']
  \ , 'VertSplit'                   : [    242,    242,               '',      '6c6c6c',  '6c6c6c',               '']
  \
  \ , 'WildMenu'                    : [    234,    231,               '',      '1c1c1c',  'ffffff',               '']
  \ , 'Directory'                   : [    143,     '',               '',      'afaf5f',        '',               '']
  \ , 'Underlined'                  : [    130,     '',               '',      'af5f00',        '',               '']
  \
  \ , 'Question'                    : [     74,     '',               '',      '5fafd7',        '',               '']
  \ , 'MoreMsg'                     : [    214,     '',               '',      'ffaf00',        '',               '']
  \ , 'WarningMsg'                  : [    202,     '',               '',      'ff5f00',        '',               '']
  \ , 'ErrorMsg'                    : [    196,     '',               '',      'ff0000',        '',               '']
  \
  \ , 'Comment'                     : [    242,     '',               '',      '6c6c6c',        '',               '']
  \ , 'vimCommentTitleLeader'       : [    250,     '',               '',      'bcbcbc',        '',               '']
  \ , 'vimCommentTitle'             : [    250,     '',               '',      'bcbcbc',        '',               '']
  \ , 'vimCommentString'            : [    245,     '',               '',      '8a8a8a',        '',               '']
  \
  \ , 'TabLine'                     : [    231,    238,               '',      'ffffff',  '444444',               '']
  \ , 'TabLineSel'                  : [    255,     '',               '',      'eeeeee',        '',               '']
  \ , 'TabLineFill'                 : [    240,    238,               '',      '585858',  '444444',               '']
  \ , 'TabLineNumber'               : [    160,    238,               '',      'd70000',  '444444',               '']
  \ , 'TabLineClose'                : [    245,    238,               '',      '8a8a8a',  '444444',               '']
  \
  \ , 'SpellCap'                    : [    231,     31,               '',      'ffffff',  '0087af',               '']
  \
  \ , 'SpecialKey'                  : [    239,     '',               '',      '4e4e4e',        '',               '']
  \ , 'NonText'                     : [    236,     '',               '',      '303030',        '',               '']
  \ , 'MatchParen'                  : [    231,     25,               '',      'ffffff',  '005faf',               '']
  \
  \ , 'Constant'                    : [    137,     '',               '',      'af875f',        '',               '']
  \ , 'Special'                     : [    150,     '',               '',      'afd787',        '',               '']
  \ , 'Identifier'                  : [     66,     '',               '',      '5f8787',        '',               '']
  \ , 'Statement'                   : [    186,     '',               '',      'd7d787',        '',               '']
  \ , 'PreProc'                     : [    247,     '',               '',      '9e9e9e',        '',               '']
  \ , 'Type'                        : [     67,     '',               '',      '5f87af',        '',               '']
  \ , 'String'                      : [    143,     '',               '',      'afaf5f',        '',               '']
  \ , 'Number'                      : [    173,     '',               '',      'd7875f',        '',               '']
  \ , 'Define'                      : [    173,     '',               '',      'd7875f',        '',               '']
  \ , 'Error'                       : [    208,    124,               '',      'ff8700',  'af0000',               '']
  \ , 'Function'                    : [    179,     '',               '',      'd7af5f',        '',               '']
  \ , 'Include'                     : [    173,     '',               '',      'd7875f',        '',               '']
  \ , 'PreCondit'                   : [    173,     '',               '',      'd7875f',        '',               '']
  \ , 'Keyword'                     : [    173,     '',               '',      'd7875f',        '',               '']
  \ , 'Search'                      : [    232,     101,              '',      '080808',  '87875f',               '']
  \ , 'Title'                       : [    231,     '',               '',      'ffffff',        '',               '']
  \ , 'Delimiter'                   : [    246,     '',               '',      '949494',        '',               '']
  \ , 'StorageClass'                : [    187,     '',               '',      'd7d7af',        '',               '']
  \ , 'Operator'                    : [    180,     '',               '',      'd7af87',        '',               '']
  \
  \ , 'TODO'                        : [    228,     94,               '',      'ffff87',  '875f00',               '']
  \
  \ , 'SyntasticWarning'            : [    220,     94,               '',      'ffd700',  '875f00',               '']
  \ , 'SyntasticError'              : [    202,     52,               '',      'ff5f00',  '5f0000',               '']
  \
  \ , 'Pmenu'                       : [    250,    235,               '',      'bcbcbc',  '262626',               '']
  \ , 'PmenuSel'                    : [    255,    238,               '',      'eeeeee',  '444444',               '']
  \ , 'PmenuSbar'                   : [    255,    238,               '',      'eeeeee',  '444444',               '']
  \ , 'PmenuThumb'                  : [    255,    250,               '',      'eeeeee',  'bcbcbc',               '']
  \
  \ , 'phpEOL'                      : [    245,     '',               '',      '8a8a8a',        '',               '']
  \ , 'phpStringDelim'              : [     94,     '',               '',      '875f00',        '',               '']
  \ , 'phpDelimiter'                : [    160,     '',               '',      'd70000',        '',               '']
  \ , 'phpFunctions'                : [    221,     '',               '',      'ffd75f',        '',               '']
  \ , 'phpBoolean'                  : [    172,     '',               '',      'd78700',        '',               '']
  \ , 'phpOperator'                 : [    215,     '',               '',      'ffaf5f',        '',               '']
  \ , 'phpMemberSelector'           : [    138,     '',               '',      'af8787',        '',               '']
  \ , 'phpParent'                   : [    227,     '',               '',      'ffff5f',        '',               '']
  \
  \ , 'PHPClassTag'                 : [    253,     '',               '',      'dadada',        '',               '']
  \ , 'PHPInterfaceTag'             : [    253,     '',               '',      'dadada',        '',               '']
  \ , 'PHPFunctionTag'              : [    222,     '',               '',      'ffd787',        '',               '']
  \
  \ , 'pythonDocString'             : [    240,    233,               '',      '585858',  '121212',               '']
  \ , 'pythonDocStringTitle'        : [    245,    233,               '',      '8a8a8a',  '121212',               '']
  \ , 'pythonRun'                   : [     65,     '',               '',      '5f875f',        '',               '']
  \ , 'pythonBuiltinObj'            : [     67,     '',               '',      '5f87af',        '',               '']
  \ , 'pythonSelf'                  : [    250,     '',               '',      'bcbcbc',        '',               '']
  \ , 'pythonFunction'              : [    179,     '',               '',      'd7af5f',        '',               '']
  \ , 'pythonClass'                 : [    221,     '',               '',      'ffd75f',        '',               '']
  \ , 'pythonExClass'               : [    130,     '',               '',      'af5f00',        '',               '']
  \ , 'pythonException'             : [    130,     '',               '',      'af5f00',        '',               '']
  \ , 'pythonOperator'              : [    186,     '',               '',      'd7d787',        '',               '']
  \ , 'pythonPreCondit'             : [    152,     '',               '',      'afd7d7',        '',               '']
  \ , 'pythonDottedName'            : [    166,     '',               '',      'd75f00',        '',               '']
  \ , 'pythonDecorator'             : [    124,     '',               '',      'af0000',        '',               '']
  \
  \ , 'PythonInterfaceTag'          : [    109,     '',               '',      '87afaf',        '',               '']
  \ , 'PythonClassTag'              : [    221,     '',               '',      'ffd75f',        '',               '']
  \ , 'PythonFunctionTag'           : [    109,     '',               '',      '87afaf',        '',               '']
  \ , 'PythonVariableTag'           : [    253,     '',               '',      'dadada',        '',               '']
  \ , 'PythonMemberTag'             : [    145,     '',               '',      'afafaf',        '',               '']
  \
  \ , 'CTagsImport'                 : [    109,     '',               '',      '87afaf',        '',               '']
  \ , 'CTagsClass'                  : [    221,     '',               '',      'ffd75f',        '',               '']
  \ , 'CTagsFunction'               : [    109,     '',               '',      '87afaf',        '',               '']
  \ , 'CTagsGlobalVariable'         : [    253,     '',               '',      'dadada',        '',               '']
  \ , 'CTagsMember'                 : [    145,     '',               '',      'afafaf',        '',               '']
  \
  \ , 'xmlTag'                      : [    149,     '',               '',      'afd75f',        '',               '']
  \ , 'xmlTagName'                  : [    250,     '',               '',      'bcbcbc',        '',               '']
  \ , 'xmlEndTag'                   : [    209,     '',               '',      'ff875f',        '',               '']
  \
  \ , 'cssImportant'                : [    166,     '',               '',      'd75f00',        '',               '']
  \
  \ , 'DiffAdd'                     : [    112,     22,               '',      '87d700',  '005f00',               '']
  \ , 'DiffChange'                  : [    220,     94,               '',      'ffd700',  '875f00',               '']
  \ , 'DiffDelete'                  : [    160,     '',               '',      'd70000',        '',               '']
  \ , 'DiffText'                    : [    220,     94,        'reverse',      'ffd700',  '875f00',        'reverse']
  \
  \ , 'diffLine'                    : [     68,     '',               '',      '5f87d7',        '',               '']
  \ , 'diffFile'                    : [    242,     '',               '',      '6c6c6c',        '',               '']
  \ , 'diffNewFile'                 : [    242,     '',               '',      '6c6c6c',        '',               '']
\ })

hi link htmlArg                  htmlTagName
hi link htmlBold                 Normal
hi link htmlEndTag               xmlEndTag
hi link htmlItalic               Normal
hi link htmlLink                 Function
hi link htmlSpecialTagName       htmlTagName
hi link htmlTag                  xmlTag
hi link htmlTagName              xmlTagName

hi link diffAdded                DiffAdd
hi link diffBDiffer              WarningMsg
hi link diffChanged              DiffChange
hi link diffCommon               WarningMsg
hi link diffDiffer               WarningMsg
hi link diffIdentical            WarningMsg
hi link diffIsA                  WarningMsg
hi link diffNoEOL                WarningMsg
hi link diffOnly                 WarningMsg
hi link diffRemoved              DiffDelete

hi link asciidocQuotedEmphasized Preproc
hi link Boolean                  Constant
hi link Character                Constant
hi link Conditional              Statement
hi link Debug                    Special
hi link Exception                Statement
hi link Float                    Number
hi link HelpCommand              Statement
hi link HelpExample              Statement
hi link Label                    Statement
hi link Macro                    PreProc
hi link markdownItalic           Preproc
hi link QuickFixLine             Search
hi link Repeat                   Statement
hi link Structure                Type
hi link Tag                      Special
hi link Terminal                 Normal

let g:terminal_ansi_colors = [
      \ '#0f0f0f',
      \ '#af5f5f',
      \ '#5f875f',
      \ '#87875f',
      \ '#5f87af',
      \ '#5f5f87',
      \ '#5f8787',
      \ '#6c6c6c',
      \ '#2c2c2c',
      \ '#ff8700',
      \ '#87af87',
      \ '#d7d787',
      \ '#8fafd7',
      \ '#8787af',
      \ '#5fafaf',
      \ '#ffffff',
      \ ]
