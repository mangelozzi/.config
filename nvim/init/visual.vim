"==============================================================================
" VISUAL APPEARANCE
"==============================================================================
" scheme created using http://bytefluent.com/vivify/
" NOTE If any colors are changed below, they will not take effect
" This file sets the colour scheme to only use colours from it.
" Even if the colours are defined in the file.

set cursorline      " High lights the line number and cusro line
set termguicolors   " Uses highlight-guifg and highlight-guibg, hence 24-bit color
color michael       " Note this resets all highlighting, so much be before others

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------
function MyStatusLine(currentWindow) abort
    " To see a list of formatting items, e.g. %l), see :h statusline
    " The only thing which can be dynamically checked, is whether it is the
    " active window or not, since the status line is recalculated only when
    " switching windows.

    if a:currentWindow
        if &buftype == 'quickfix'
            let col_line   = "%#_qfStatusLine#"
            let col_file   = "%#_qfStatusFile#"
            let col_subtle = "%#_qfStatusSubtle#"
            let col_fade1  = "%#_qfStatusFade1#"
            let col_fade2  = "%#_qfStatusFade2#"
            let col_fade3  = "%#_qfStatusFade3#"
        elseif &buftype ==  'help'
            let col_line   = "%#_helpStatusLine#"
            let col_file   = "%#_helpStatusFile#"
            let col_subtle = "%#_helpStatusSubtle#"
            let col_fade1  = "%#_helpStatusFade1#"
            let col_fade2  = "%#_helpStatusFade2#"
            let col_fade3  = "%#_helpStatusFade3#"
        else
            let col_line   = "%#StatusLine#"
            let col_file   = "%#_StatusFile#"
            let col_subtle = "%#_StatusSubtle#"
            let col_fade1  = "%#_StatusFade1#"
            let col_fade2  = "%#_StatusFade2#"
            let col_fade3  = "%#_StatusFade3#"
        endif
    else
        " If not the current window, then override the colors with gray
        let col_line   = "%#StatusLineNC#"
        let col_file   = "%#_StatusFileNC#"
        let col_subtle = "%#_StatusSubtleNC#"
        let col_fade1  = "%#_StatusFadeNC1#"
        let col_fade2  = "%#_StatusFadeNC2#"
        let col_fade3  = "%#_StatusFadeNC3#"
    endif
    let s = ""
    "let s .= "%*"                                       " Return to default color StatusLine / StatusLineNC
    let s .= col_line
    let s .= " "
    let s .= "%{(&readonly||!&modifiable)?'[R]':''}"    " If readonly file, show [R] instead of filepath
    let s .= "%{&l:modifiable?expand('%:h').'/':''}"    " Show file path head for modifiable files
    let s .= col_fade1."▌".col_fade2."▌".col_fade3."▌"
    let s .= col_file
    let s .= " %t "                                     " filename only no path (Tail)
    let s .= "%#_StatusModified#%{&modified?' +++ ':''}"
    let s .= col_fade3."%{!&modified?'▐':''}".col_fade2."%{!&modified?'▐':''}".col_fade1."%{!&modified?'▐':''}"
    let s .= col_line
    let s .= "%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''}"
    let s .= "%="                                     " Left/Right separator
    if exists('g:loaded_fugitive')
        let s .= col_subtle."%{&l:modifiable ? fugitive#statusline().'   ' : ''}"
    endif
    let s .= col_line
    let s .= "%{&filetype} "
    let s .= "%6l"                                     " Current line number
    let s .= ",%-3c"                                    " Current column number, left aligned 3 characters wide
    let s .= " %P "                                     " Percentage through the file
    return s
endfunction
"set statusline=%!MyStatusLine('Enter')
augroup update_status_line
    autocmd!
    " WinEnter = Required for when a new window created and pops up
    " BufEnter = Required for when switching between existing buffers
    " BufWinEnter = Required when running another quickfix search when one
    "               already exists
    autocmd BufWinEnter,WinEnter,BufEnter * setlocal statusline=%!MyStatusLine(1)
    autocmd WinLeave,BufLeave * setlocal statusline=%!MyStatusLine(0)
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
