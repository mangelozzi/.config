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
" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
function MyStatusLine(currentWindow)
    let s = ""
    let s .= "%{&l:modifiable?expand('%:h').'/':''}"    " Show file path head for modifiable files
    let s .= "%{(&readonly||!&modifiable)?'[R]':''}"    " If readonly file, show [R] instead of filepath
    if a:currentWindow
        let s .= "%#_StatusFileName#"                   " Change to StatusFileName highlighting
    else
        let s .= "%#_StatusFileNameNC#"                 " Change to StatusFileNameNC highlighting
    endif
    let s .= " %t "                                     " filename only no path (Tail)
    let s .= "%*"                                       " Return to default color StatusLine / StatusLineNC
    let s .= "%#_StatusModified#%{&modified?' +++ ':''}%*"
    let s .= " %= "                                     " Left/Right separator
    if exists('g:loaded_fugitive')
        if a:currentWindow
            let s .= "%*%#_StatusGit#%{&l:modifiable ? fugitive#statusline() : ''}%*"
        else
            let s .= "%*%#_StatusGitNC#%{&l:modifiable ? fugitive#statusline() : ''}%*"
        endif
    endif
    let s .= " %6l"                                     " Current line number
    let s .= ",%-3c"                                    " Current column number, left aligned 3 characters wide
    let s .= " %P "                                     " Percentage through the file
    return s
endfunction
"set statusline=%!MyStatusLine('Enter')
autocmd BufWinEnter,WinEnter * setlocal statusline=%!MyStatusLine(1)
autocmd WinLeave * setlocal statusline=%!MyStatusLine(0)

"==============================================================================
"HIGHLIGHTING
"Color for the below matches is in the michael color scheme

" LEADING SPACES NOT %4
" From the start of line, look for any number of 4 spaces
" Then match 1 to 3 spaces, selected with \za to \ze, then a none whitespace character
"match wrong_spacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
autocmd FileType *.py,*.js setlocal match wrong_spacing /\(^\(    \)*\)\zs \{1,3}\ze\S/

" TRAILING WHITESPACE
" Must escape the plus, match one or more space before the end of line
" match trailing whitespace, except when typing at the end of a line.
match _TrailingWhitespace /\s\+\%#\@<!$/
" autocmd FileType *.py,*.js setlocal 2match trailing_whitespace /\s\+$/

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
