" Folding controlled by "tmhedberg/SimpylFold"
" set foldmethod=indent
" set foldnestmax=1

" Note: foldlevel (for Neovim) works like how many level to show before
" folding. So 99 = fold the least, ie show 99 levels. 0 = Fold the most, ie.
" show no levels before folding.

" If less than 300 lines then no folding
if line('$') < 300
    setlocal foldlevel=99
else
    setlocal foldlevel=0
endif
