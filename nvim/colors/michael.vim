" The base of this colour profile was generated by http://bytefluent.com/vivify 2019-02-19
" Vim color file - michael
" Terminal based colours:
" cterm (Font style), can be the following values:
"    bold
"    underline
"    reverse
"    italic
"    none
" ctermfg - Terminal Foreground colour
" ctermbg - Terminal Background colour
" Refer to cterm_colours.png in current folder

" gui (Font style), can be the following values:
"    bold
"    undercurl
"    underline
"    reverse
"    italic
"    none
" Can be multiple values e.g. 
"    gui=bold,undercurl
" guifg - GUI Foreground colour
" guibg - GUI Background colour
" guisp - GUI underline colour
" Can set to RGB values eg. #FF0000 for red

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "michael"
set background=dark
set t_Co=256

"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Ignore -- no settings --
hi Normal guifg=#ffffff guibg=#192224 guisp=#192224 gui=NONE ctermfg=15 ctermbg=235 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
"hi Question -- no settings --
"hi EnumerationName -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi CTagsClass -- no settings --
"hi clear -- no settings --

" Line Numbers
hi LineNr               guifg=#00CC00 guibg=#3F3F3F " Line number colour
hi CursorLineNr         guifg=#4F4F4F guibg=#00CC00 " Cursor line number colour

" Built in visual enhancements
hi NonText              guifg=#555555 " Hidden characters from set list
hi ColorColumn          guibg=#333333 " 80 chars wide column

" Search and replace
hi QuickFixLine         term=reverse ctermbg=52 guifg=#FF0000
hi IncSearch            guifg=#000000 guibg=#FFFF00 gui=bold " While one is typing search pattern
hi Search               guifg=#000000 guibg=#CF9F00          " Other search matches

"Whitespace
hi wrong_spacing        guibg=#FF0000 " If not a multiple of 4 spaces
hi _TrailingWhitespace  guibg=#880000 " Highlight trailing whitespace

" NERDTree
hi treeDir              guifg=#FF0000 guibg=#00ff00
hi NERDTreeFlags        guifg=#dad085
hi NERDTreeDir          guifg=#dad085
hi NERDTreeDirSlash     guifg=#6b6220
hi NERDTreeClosable     guifg=#444444
hi NERDTreeOpenable     guifg=#444444
hi NERDTreeCWD          guifg=#FF0000 " NERDTree root dir

"=========================================================
"GIT
"This might be for vim diff, notice DiffAdd vs DiffAdded
"hi DiffAdd      gui=bold    guifg=NONE    guibg=#bada9f   "Added line
"hi DiffChange   gui=none    guifg=NONE    guibg=#e5d5ac   "Changed line
"hi DiffDelete   gui=none    guifg=#ff8080 guibg=#ffb0b0   "Delete Line
"hi DiffText     gui=none    guifg=NONE    guibg=#8cbee2   "Changed text within a changed line

" DIFF HEADER
" Example of diff header:
" diffFile          diff --git a/src/base/management/commands/deploy.py b/src/base/management/commands/deploy.py
" diffIndexLine     index d99d485..685cd8a 100755
" diffNewFile       --- a/src/base/management/commands/deploy.py
" diffFile          +++ b/src/base/management/commands/deploy.py
" diffLine          @@ -29,18 +29,22 @@      diffSubname: class Command(BaseCommand):
hi diffIndexLine guifg=#808080
hi diffNewFile guifg=#D0D0D0 gui=BOLD
hi diffFile guifg=#808080
hi diffLine guifg=#808080
hi diffSubname guifg=#D0D0D0
 
hi DiffAdded guifg=#00C000 guibg=BOLD guisp=#193224 gui=BOLD ctermfg=NONE ctermbg=236 cterm=NONE
hi DiffChanged guifg=yellow guibg=BOLD guisp=#492224 gui=BOLD,UNDERCURL ctermfg=NONE ctermbg=52 cterm=NONE
hi DiffRemoved guifg=#F00000 guibg=#192224 guisp=#192224 gui=BOLD ctermfg=NONE ctermbg=235 cterm=NONE

"Probably used for side by side diffs:
"diffOnly
"diffDiffer
"diffBDiffer
"diffIsA
"diffCommon
"diffOldFile
"diffComment


"Status line normal colour, NC = Non Current
hi StatusLine           guifg=#000000 guibg=#00CC00 gui=none " WARNING! By default gui set to reverse, need to overide it with none
hi StatusLineNC         guifg=#192224 guibg=#ababab " Status line None current
hi _StatusFileName      guifg=#000000 guibg=#ABABAB gui=bold
hi _StatusModified      guifg=#FFFFFF guibg=#FF0000 gui=BOLD
hi _StatusGit           guifg=#009900 guibg=#00CC00

" Current line on
hi CursorLine                               guibg=#444444 " The current cursor line highlighting, works!
autocmd InsertLeave * highlight  CursorLine guibg=#4F4F4F " Revert Color to default when leaving Insert Mode, should match colour above
autocmd InsertEnter * highlight  CursorLine guibg=#550000 " Change Color when entering Insert Mode

" Visual Selection
hi Visual guibg=#888888

" Change whole screen background color
"autocmd InsertEnter * highlight Normal guibg=#110000
"autocmd InsertLeave * highlight Normal guibg=black

"Change .CSS attribute font colour
hi StorageClass guifg=#FF6991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold

