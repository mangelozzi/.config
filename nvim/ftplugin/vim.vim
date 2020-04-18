augroup save_vim_file
    autocmd!
    autocmd BufWritePost *.vim source %
augroup END
