"=========================================================
" VISUAL APPEARANCE
"=========================================================
" scheme created using http://bytefluent.com/vivify/
" NOTE If any colors are changed below, they will not take effect
" This file sets the colour scheme to only use colours from it.
" Even if the colours are defined in the file.

set cursorline      " High lights the line number and cusro line
set termguicolors   " Uses highlight-guifg and highlight-guibg, hence 24-bit color
color michael       " Note this resets all highlighting, so much be before others

"=========================================================
" STATUS BARS
set statusline=
set statusline+=%{expand('%:h')}\\ " Show file path no filename
set statusline+=%#StatusLineNC#
set statusline+=%t      "filename only no path (Tail)
set statusline+=%*      "Return to default color StatusLine / StatusLineNC

"set statusline+=%-.50F  "displays the full filename of the current buffer, left aligned, 100 characters max.
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
set statusline+=%#StatusUnsaved#
set statusline+=%m      "modified flag
set statusline+=%*      "Return to default color StatusLine / StatusLineNC
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
"set statusline+=[%03.b]\ \ " Current character in ASCII 3 min 3 digits
set statusline+=[%02.c]\      "cursor column have to escape space with a backslash
set statusline+=%l/%L   "cursor line/total lines, min 10 chars
set statusline+=\ %P\     "percent through file

"=========================================================
"HIGHLIGHTING
"Color for the below matches is in the michael color scheme

" LEADING SPACES NOT %4
" From the start of line, look for any number of 4 spaces
" Then match 1 to 3 spaces, selected with \za to \ze, then a none whitespace character
"match wrong_spacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
autocmd FileType *.py,*.js setlocal match wrong_spacing /\(^\(    \)*\)\zs \{1,3}\ze\S/

" TRAILING WHITESPACE
" Must escape the plus, match one or more space before the end of line
"2match trailing_whitespace /\s\+$/
autocmd FileType *.py,*.js setlocal 2match trailing_whitespace /\s\+$/

" https://www.youtube.com/watch?v=aHm36-na4-4
" If a line goes over 80 char wide highlight it
" This permanently sets a column coloured
" highlight ColorColumn ctermbg=magentadd
" set colorcolumn=81

"=========================================================
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
