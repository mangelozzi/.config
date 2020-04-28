" TODO
"  run jobstart in background - added, but blocks
"  multi line msg ... then input to get enter press. -> Neovim bug
" tab toggles line color

" NOTE mappings cannot be placed here, because they won't be applied
" Autoload is only loaded on demand (i.e. when a function is called)

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
let g:search_errors = 0
function! myautoload#SearchOnStderr(job_id, data, event)
    if a:data ==  ['']
        " Sometimes stderr emits nothing and it triggers a false negative.
        return
    endif
    let g:search_errors = 1
    cclose
    redraw
    echom "SEARCH ERROR, job_id:".a:job_id." event:".a:event
    echoerr join(a:data, "    ")
    " echohl ErrorMsg
    " for errorLine in a:data
    "     echom errorLine
    " endfor
    " echohl NONE
endfun
function! myautoload#SearchOnExit(job_id, data, event)
    "echo "My EXIT, job_id:".a:job_id." event:".a:event." data:".string(a:data)
    " Refer to :h getqflist-examples*
    let num_entries = getqflist({'size' : 0}).size
    if g:search_errors
        echom "Complete with ERRORS. ".num_entries." entries for: ".shellescape(g:searchString)
    else
        echom "COMPLETE. ".num_entries." entries for: ".shellescape(g:searchString)
    endif
    redrawstatus!
endfun
function! myautoload#SearchPearl2VimRegex(pearl)
    let vim_re = a:pearl
    return vim_re
endfun
function! myautoload#GetVisualSelection(mode)
    " call with visualmode() as the argument
    " vnoremap <leader>zz :<C-U>call myautoload#GetVisualSelection(visualmode())<Cr>
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end]     = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode == "\<c-v>"
        " Block mode, trim every line
        let new_lines = []
        let i = 0
        for line in lines
            let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
        endfor
    else
        return ''
    endif
    return join(lines, "\n")
endfunction
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" https://neovim.io/doc/user/eval.html#termopen()
" https://neovim.io/doc/user/eval.html#jobstart()
let g:jump_to_first_match = 0
let g:searchString = ''
function! myautoload#SearchInFiles(mode)
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    if index(['v', 'V', "\<c-v>"], a:mode) != -1
        let default_str = myautoload#GetVisualSelection(a:mode)
    else
        let default_str = expand('<cword>')
    endif
    try
        let g:searchString = input('Search in Files '.getcwd().': ', default_str)
    catch
        echom "Aborted search."
        return
    endtry
    let g:search_errors = 0
    " let terminal_buf_nr = termopen(rg_cmd, opts_dict)
    "let foo = input("Which was escaped to: ".shellescape(searchString))
    " FROM FZF HELP, READ THIS: let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'

    " rg command options:
    "   H = with filename
    "   Note, --color=always causes error on parsing
    let rg_cmd = 'rg -H --no-heading --column --line-number --smart-case '.shellescape(g:searchString)

    " Clear the quickfix of entries
    silent copen " Must be first so over operate on quickfix window
    let title = " ".g:searchString. "     Command: ".rg_cmd
    let context = {'cmd' : rg_cmd}
    call setqflist([], ' ', {'title' : title, 'context' : context})
    redrawstatus!
    call clearmatches()
    let pattern = myautoload#SearchPearl2VimRegex(g:searchString)
    silent call matchadd('Search', pattern) " Hi group / pattern

    echom "--------------------------------------------------"
    echom "About to start job..."
    let opts_dict = {'on_exit': 'myautoload#SearchOnExit', 'on_stdout': 'myautoload#SearchOnStdout', 'on_stderr': 'myautoload#SearchOnStderr'}
    let terminal_buf_nr = jobstart(rg_cmd, opts_dict)
    "echom "Start search for ".g:searchString." got return start up value: ".terminal_buf_nr
endfunction

function! myautoload#QuickfixDeleteOperator(mode)
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    if a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
        let start = getpos("'<")[1]
        let end   = getpos("'>")[1]
    else
        let start = line('.')
        let end = v:count1 + start - 1
    endif
    let save_pos = getpos(".")
    "call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    call setqflist(filter(getqflist(), {idx -> idx < start-1 || idx > end-1}), 'r')
    call setpos('.', save_pos)
endfunction

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
" from https://stackoverflow.com/a/44950143/5506400
function! myautoload#DeleteCurBufferNotCloseWindow() abort
    if &modified
        echohl ErrorMsg
        echom "E89: no write since last change"
        echohl None
    elseif winnr('$') == 1
        " bd
        call myautoload#QuitIfLastBuffer()
    else  " multiple window
        let oldbuf = bufnr('%')
        let oldwin = winnr()
        while 1   " all windows that display oldbuf will remain open
            if buflisted(bufnr('#'))
                b#
            else
                bn
                let curbuf = bufnr('%')
                if curbuf == oldbuf
                    enew    " oldbuf is the only buffer, create one
                endif
            endif
            let win = bufwinnr(oldbuf)
            if win == -1
                break
            else        " there are other window that display oldbuf
                exec win 'wincmd w'
            endif
        endwhile
        " delete oldbuf and restore window to oldwin
        exec oldbuf 'bd'
        exec oldwin 'wincmd w'
    endif
endfunc
