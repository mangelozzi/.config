" {{{1 TITLE
" See a descriptive list of highlight groups with:
"       :help highlight-groups
"
" The base of this colour profile was generated by http://bytefluent.com/vivify 2019-02-19
" Can see a well formatted list of highlight groups with:
"     :so $VIMRUNTIME/syntax/hitest.vim
"
" Refer to :highlight-groups for an explanation of each group
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
"       bold
"       underline
"       undercurl	curly underline
"       strikethrough
"       reverse
"       inverse		same as reverse
"       italic
"       standout
"       nocombine	override attributes instead of combining them
"       NONE		no attributes used (used to reset it)
"
" Can be multiple values e.g.
"    gui=bold,undercurl
" guifg - GUI Foreground colour
" guibg - GUI Background colour
" guisp - GUI underline colour
" Can set to RGB values eg. #FF0000 for red
"
" Can link one group to another with:
"     hi link my_custom_hi Normal

" {{{1 THEME SETTINGS
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "michael"
set background=dark
set t_Co=256

" {{{1 Normal
"hi Normal guifg=#ffffff guibg=#192224 guisp=#192224 gui=NONE ctermfg=15 ctermbg=235 cterm=NONE
hi Normal   guifg=#808080 guibg=#ffffff
hi NormalNC guifg=#808080 guibg=#ffffff

" {{{1 Line Numbers
hi LineNr               guifg=#b0b0b0 guibg=#F0F0F0 " Line number colour
"hi LineNrNC             guifg=#FFCC00 guibg=#3F3F3F " Line number colour
hi CursorLineNr         guifg=#4F4F4F guibg=#00CC00 gui=bold " Cursor line number colour
hi SignColumn                         guibg=#000000 " To the left of number line

" {{{1 Built in visual enhancements
hi NonText              guifg=#555555               " Hidden characters from set list
hi ColorColumn                        guibg=#333333 " 80 chars wide column
hi CursorColumn         guifg=NONE    guibg=#181818 " A vertical line that follows custor, enable with :set cursorcolumn
hi IncSearch            guifg=#000000 guibg=#FFFF00 gui=bold " While one is typing search pattern
hi Search               guifg=#000000 guibg=#CF9F00          " Other search matches

" {{{1 Cursor Line
hi CursorLine                         guibg=#f0f0f0 " The current cursor line highlighting, works!
augroup mytheme_cursorline
    autocmd!
    autocmd InsertEnter * hi CursorLine guibg=#ffe0e0 " Change Color when entering Insert Mode
    autocmd InsertLeave * hi CursorLine guibg=#f0f0f0 " Revert Color to default when leaving Insert Mode, should match colour above
augroup END

" {{{1 Whitespace
hi _WrongSpacing                      guibg=#FF0000 " If not a multiple of 4 spaces
hi _TrailingWhitespace                guibg=#880000 " Highlight trailing whitespace

" {{{1 Folds
hi Folded               guifg=#000050 guibg=#f1f8ff gui=italic
hi FoldColumn           guifg=#000050 guibg=#f1f8ff gui=bold
hi _FoldLevel1          guifg=#000050 guibg=#f1f8ff guisp=#FFFFFF gui=bold,italic,underline
hi _FoldLevel2          guifg=#000050 guibg=#f1f8ff guisp=#FFFFFF gui=bold,italic,underline

" {{{1 Status line
"StatusLine = Normal Colour of the active bar, and NC = Non Current
hi _StatusModified      guifg=#FFFFFF guibg=#FF0000 gui=BOLD
hi qfError              guifg=#FFFFFF guibg=#FF0000 gui=BOLD

hi StatusLine           guifg=#202020 guibg=#00A000 gui=none " WARNING! By default gui set to reverse, need to overide it with none
hi _StatusFade1         guifg=#00A800 guibg=#00B000
hi _StatusFade2         guifg=#00B800 guibg=#00C000
hi _StatusFade3         guifg=#00C800 guibg=#00D000
hi _StatusFile          guifg=#000000 guibg=#00FF00 gui=bold
hi _StatusSubtle        guifg=#007700 guibg=#00A000

hi StatusLineNC         guifg=#000000 guibg=#777777 gui=none " Status line None current
hi _StatusFadeNC1       guifg=#7B7B7B guibg=#808080
hi _StatusFadeNC2       guifg=#888888 guibg=#909090
hi _StatusFadeNC3       guifg=#989898 guibg=#A0A0A0
hi _StatusFileNC        guifg=#000000 guibg=#ABABAB gui=bold
hi _StatusSubtleNC      guifg=#444444 guibg=#777777

