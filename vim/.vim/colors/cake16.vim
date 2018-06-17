" Upstream: https://github.com/zefei/cake16
" Changes: 1. GUI only.
"          2. Solid grey vertical split.
"          3. White background color.

if !has('gui_running')
  finish
endif

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="cake16"
set background=light

" General Colors
hi Normal guifg=#454545 guibg=#f7f7f7 gui=none
hi Comment guifg=#878787 guibg=NONE gui=none
hi Constant guifg=#b95942 guibg=NONE gui=none
hi Identifier guifg=#308444 guibg=NONE gui=none
hi Statement guifg=#308090 guibg=NONE gui=none
hi PreProc guifg=#308090 guibg=NONE gui=none
hi Type guifg=#308444 guibg=NONE gui=none
hi Special guifg=#b95942 guibg=NONE gui=none

" Text Markup
hi Underlined guifg=NONE guibg=NONE gui=underline
hi Error guifg=#f10000 guibg=NONE gui=none
hi Todo guifg=#f10000 guibg=NONE gui=none
hi MatchParen guifg=fg guibg=#afafaf gui=none
hi NonText guifg=#878787 guibg=NONE gui=none
hi SpecialKey guifg=#878787 guibg=NONE gui=none
hi Title guifg=#b95942 guibg=NONE gui=none

" Text Selection
hi CursorIM guifg=bg guibg=fg gui=none
hi CursorColumn guifg=NONE guibg=#e4e4e4 gui=none
hi CursorLine guifg=NONE guibg=#e4e4e4 gui=none
hi Visual guifg=bg guibg=#82a3b3 gui=none
hi VisualNOS guifg=NONE guibg=NONE gui=underline
hi IncSearch guifg=bg guibg=#82a3b3 gui=none
hi Search guifg=bg guibg=#c79747 gui=none

" UI
hi LineNr guifg=#afafaf guibg=bg gui=none
hi CursorLineNr guifg=fg guibg=#e4e4e4 gui=none
hi Pmenu guifg=bg guibg=#878787 gui=none
hi PmenuSel guifg=bg guibg=#82a3b3 gui=none
hi PMenuSbar guifg=#878787 guibg=#878787 gui=none
hi PMenuThumb guifg=#afafaf guibg=#afafaf gui=none
hi StatusLine guifg=bg guibg=#678797 gui=none
hi StatusLineNC guifg=bg guibg=#afafaf gui=none
hi TabLine guifg=bg guibg=#878787 gui=none
hi TabLineFill guifg=bg guibg=#878787 gui=none
hi TabLineSel guifg=fg guibg=bg gui=none
hi VertSplit guifg=#afafaf guibg=#afafaf gui=none
hi Folded guifg=#afafaf guibg=NONE gui=none
hi FoldColumn guifg=#afafaf guibg=NONE gui=none

" Spelling
hi SpellBad guisp=#f10000 gui=undercurl
hi SpellCap guisp=#f10000 gui=undercurl
hi SpellRare guisp=#f10000 gui=undercurl
hi SpellLocal guisp=#f10000 gui=undercurl

" Diff
hi DiffAdd guifg=bg guibg=#308444 gui=none
hi DiffChange guifg=bg guibg=#c79747 gui=none
hi DiffDelete guifg=bg guibg=#b95942 gui=none
hi DiffText guifg=bg guibg=fg gui=none

" Misc
hi Directory guifg=fg guibg=NONE gui=none
hi ErrorMsg guifg=#f10000 guibg=NONE gui=none
hi SignColumn guifg=#678797 guibg=NONE gui=none
hi MoreMsg guifg=#878787 guibg=NONE gui=none
hi ModeMsg guifg=fg guibg=NONE gui=none
hi Question guifg=fg guibg=NONE gui=none
hi WarningMsg guifg=#b95942 guibg=NONE gui=none
hi WildMenu guifg=#50707e guibg=#e4dccc gui=none
hi ColorColumn guifg=NONE guibg=#e4e4e4 gui=none
hi Ignore guifg=bg
