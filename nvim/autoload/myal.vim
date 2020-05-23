" TODO
"  run jobstart in background - added, but blocks
"  multi line msg ... then input to get enter press. -> Neovim bug
" tab toggles line color

" NOTE mappings cannot be placed here, because they won't be applied
" Autoload is only loaded on demand (i.e. when a function is called)

function! myal#QuitIfLastBuffer()
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
function! myal#DeleteCurBufferNotCloseWindow() abort
    if &modified
        echohl ErrorMsg
        echom "E89: no write since last change"
        echohl None
    elseif winnr('$') == 1
        " bd
        call myal#QuitIfLastBuffer()
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
endfunction

function! myal#StripTrailingWhitespace()
    let l:winview = winsaveview()
    :%s/\s\+$//e
    call winrestview(l:winview)
    echom "Trailing whitespace stripped."
endfun
function! myal#AutoIndentFile()
    let l:winview = winsaveview()
    normal gg=G
    call winrestview(l:winview)
    echom "Auto Indented buffer."
endfun

function! myal#GetVisualSelection(mode)
    " call with visualmode() as the argument
    " vnoremap <leader>zz :<C-U>call myal#GetVisualSelection(visualmode())<Cr>
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
function! myal#CompleteFromBufferWords(ArgLead, CmdLine, ...)
    let str = getline(1, '$')
    let str  = join(str, ' ')
    " Split on whitespace and unusual characters (excludes - # _)
    let slist = split(str, '[ \t~!@$%^&*+=()<>{}[\];:|,.?"\\/'']\+')
    call filter(slist, {_, x -> len(x) > 2 && match(x, '^[a-zA-Z_]\+') > -1})
    " If must start with the word
    "call filter(slist, {_, x -> match(x, '^' . a:CmdLine) > -1})
    " If must only contain the word
    call filter(slist, {_, x -> match(x, a:CmdLine) > -1})
    call sort(slist)
    call uniq(slist)
    return slist
endfunction
" echom CompleteWords2("Comp")

" Experimental tab usage
" https://dmerej.info/blog/post/vim-cwd-and-neovim/
function! myal#OnTabEnter(path)
    if isdirectory(a:path)
        let dirname = a:path
    else
        let dirname = fnamemodify(a:path, ":h")
    endif
    " tcd sets curret dir for the current tab and window
    execute "tcd ". dirname
endfunction()
function! myal#ConvertBufferToNewTab()
    messages clear
    let p = expand("%:p")
    let h = expand("%:h")
    let a = expand("#:p")
    echom "normal \<C-S-^>"
    exe   "normal \<C-S-^>"
    echom "tabe ".p
    exe   "tabe ".p
    exe "tcd ".h
endfunction
