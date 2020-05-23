" If a patched Nerd font is installed, then NERD Font tree works, doesnt
" have to be set as the current font

"GuiFont Consolas:h12
"! to supresses fixed width error
"set guifont=FuraCode\ NF:h12
"GuiFont FuraCode NF:h12
"set guifont=RobotoMono\ NF:h12!

" Robto Mono has too many bugs with vertical block spacing for now
" Set this first, so for Nerdtree icons can fall back and use this?
" set guifont=RobotoMono\ NF:h10:w1
" GuiFont! RobotoMono NF:h10.495:n

" Quite nice for windows
" set guifont=Consolas:h11
GuiFont Consolas:h11

" set guifont=SauceCodePro\ NF:h10:w10
" GuiFont! RobotoMono NF:h10.495:n

GuiTabline 0

call GuiWindowMaximized(1)

" If set linespace then border unicode chars dont touch each other
" Maybe, especially if font height a float value.
set linespace=0

"Coc Pop menu stacked ontop of each other instead of side by side
GuiPopupmenu 0

" Check the current font with
" :echo GuiFont

" Test block chars should touch if font set correctly:
" 0123456789 (() [] {} <> !@#$%^&*,./;'\?:"
" The quick brown fox jumped over the lazy dog
" THE QUICK BROWN FOX JUMPED OVER THE LAZY DOG
"█ ║
"█ ║ {}
"█ ║
