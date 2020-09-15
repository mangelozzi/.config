"==============================================================================
" VISUAL APPEARANCE
"==============================================================================
" scheme created using http://bytefluent.com/vivify/
" NOTE If any colors are changed below, they will not take effect
" This file sets the colour scheme to only use colours from it.
" Even if the colours are defined in the file.

"set fillchars=stlnc:.  " None Current divider
set cursorline      " High lights the line number and cusro line
set termguicolors   " Uses highlight-guifg and highlight-guibg, hence 24-bit color
color michael       " Note this resets all highlighting, so much be before others

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------
" If wish to show mode in status like, checkout :h mode()

function GSLC(nr, colour_key) abort
    " GetStatusLineColour
    let activebuffer = (a:nr == win_getid())
    if activebuffer
        if &buftype == 'quickfix'
            let dict = {
                        \'line'   : "%#_qfStatusLine#",
                        \'file'   : "%#_qfStatusFile#",
                        \'subtle' : "%#_qfStatusSubtle#",
                        \'fade1'  : "%#_qfStatusFade1#",
                        \'fade2'  : "%#_qfStatusFade2#",
                        \'fade3'  : "%#_qfStatusFade3#",
                        \'extra'  : "%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''}"}
        elseif &buftype ==  'help'
            let dict = {
                        \'line'   : "%#_helpStatusLine#",
                        \'file'   : "%#_helpStatusFile#",
                        \'subtle' : "%#_helpStatusSubtle#",
                        \'fade1'  : "%#_helpStatusFade1#",
                        \'fade2'  : "%#_helpStatusFade2#",
                        \'fade3'  : "%#_helpStatusFade3#",
                        \'extra'  : ''}
        else
            let dict = {
                        \'line'   : "%#StatusLine#",
                        \'file'   : "%#_StatusFile#",
                        \'subtle' : "%#_StatusSubtle#",
                        \'fade1'  : "%#_StatusFade1#",
                        \'fade2'  : "%#_StatusFade2#",
                        \'fade3'  : "%#_StatusFade3#",
                        \'extra' : ''}
        endif
    else
        " If not the current window, then override the colors with gray
        let dict = {
                    \'line'   : "%#StatusLineNC#",
                    \'file'   : "%#_StatusFileNC#",
                    \'subtle' : "%#_StatusSubtleNC#",
                    \'fade1'  : "%#_StatusFadeNC1#",
                    \'fade2'  : "%#_StatusFadeNC2#",
                    \'fade3'  : "%#_StatusFadeNC3#",
                    \'extra' : ''}
    endif
    return dict[a:colour_key]
endfun
function MyStatusLine() abort
    " To see a list of formatting items, e.g. %l), see :h statusline
    " The only thing which can be dynamically checked, is whether it is the
    " active window or not, since the status line is recalculated only when
    " switching windows.
    "echom "Called Set status, current window: ".a:currentWindow."  ".@%
    let id = win_getid()
    "if a:currentWindow
    let s = ""
    let s .= "%{ 1? '%#_helpStatusFade1#' : '_qfStatusFade2' }#"
    "let s .= "%*"                                       " Return to default color StatusLine / StatusLineNC
    let s .= "%{GSLC(".id.", 'line')}"
    let s .= " "
    let s .= "%{(&readonly||!&modifiable)?'[R]':''}"    " If readonly file, show [R] instead of filepath
    let s .= "%{&l:modifiable?expand('%:h').'/':''}"    " Show file path head for modifiable files
    let s .= GSLC(id, 'fade1')."▌".GSLC(id, 'fade2')."▌".GSLC(id, 'fade3')."▌"
    let s .= GSLC(id, 'file')
    let s .= " %t "                                     " filename only no path (Tail)
    let s .= "%#_StatusModified#%{&modified?' +++ ':''}"
    let s .= GSLC(id, 'fade3')."%{!&modified?'▐':''}".GSLC(id, 'fade2')."%{!&modified?'▐':''}".GSLC(id, 'fade1')."%{!&modified?'▐':''}"
    let s .= GSLC(id, 'line')
    let s .= GSLC(id, 'extra')

    let s .= "%="                                     " Left/Right separator
    if exists('g:loaded_fugitive')
        let s .= GSLC(id, 'subtle')."%{&l:modifiable ? fugitive#statusline().'   ' : ''}"
    endif
    let s .= GSLC(id, 'line')
    let s .= "%{&filetype} "
    let s .= "%6l"                                     " Current line number
    let s .= ",%-3c"                                    " Current column number, left aligned 3 characters wide
    let s .= " %P "                                     " Percentage through the file
    return s
