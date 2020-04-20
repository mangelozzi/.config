" TODO
"  run jobstart in background
"  multi line msg ... then input to get enter press.
" add back delete lines
" tab toggles line color
"  Clean up

" NOTE mappings cannot be placed here, because they won't be applied
" Autoload is only loaded on demand (i.e. when a function is called)
function! myautoload#QuitIfLastBuffer()
    let cnt = 0
    for nr in range(1,bufnr("$"))
        if buflisted(nr) && ! empty(bufname(nr)) || getbufvar(nr, '&buftype') ==# 'help'
            let cnt += 1
        endif
    endfor
    if cnt <= 1
        :q
    else
        :bd
    endif
endfunction

function! myautoload#StripTrailingWhitespace()
    %s/\s\+$//e
endfun
function! myautoload#AutoIndentFile()
    normal gg=G
endfun
function! myautoload#SaveProgrammingFile()
    let l:winview = winsaveview()
    silent call myautoload#StripTrailingWhitespace()
    silent call myautoload#AutoIndentFile()
    call winrestview(l:winview)
    echom "Trailing whitespace stripped & Auto Indented."
endfun

function! myautoload#SearchOnStdout(job_id, data, event)
    " Refer to :h setqflist
    " Refer to :h setqflist-examples
    let validList = filter(a:data, {idx, val -> val != ''})
    echo "Processing another ".len(a:data)." entries..."
    if len(validList) > 0
        let addList = getqflist({'lines' : validList}).items
        call setqflist(addList, 'a')  " a = add to the list
    endif
endfun

function! myautoload#SearchOnStderr(job_id, data, event)
    "echo "My ERROR, job_id:".a:job_id." event:".a:event." data:".string(a:data)
    let errorMsg = ''
    for errorLine in a:data
        let errorMsg .= errorLine.'  '
    endfor
    echohl errormsg
    echon errorMsg
    echohl normal
endfun

function! myautoload#SearchOnExit(job_id, data, event)
    "echo "My EXIT, job_id:".a:job_id." event:".a:event." data:".string(a:data)
    " Refer to :h getqflist-examples*
    "echom "COMPLETE. ".getqflist({'size' : 0}).size." entries for: ".g:searchString
endfun


" https://neovim.io/doc/user/nvim_terminal_emulator.html
" https://neovim.io/doc/user/eval.html#termopen()
" https://neovim.io/doc/user/eval.html#jobstart()
let g:jump_to_first_match = 0
let g:searchString = ''
function! myautoload#SearchInFiles()
    let g:searchString = "call"
    " 'neovim.io' "input('Search in Files '.getcwd().': ')
    "let foo = input("Which was escaped to: ".shellescape(searchString))
    " FROM FZF HELP, READ THIS: let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'

    let rg_cmd = 'rg -H --no-heading --column --line-number --smart-case --color=always'.g:searchString
    "silent cexpr system('rg --no-heading --column '.shellescape(searchString).' '.getcwd())
    "silent cexpr system('rg -H --no-heading --column '.searchString)
    "exe 'terminal rg -H --no-heading --column '.searchString. ' '.getcwd()
    "let terminal_buf_nr = bufnr()
    "silent copen
    let opts_dict = {'on_exit': 'myautoload#SearchOnExit', 'on_stdout': 'myautoload#SearchOnStdout', 'on_stderr': 'myautoload#SearchOnStderr'}
    " let terminal_buf_nr = termopen(rg_cmd, opts_dict)

    " Clear the quickfix of entries
    silent copen
    echom
    let title = " ".g:searchString. "     Command: ".rg_cmd
    let context = {'cmd' : rg_cmd}
    call setqflist([], ' ', {'title' : title, 'context' : context})
    "call setqflist([])
    echom "--------------------------------------------------"
    echom "About to start job..."
    let terminal_buf_nr = jobstart(rg_cmd, opts_dict)
    "echom "Start search for ".g:searchString." got return start up value: ".terminal_buf_nr
endfunction
function! myautoload#DeleteQuickfix(start, end)
    "echom " Start: ".a:start."  End: ".a:end
    let save_pos = getpos(".")
    "call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    call setqflist(filter(getqflist(), {idx -> idx < a:start-1 || idx > a:end-1}), 'r')
    call setpos('.', save_pos)
endfunction
function! myautoload#DeleteQuickfixOperator(mode)
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    " let save_pos = getpos(".")
    " call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    " call setpos('.', save_pos)
    " echo a:count1
    if a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
        let l:start = getpos("'<")[1]
        let l:end   = getpos("'>")[1]
    else
        let l:start = line('.')
        let l:end = v:count1 + l:start - 1
    endif
    " echom a:mode." Start: ".l:start."  End: ".l:end
    call myautoload#DeleteQuickfix(l:start, l:end)
endfunction