hi _qfStatusLine        guifg=#000000 guibg=#C0C000 gui=none " WARNING! By default gui set to reverse, need to overide it with none
hi _qfStatusFade1       guifg=#C8C800 guibg=#D0D000
hi _qfStatusFade2       guifg=#D8D800 guibg=#E0E000
hi _qfStatusFade3       guifg=#E8E800 guibg=#F0F000
hi _qfStatusFile        guifg=#000000 guibg=#FFFF00 gui=bold
hi _qfStatusLineNC      guifg=#ffff00 guibg=#777700
hi _qfStatusSublte      guifg=#007700 guibg=#00A000

hi _helpStatusLine      guifg=#000000 guibg=#A000E0
hi _helpStatusFade1     guifg=#A800E4 guibg=#B000E8
hi _helpStatusFade2     guifg=#B800EA guibg=#C000F0
hi _helpStatusFade3     guifg=#D000F4 guibg=#E000F8
hi _helpStatusFile      guifg=#000000 guibg=#FF00FF gui=bold
hi _helpStatusLineNC    guifg=#ff00ff guibg=#770077
hi _helpStatusSublte    guifg=#000077 guibg=#0000A0

" {{{1 DIFFs (GIT)
if &diff
endif
" This might be for vim diff, notice DiffAdd vs DiffAdded
hi DiffAdd      guibg=#e6ffed " Added line
hi DiffDelete   guifg=#ff4254 guibg=#ffeef0 " Delete Line
hi DiffText     guibg=#ffff00 " Changed text within a changed line
hi DiffChange   guibg=#ffffe5 " Changed line

" DIFF HEADER
" Example of diff header:
" diffFile          diff --git a/src/base/management/commands/deploy.py b/src/base/management/commands/deploy.py
" diffIndexLine     index d99d485..685cd8a 100755
" diffNewFile       --- a/src/base/management/commands/deploy.py
" diffFile          +++ b/src/base/management/commands/deploy.py
" diffLine          @@ -29,18 +29,22 @@      diffSubname: class Command(BaseCommand):
hi diffIndexLine        guifg=#808080
hi diffNewFile          guifg=#D0D0D0 gui=BOLD
hi diffFile             guifg=#808080
hi diffLine             guifg=#808080
hi diffSubname          guifg=#D0D0D0

hi! link DiffAdded   DiffAdd
hi! link DiffChanged DiffChange
hi! link DiffRemoved DiffDelete

"Probably used for side by side diffs:
"diffOnly
"diffDiffer
"diffBDiffer
"diffIsA
"diffCommon
"diffOldFile
"diffComment

" {{{1 TABS
hi TabLineSel           guifg=#192224 guibg=#00A000 gui=bold " Currently selected tab
hi TabLine              guifg=#000000 guibg=#ababab gui=bold " Not selected tab
hi TabLineFill                        guibg=#333333 gui=none " Tab line

" {{{1 Spelling
hi SpellBad                           guibg=#700000 guisp=#FF0000 gui=bold,undercurl " Not recognised by spell checker
hi SpellCap                           guibg=#700000 guisp=#FF0000 gui=bold,undercurl " Word that should start with a capital
hi SpellLocal                         guibg=#700000 guisp=#FF0000 gui=bold,undercurl " Word that is used in another region
hi SpellRare                          guibg=#700000 guisp=#FF0000 gui=bold,undercurl " Word that is hardly ever used

" {{{1 MISC
" TODO example
hi Todo                 guifg=#FFFFFF guibg=#0044FF   " TODO within a comment (at line start)
hi StorageClass         guifg=#FF6991 guibg=NONE guisp=NONE gui=bold " Change .CSS attribute font colour
hi Visual                             guibg=#888888 " Visual Selection
" If not reversed:
"   FG = Other   Parenthesis BG
"   BG = Current parenthesis FG
hi MatchParen           guifg=#00FF00 guibg=#550000           gui=bold

" {{{1 WILDMENU
hi Directory            guifg=#FFFF00 guibg=NONE guisp=NONE gui=bold
hi WildMenu             guifg=#000000 guibg=#00FF00 " Current match in 'wildmenu' completion

" {{{1 DEFAULT LANUAGE HI ITEMS
hi Comment              guifg=#004b15
hi Identifier           guifg=#ff " function, print, end
hi Constant             guifg=#71000d " 1 'Hello'
hi Statement            guifg=#74007d " if not local return for in then
hi Type                 guifg=#000000, gui=none " {}
hi PreProc              guifg=#000000 " bold
hi Special              guifg=#a35800 " <leader> <C-U> etc
hi Title                guifg=#008e9f " <leader> <C-U> etc