"DEFAULT NOT USED
"hi SpecialKey guifg=#5E6C70 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
"hi NonText guifg=#5E6C70 guibg=NONE guisp=NONE gui=italic ctermfg=66 ctermbg=NONE cterm=NONE
"hi CursorLine guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
"hi LineNr guifg=#00ff00 guibg=#000000 guisp=#000000 gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
"hi StatusLineNC guifg=#192224 guibg=#ababab guisp=#ababab gui=bold ctermfg=235 ctermbg=248 cterm=bold
"hi StatusLine guifg=#000000 guibg=#00c800 guisp=#00c800 gui=bold ctermfg=NONE ctermbg=40 cterm=bold
"hi StorageClass guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold


hi Typedef guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi WildMenu guifg=NONE guibg=#A1A6A8 guisp=#A1A6A8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi SignColumn guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
hi SpecialComment guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Title guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=bold ctermfg=189 ctermbg=235 cterm=bold
hi Folded guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreCondit guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Include guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#192224 guibg=#00ff00 guisp=#00ff00 gui=bold ctermfg=235 ctermbg=10 cterm=bold
hi ErrorMsg guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi Debug guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Identifier guifg=#ffff00 guibg=NONE guisp=NONE gui=NONE ctermfg=11 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Conditional guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Todo guifg=#F9F9FF guibg=#bd0000 guisp=#bd0000 gui=NONE ctermfg=189 ctermbg=1 cterm=NONE
hi Special guifg=#ffbf00 guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi Label guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi PMenuSel guifg=#000000 guibg=#00c800 guisp=#00c800 gui=NONE ctermfg=NONE ctermbg=40 cterm=NONE
hi Delimiter guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Statement guifg=#ff0000 guibg=NONE guisp=NONE gui=bold ctermfg=196 ctermbg=NONE cterm=bold
hi SpellRare guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Comment guifg=#00ff00 guibg=NONE guisp=NONE ctermfg=10 ctermbg=NONE cterm=NONE " gui=italic TAKEN OUT FOR NOW!!!!
hi Character guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Float guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Number guifg=#00ffff guibg=NONE guisp=NONE gui=bold ctermfg=14 ctermbg=NONE cterm=bold
hi Boolean guifg=#A1A6A8 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Operator guifg=#00ffdd guibg=NONE guisp=NONE gui=bold ctermfg=50 ctermbg=NONE cterm=bold
hi TabLineFill guifg=#000000 guibg=#545454 guisp=#545454 gui=bold ctermfg=NONE ctermbg=240 cterm=bold
hi WarningMsg guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi ModeMsg guifg=#F9F9F9 guibg=#192224 guisp=#192224 gui=bold ctermfg=15 ctermbg=235 cterm=bold
hi Define guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Function guifg=#ffbf00 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold
hi FoldColumn guifg=#192224 guibg=#A1A6A8 guisp=#A1A6A8 gui=italic ctermfg=235 ctermbg=248 cterm=NONE
hi PreProc guifg=#ff80ff guibg=NONE guisp=NONE gui=NONE ctermfg=213 ctermbg=NONE cterm=NONE
hi MoreMsg guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi SpellCap guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi VertSplit guifg=#192224 guibg=#5E6C70 guisp=#5E6C70 gui=bold ctermfg=235 ctermbg=66 cterm=bold
hi Exception guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Keyword guifg=#ff7b00 guibg=NONE guisp=NONE gui=bold ctermfg=208 ctermbg=NONE cterm=bold
hi Type guifg=#ff0000 guibg=NONE guisp=NONE gui=bold ctermfg=196 ctermbg=NONE cterm=bold
hi SpellLocal guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Error guifg=#A1A6A8 guibg=#912C00 guisp=#912C00 gui=NONE ctermfg=248 ctermbg=88 cterm=NONE
hi PMenu guifg=#ffffff guibg=#636363 guisp=#636363 gui=NONE ctermfg=15 ctermbg=241 cterm=NONE
hi Constant guifg=#80ffff guibg=NONE guisp=NONE gui=NONE ctermfg=123 ctermbg=NONE cterm=NONE
hi Tag guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi String guifg=#00ff00 guibg=NONE guisp=NONE gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#ffffff guibg=#d9d9d9 guisp=#d9d9d9 gui=NONE ctermfg=15 ctermbg=253 cterm=NONE
hi MatchParen guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Repeat guifg=#BD9800 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi SpellBad guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi Directory guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Structure guifg=#536991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold
hi Macro guifg=#BD9800 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi Underlined guifg=#F9F9FF guibg=#192224 guisp=#192224 gui=underline ctermfg=189 ctermbg=235 cterm=underline
hi TabLine guifg=#000000 guibg=#ababab guisp=#ababab gui=bold ctermfg=NONE ctermbg=248 cterm=bold
hi cursorim guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE
hi Cursor guifg=#192224 guibg=#F9F9F9 guisp=#F9F9F9 gui=NONE ctermfg=235 ctermbg=15 cterm=NONE
hi CursorColumn guifg=NONE guibg=#222E30 guisp=#222E30 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi VisualNOS guifg=#192224 guibg=#19F9FF guisp=#F9F9FF gui=underline ctermfg=235 ctermbg=189 cterm=underline
