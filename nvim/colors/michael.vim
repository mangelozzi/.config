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

hi IncSearch            guifg=#000000 guibg=#FFFF00 gui=bold " While one is typing search pattern
hi Search               guifg=#000000 guibg=#CF9F00          " Other search matches

" Current line on
hi CursorLine                               guibg=#444444 " The current cursor line highlighting, works!
augroup mytheme_insert_enter
    autocmd!
    autocmd InsertEnter * hi CursorLine guibg=#550000   " Change Color when entering Insert Mode
augroup END
augroup mytheme_insert_leave
    autocmd!
    autocmd InsertLeave * hi CursorLine guibg=#4F4F4F   " Revert Color to default when leaving Insert Mode, should match colour above
augroup END


" Search and replace
hi _qfNormal            guifg=#ffffff guibg=#333300     " Override default Normal
hi  QuickFixLine        guifg=#ffff00 gui=bold          " The last quick entry browsed to
hi _qfCursorLine        guibg=#676700 gui=bold          " The current cursor line highlighting, works!
hi _qfLineNr            guifg=#ffff00 guibg=#444400     " Line number colour
hi _qfCursorLineNr      guifg=#000000 guibg=#cccc00     " Cursor line number colour
hi qfFileName           guifg=#FF0000 gui=bold
hi qfLineNr             guifg=#FFFF00
hi qfSeparator          guifg=#000000

"Whitespace
hi _WrongSpacing        guibg=#FF0000 " If not a multiple of 4 spaces
hi _TrailingWhitespace  guibg=#880000 " Highlight trailing whitespace

" NERDTree
hi treeDir              guifg=#FF0000 guibg=#00ff00
hi NERDTreeFlags        guifg=#dad085
hi NERDTreeDir          guifg=#dad085
hi NERDTreeDirSlash     guifg=#6b6220
hi NERDTreeClosable     guifg=#444444
hi NERDTreeOpenable     guifg=#444444
hi NERDTreeCWD          guifg=#FF0000 " NERDTree root dir

"Status line normal colour, NC = Non Current
hi _StatusModified      guibg=#FF0000 guifg=#FFFFFF gui=BOLD
hi qfError              guibg=#FF0000 guifg=#FFFFFF gui=BOLD

hi StatusLine           guibg=#00A000 guifg=#202020 gui=none " WARNING! By default gui set to reverse, need to overide it with none
hi _StatusFade1         guibg=#00B000 guifg=#00A800
hi _StatusFade2         guibg=#00C000 guifg=#00B800
hi _StatusFade3         guibg=#00D000 guifg=#00C800
hi _StatusFile          guibg=#00FF00 guifg=#000000 gui=bold
hi _StatusSubtle        guibg=#00A000 guifg=#007700

hi StatusLineNC         guibg=#777777 guifg=#000000 gui=none " Status line None current
hi _StatusFadeNC1       guibg=#808080 guifg=#7B7B7B
hi _StatusFadeNC2       guibg=#909090 guifg=#888888
hi _StatusFadeNC3       guibg=#A0A0A0 guifg=#989898
hi _StatusFileNC        guibg=#ABABAB guifg=#000000 gui=bold
hi _StatusSubtleNC      guibg=#777777 guifg=#444444

hi _qfStatusLine        guibg=#C0C000 guifg=#000000 gui=none " WARNING! By default gui set to reverse, need to overide it with none
hi _qfStatusFade1       guibg=#D0D000 guifg=#C8C800
hi _qfStatusFade2       guibg=#E0E000 guifg=#D8D800
hi _qfStatusFade3       guibg=#F0F000 guifg=#E8E800
hi _qfStatusFile        guibg=#FFFF00 guifg=#000000 gui=bold
hi _qfStatusLineNC      guibg=#777700 guifg=#ffff00
hi _qfStatusSublte      guibg=#00A000 guifg=#007700

hi _helpStatusLine      guibg=#A000E0 guifg=#000000
hi _helpStatusFade1     guibg=#B000E8 guifg=#A800E4
hi _helpStatusFade2     guibg=#C000F0 guifg=#B800EA
hi _helpStatusFade3     guibg=#E000F8 guifg=#D000F4
hi _helpStatusFile      guibg=#FF00FF guifg=#000000 gui=bold
hi _helpStatusLineNC    guibg=#770077 guifg=#ff00ff
hi _helpStatusSublte    guibg=#0000A0 guifg=#000077

" Visual Selection
hi Visual guibg=#888888

" Change whole screen background color
"autocmd InsertEnter * highlight Normal guibg=#110000
"autocmd InsertLeave * highlight Normal guibg=black

"Change .CSS attribute font colour
hi StorageClass guifg=#FF6991 guibg=NONE guisp=NONE gui=bold ctermfg=60 ctermbg=NONE cterm=bold

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
