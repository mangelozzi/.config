" NOTE mappings cannot be placed here, because they won't be applied
" Autoload is only loaded on demand (i.e. when a function is called)
function myautoload#QuitIfLastBuffer()
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

function myautoload#StripTrailingWhitespace()
    %s/\s\+$//e
endfun
function myautoload#AutoIndentFile()
    normal gg=G
endfun
function myautoload#SaveProgrammingFile()
    let l:winview = winsaveview()
    silent call myautoload#StripTrailingWhitespace()
    silent call myautoload#AutoIndentFile()
    call winrestview(l:winview)
    echom "Trailing whitespace stripped & Auto Indented."
endfun

let g:jump_to_first_match = 0
function myautoload#SearchInFiles()
    let searchString = input('Search in Files '.getcwd().': ')
    "let foo = input("Which was escaped to: ".shellescape(searchString))
    try
        "silent cexpr system('rg --no-heading --column '.shellescape(searchString).' '.getcwd())
        "silent cexpr system('rg -H --no-heading --column '.searchString)
        exe 'terminal rg -H --no-heading --column '.searchString. ' '.getcwd()

        let searchString = input('ran terminal buffer: '.bufnr())

        cbuffer
        " Switch to the quickfix window so changes matches apply to it
        silent copen
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
            echom "WEnt to previous window"
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
function myautoload#DeleteQuickfix(start, end)
    "echom " Start: ".a:start."  End: ".a:end
    let save_pos = getpos(".")
    "call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    call setqflist(filter(getqflist(), {idx -> idx < a:start-1 || idx > a:end-1}), 'r')
    call setpos('.', save_pos)
endfunction
function myautoload#DeleteQuickfixOperator(mode)
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

"nnoremap <silent> <Plug>SortMotion :<C-U>set opfunc=<SID>sort_motion<CR>g@
"nnoremap <buffer> <silent> dd \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r') <Bar> cc<CR>
"nnoremap <buffer> <silent> d :<C-u>set operatorfunc=myautoload#DeleteQuickfixEntry()<CR>g@
