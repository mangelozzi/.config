set foldmethod=marker
set foldcolumn=1

augroup save_vim_file
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END
