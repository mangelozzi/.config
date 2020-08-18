" TODO
"  run jobstart in background - added, but blocks
"  multi line msg ... then input to get enter press. -> Neovim bug
" tab toggles line color

" NOTE mappings cannot be placed here, because they won't be applied
" Autoload is only loaded on demand (i.e. when a function is called)

" This function sets up the opfunc so it can be repeated with a dot.
" Align to Column works by moving the next none whitespace character to the
" desired columned. e.g. 32<hotkey> will align the next none whitespace
" character to column 32. Then press dot to repeat the operation.
function! myal#SetupAlignToColumn(col)
    if v:count != 0
        let g:myal_align_col = v:count
    endif
    set opfunc=myal#AlignToColumn
    return 'g@l'
endfunction
function! myal#AlignToColumn(motion)
    " Get cursor to just before next none space
    let reg_backup_value = getreg('z')    " Backup the contents of the unnamed register
    let reg_backup_type = getregtype('z')      " Save the type of the register as well
    let l:winview = winsaveview()
    let cmd = 'normal wh'.g:myal_align_col.'a'."\<SPACE>\<ESC>".'"zd'.(g:myal_align_col - 1).'|'
    exe cmd
    call winrestview(l:winview)
    call setreg('z', reg_backup_value, reg_backup_value) " Restore register
    normal j
endfunction

function! myal#DuplicateLine(pasteAbove)
    let l:winview = winsaveview()
    let reg_backup_value = getreg('z')    " Backup the contents of the unnamed register
    let reg_backup_type = getregtype('z')      " Save the type of the register as well
    let cmd = 'normal "zyy"z'
    let cmd .= (a:pasteAbove) ? 'P' : 'p'
    exe cmd
    call setreg('z', reg_backup_value, reg_backup_value) " Restore register
    call winrestview(l:winview)
    let cmd = 'normal '
    if !a:pasteAbove
        normal j
    endif
endfunction

function! myal#PrintHiGroup()
    if len(synstack(line("."), col("."))) == 0
        echo "Normal"
    endif
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
        exe "hi ".n1
    endfor
endfunction

function! myal#AddWindowMatches()
    " match is WINDOW LOCAL ONLY, so we have to jump through some hoops to
    " make it apply to buffers only. i.e. we cant just use :setlocal match!

    " First clear all existing matches on the window, then we will add back the
    " matches required for each file type
    " If you use clearmatches() if deletes matches added by other plugins,
    " e.g. rg-flow, colorizer?
    let w:my_matches = get(w:, 'my_matches', [])
    for match_id in w:my_matches
        call matchdelete(match_id)
    endfor
    let w:my_matches = []

    " TRAILING WHITESPACE
    " Must escape the plus, match one or more space before the end of line
    " match trailing whitespace, except when typing at the end of a line.
    " Can use the match command or matchadd() function which returns a handle
    " to the match, so it can easily be cleared with matchdelete(), not used here
    " match _MatchTrailingWhitespace /\s\+$/
    if 1
        let match_id = matchadd('_MatchTrailingWhitespace', '\s\+$', -1)
        call add(w:my_matches, match_id)
    endif

    " LEADING SPACES NOT %4
    " From the start of line, look for any number of 4 spaces
    " Then match 1 to 3 spaces, selected with \za to \ze, then a none whitespace character
    if index(['python', 'javascript'], &ft) >= 0
        " match _MatchWrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
        "match _MatchWrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/
        let match_id = matchadd('_MatchWrongSpacing', '\(^\(    \)*\)\zs \{1,3}\ze\S', -1)
        call add(w:my_matches, match_id)
    endif

    " MATCH FOLDS
    " VimEnter handles at start up, WinNew for each window created AFTER startup.
    " Regex matches { { { with an empty group in the middle so that vim does
    " not create a fold in this code, then either a 1 or 2 then a space. Then
    " zs is the start of the match which is the rest of the line then ze is
    " the end of the match. Refer to :help pattern-overview
    if 1 " index(['vim', 'python', 'javascript'], &ft) >= 0
        " Matching folded header currently not supported yet!
        let match_id = matchadd('_FoldedLevel1', '^+--\d\+\ lines:\ \zs[^.]\+\ze', -1)
        call add(w:my_matches, match_id)
        let match_id = matchadd('_FoldedLevel2', '^+---\d\+\ lines:\ \zs[^.]\+\ze', -1)
        call add(w:my_matches, match_id)
        let match_id = matchadd('_FoldedLevel3', '^+----\d\+\ lines:\ \zs[^.]\+\ze', -1)
        call add(w:my_matches, match_id)
        let match_id = matchadd('_UnfoldedLevel1', '{{\(\){1\ \zs.\+\ze', -1)
        call add(w:my_matches, match_id)
        let match_id = matchadd('_UnfoldedLevel2', '{{\(\){2\ \zs.\+\ze', -1)
        call add(w:my_matches, match_id)
        let match_id = matchadd('_UnfoldedLevel3', '{{\(\){3\ \zs.\+\ze', -1)
        call add(w:my_matches, match_id)
    endif
endfunction
" {{{1 ONE
" {{{2 HELLO
" {{{3 THREE


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
