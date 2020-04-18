" Highlight groups of leading whitespace which is not a mutliple of 4
augroup python_set_wrong_spacing
    autocmd!
    autocmd FileType python match _WrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
augroup END
