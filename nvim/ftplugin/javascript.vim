" Highlight groups of leading whitespace which is not a mutliple of 4
source <sfile>:h/html.vim
augroup js_set_wrong_spacing
    autocmd!
    autocmd FileType javascript match _WrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
augroup END
