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
    echo "My OUT, job_id:".a:job_id." event:".a:event
    "." data:".string(a:data)
    "let filter_msg = filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')
    "echom "filter value: >>>".string(filter_msg)."<<<"

    let myList = filter(a:data, {idx, val -> val != ''})
    "echom "mylist>>> ".string(myList)
    if len(myList) > 0
        let newList = getqflist({'lines' : myList}).items
        "echom string(newList)
        call setqflist(newList)
    endif
    "for entry in a:data
    "    if entry != ''
    "        echom "ADD: ".entry
    "        "echo getqflist({'lines' : myList}).items
    "        "call setqflist(entry)
    "        " call setloclist(3, [], 'a', {'title' : 'Cmd output'})
    "    endif
    "endfor
    " If there are now entries in the quickfix window, open it
    "cwindow
endfun

function! myautoload#SearchOnStderr(job_id, data, event)
    echo "My ERROR, job_id:".a:job_id." event:".a:event." data:".string(a:data)
endfun

function! myautoload#SearchOnExit(job_id, data, event)
    echo "My EXIT, job_id:".a:job_id." event:".a:event." data:".string(a:data)
endfun


" https://neovim.io/doc/user/nvim_terminal_emulator.html
" https://neovim.io/doc/user/eval.html#termopen()
" https://neovim.io/doc/user/eval.html#jobstart()
let g:jump_to_first_match = 0
function! myautoload#SearchInFiles()
    let searchString = "call"
    " 'neovim.io' "input('Search in Files '.getcwd().': ')
    "let foo = input("Which was escaped to: ".shellescape(searchString))
    " FROM FZF HELP, READ THIS: let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let rg_cmd = 'rg -H --no-heading --column --line-number --smart-case '.searchString
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
    let title = " ".searchString. "     Command: ".rg_cmd
    let context = {'cmd' : rg_cmd}
    call setqflist([], ' ', {'title' : title, 'context' : context})
    "call setqflist([])
    echom ""
    echom "--------------------------------------------------"
    echom ""
    echom "About to start job..."
    let terminal_buf_nr = jobstart(rg_cmd, opts_dict)
    "echom "Start search for ".searchString." got return start up value: ".terminal_buf_nr
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

function s:temp()
    try
        "cbuffer
        " Switch to the quickfix window so changes matches apply to it
        let searchString="???"
        silent call clearmatches()
        silent call matchadd('Search', searchString)
        " Now leave the quickfix window
        if g:jump_to_first_match
            " Going to the first quickfix change (cc)
            silent cc
        else
            " Return cursor position
            "normal \<C-w> p
            "call feedkeys('\<Esc>\<C-w>p')
            wincmd p
            echom "Went to previous window"
        endif
        " Use feedkeys because built in commands do not activate search word
        " highlihighlighting.
        call feedkeys('/'.searchString."\<CR>")
        " remove a cw entry
        echom "Search complete for ".searchString." Which was escaped to: ".shellescape(searchString)
    catch /E486:\|E42:/
        "E486: Pattern not found
        "E42: No error (who knows whats up with that)
        cclose
        echohl WarningMsg
        echo "Pattern ".searchString." not found. Was escaped to: ".shellescape(searchString)
        echohl None
    endtry
endfunction
"nnoremap <silent> <Plug>SortMotion :<C-U>set opfunc=<SID>sort_motion<CR>g@
"nnoremap <buffer> <silent> dd \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
"nnoremap <buffer> <silent> d :<C-u>set operatorfunc=myautoload#DeleteQuickfixEntry()<CR>g@
