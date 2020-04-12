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

"==============================================================================
" STATUS LINE

" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
function MyStatusLine(mode)
    if a:mode == 'Enter'
        echo "enter"
    endif
    let l:s = ''
    "let l:s .=  g:statusline_winid . "=" . win_getid() ."  END "
    let l:s .= &l:modifiable ? '%{expand("%:h")}'.'/' : ''  " Show file path head
    let l:s .= '%#_StatusFileName#'                       " Change to StatusLineNC highlighting
    let l:s .= ' %t '                                     " filename only no path (Tail)
    let l:s .= '%*'                                       " Return to default color StatusLine / StatusLineNC
    if &modified
        let l:s .= '%#_StatusModified#[+++]%*'            " Modified
    elseif &l:modifiable
        let l:s .= ''                                     " Not modified
    else
        let s.= '[R]'                                     " Read only file
    endif
    let l:s .= ' %= '                                     " Left/Right separator
    if exists('g:loaded_fugitive')
        let l:s .= '%#_StatusGit#'.fugitive#statusline().'%*'
    endif
    let l:s .= ' %6l'                                     " Current line number
    let l:s .= ',%-3c'                                    " Current column number, left aligned 3 characters wide
    let l:s .= ' %P '                                     " Percentage through the file
    return l:s
endfunction
"au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
"au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
" au FileType * setlocal statusline=%!MyStatusLine('Enter')
set statusline=%!MyStatusLine('Enter')

" Note: need to escape space with a backslash
"set statusline=
"set statusline+=%{expand('%:h')}\\ " Show file path no filename
"set statusline+=%#StatusLineNC#
"set statusline+=%t      "filename only no path (Tail)
"set statusline+=%*      "Return to default color StatusLine / StatusLineNC

""set statusline+=%-.50F  "displays the full filename of the current buffer, left aligned, 100 characters max.
""set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
""set statusline+=%{&ff}] "file format
""set statusline+=%h      "help file flag
"set statusline+=%#StatusUnsaved#
"set statusline+=%m      "modified flag
"set statusline+=%*      "Return to default color StatusLine / StatusLineNC
""set statusline+=%r      "read only flag
""set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
""set statusline+=[%03.b]\ \ " Current character in ASCII 3 min 3 digits
"" set statusline+= %{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}
"set statusline+=\ %6l,%-4c " Line number, Column Number
"set statusline+=\ %P\     "percent through file

"let &statusline = s:statusline_expr()

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------

" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
" function! s:statusline_expr()
"   let mod = "%{&modified ? '[+++] ' : !&modifiable ? '[---] ' : '[   ]'}"
"   let ro  = "%{&readonly ? '[RO] ' : ''}"
"   let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
"   let sep = ' %= '
"   let pos = ' %-12(%l : %c%V%) '
"   let pct = ' %P'

"   return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
" endfunction

" let &statusline = s:statusline_expr()

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