endfunction
function GetInfo()
    if &buftype == "quickfix"
        return string(&buftype)
    else
        return string(&buftype)
    endif
endfunc
function SomeText(nr)
    let activebuffer = a:nr == win_getid()
    let buf_type = &buftype
    return activebuffer."&".buf_type
endfun
function MyStatusLineWrapper() abort
    " win_getid() is type number, e.g. 1002
    " let status_line = MyStatusLine(1)
    " let status_line_NC = MyStatusLine(0)
    " The startup_win_id will stay the same for given window
    let startup_win_id = win_getid()
    let s = winnr()."vs"."%{winnr()}"
    let s = "%{SomeText(".startup_win_id.")} ".startup_win_id." ".win_getid()."vs"."vs%{win_getid()}"."     ".type(win_getid())."   %{GetInfo()}"
    "let s = "%{winnr()==".winnr()." ? ".status_line.":".status_line_NC."}"
    "echo s
    return s
endfun
function Debugsl() abort
    let status_line = MyStatusLine(1)
    let status_line_NC = MyStatusLine(0)
    "echo status_line
endfun
":set statusline=%!MyStatusLineWrapper(win_getid())
set statusline=%!MyStatusLine()
"let &l:statusline=MyStatusLine()
function! Setwindowstatues()
    let current_win = winnr()
    for nr in range(1,winnr("$"))
        setlocal statusline=%!MyStatusLine(0) | redrawstatus!
    endfor
endfun
augroup update_status_line
    autocmd!
    " WinEnter = Required for when a new window created and pops up
    " BufEnter = Required for when switching between existing buffers
    " BufWinEnter = Required when running another quickfix search when one
    "               already exists
    "autocmd BufWinEnter,WinEnter,BufEnter * setlocal statusline=%!MyStatusLine(1)
    "autocmd BufLeave * setlocal statusline=%!MyStatusLine(0)
    "autocmd BufLeave * setlocal statusline=%!MyStatusLineWrapper() | redrawstatus!
    "autocmd BufLeave * echom "BuffLeave: ".&filetype." ".@%
    "autocmd BufEnter * setlocal statusline=%!MyStatusLineWrapper()

    "autocmd BufEnter * echom Debugsl()

    "autocmd WinLeave,BufLeave * setlocal statusline=%!MyStatusLine(0)
    "autocmd BufWinEnter,WinEnter * setlocal statusline=%!MyStatusLine(1)
    "autocmd BufWinLeave,WinLeave * setlocal statusline=%!MyStatusLine(0)
augroup END

"==============================================================================
"HIGHLIGHTING
"Color for the below matches is in the michael color scheme

" LEADING SPACES NOT %4
" From the start of line, look for any number of 4 spaces
" Then match 1 to 3 spaces, selected with \za to \ze, then a none whitespace character
"match _WrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/

" TRAILING WHITESPACE
" Must escape the plus, match one or more space before the end of line
" match trailing whitespace, except when typing at the end of a line.
match _TrailingWhitespace /\s\+\%#\@<!$/

augroup match_whitespace
    autocmd!
    autocmd FileType *.py,*.js setlocal match _WrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
augroup END

" https://www.youtube.com/watch?v=aHm36-na4-4
" If a line goes over 80 char wide highlight it
" This permanently sets a column coloured
" highlight ColorColumn ctermbg=magentadd
" set colorcolumn=81

"==============================================================================
" Colour column
" This only colour the column if it goes over 80 chars
set cc=
set cc=80
"hi ColorColumn ctermbg=lightgrey guibg=yellow <- Set in color michael
" -10 here is the priority of the colour vs other things like search
"  highlighting
"call matchadd('ColorColumn', '\%81v', -10)
"call matchadd('ColorColumn', '\%>80v', 100)

" Show white space chars. extends and precedes is for when word wrap is off
"Get shapes from here https://www.copypastecharacter.com/graphic-shapes
set listchars=eol:$,tab:▒▒,trail:▪,extends:▶,precedes:◀,space:·
