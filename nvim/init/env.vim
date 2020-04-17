"=========================================================
" ENVIROMENT for current project
"=========================================================

" Disable unused providers
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" PYTHON 2
" Disable python2 support
let g:loaded_python_provider = 0
let g:python_host_skip_check = 1

" PYTHON 2
" Disable python2 support
let g:loaded_python_provider = 0

"let $PYTHONPATH .= 'C:\code\linkcube\src'
"let $PYTHONPATH .= ';C:\code\linkcube\src\distros\cworld'
"let $PYTHONPATH .= ';C:\code\linkcube\src\distros\mpact'

let g:python3_host_skip_check=1


" PYTHON3
" May complain about $VIRTUAL_ENV not set, no problem, just activate required
" venv before starting NeoVim.
if has('unix')
    " echo "Linux Env"
    let g:python3_host_prog = '/usr/local/bin/python3'
endif

if has('win32')
    " echo "Windows Env"
    let g:python3_host_prog = 'C:/Users/Michael/.virtualenvs/linkcube-CDrGgQjY/Scripts/python.exe'
endif
