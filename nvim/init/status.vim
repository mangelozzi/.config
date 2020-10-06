" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------
" Note to self when time read: https://vi.stackexchange.com/questions/10458/how-do-i-conditionally-add-items-to-the-statusline

function! GetRootToPWD() abort
    " Example cwd: /home/michael/.config/nvim
    " Example relative filepath: init/status.vim
    " Example absolute filepath: ~/foo/bar/baz.txt
    " If relative filepath, return cwd for status line to be in subtle colors
    " If absolute filepath, return nothing, as status line filename will print
    " whole path.

    if &filetype == 'nerdtree'
        return getcwd()
    elseif &buftype != ''
        return ''
    elseif &readonly || !&modifiable
        return '[R]'
    endif
    let rel_path = index(['~', '/',], @%[0]) == -1
    if rel_path
        " g:is_win?'\\':'/'
        return getcwd().'/'
    else
        return ''
    endif
endfunction

function! GetDir() abort
    if &buftype != '' || &readonly || !&modifiable || &filetype == 'nerdtree'
        return ''
    endif
    return expand('%:h').(g:is_win?'\\':'/')
endfunction

function! GetFilename() abort
    if &filetype == 'nerdtree'
        return ''
    elseif &buftype != ''
        " see :help buftype
        return '['.toupper(&buftype).']'
    endif
    return expand('%:t')
endfunction

function! GetFileType() abort
    if &filetype == 'nerdtree'
        return ''
    endif
    return "│ ".&filetype." "
endfunction

function! GetGit() abort
    if &readonly || !&modifiable || &filetype == 'nerdtree' || &buftype == 'quickfix' || !exists('g:loaded_fugitive')
        return ''
    endif
    return fugitive#statusline().'   '
endfunction

function! MyStatusLine(currentWindow) abort
    " To see a list of formatting items, e.g. %l), see :h statusline
    " The only thing which can be dynamically checked, is whether it is the
    " active window or not, since the status line is recalculated only when
    " switching windows.

    if a:currentWindow
        if &buftype == 'quickfix'
            let col_line   = "%#_qfStatusLine#"
            let col_file   = "%#_qfStatusFile#"
            let col_subtle = "%#_qfStatusSubtle#"
            let col_fade1  = "%#_qfStatusFade1#"
            let col_fade2  = "%#_qfStatusFade2#"
            let col_fade3  = "%#_qfStatusFade3#"
        elseif &buftype ==  'help'
            let col_line   = "%#_helpStatusLine#"
            let col_file   = "%#_helpStatusFile#"
            let col_subtle = "%#_helpStatusSubtle#"
            let col_fade1  = "%#_helpStatusFade1#"
            let col_fade2  = "%#_helpStatusFade2#"
            let col_fade3  = "%#_helpStatusFade3#"
        else
            let col_line   = "%#StatusLine#"
            let col_file   = "%#_StatusFile#"
            let col_subtle = "%#_StatusSubtle#"
            let col_fade1  = "%#_StatusFade1#"
            let col_fade2  = "%#_StatusFade2#"
            let col_fade3  = "%#_StatusFade3#"
        endif
    else
        " If not the current window, then override the colors with gray
        let col_line   = "%#StatusLineNC#"
        let col_file   = "%#_StatusFileNC#"
        let col_subtle = "%#_StatusSubtleNC#"
        let col_fade1  = "%#_StatusFadeNC1#"
        let col_fade2  = "%#_StatusFadeNC2#"
        let col_fade3  = "%#_StatusFadeNC3#"
    endif
    let s = ""
    "let s .= "%*"                                       " Return to default color StatusLine / StatusLineNC
    let s .= col_subtle
    let s .= " "
    let s .= "%{GetRootToPWD()}"    " Show file path head for modifiable files
    let s .= col_line
    let s .= "%{GetDir()}"    " Show file path head for modifiable files
    let s .= col_fade1."▌".col_fade2."▌".col_fade3."▌"
    " anything to the left of %< will be retained
    let s .= "%>"                                        " Where to truncate long lines
    let s .= col_file
    " let s .= " %t "                                     " filename only no path (Tail)
    let s .= '%{GetFilename()}'
    let s .= "%#_StatusModified#%{&modified?' +++ ':''}"
    let s .= col_fade3."%{!&modified?'▐':''}".col_fade2."%{!&modified?'▐':''}".col_fade1."%{!&modified?'▐':''}"
    let s .= col_line
    let s .= "%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''}"
    let s .= "%="                                     " Left/Right separator
    if get(g:, 'coc_enabled', 0)
        let s .= " %{coc#status()}%{get(b:,'coc_current_function','')} "
    endif
    let s .= col_subtle."%{GetGit()}"
    let s .= col_line
    let s .= '%{GetFileType()}'
    " let s .= "%6l"                                     " Current line number
    " let s .= ",%-3c"                                    " Current column number, left aligned 3 characters wide (use line number on left instead)
    let s .= "│%-3c"                                    " Current column number, left aligned 3 characters wide
    let s .= "▏%P "                                     " Percentage through the file
    return s
endfunction
"set statusline=%!MyStatusLine('Enter')
augroup update_status_line
    autocmd!
    " Swap between windows: WinEnter --> BufEnter
    " Swap between two windows showing the same buffer --> WinEnter
    " WinEnter    =  Required for when a new window created and pops up
    " BufEnter    =  Required for when switching between existing buffers
    " BufWinEnter =  Required when running another quickfix search when one
    "                already exists
    " BufWritePost = When saving myplugins, with no window of buffer switching
    "                would go blank
    " autocmd BufEnter    * echom "BufEnter:    ".win_getid()." ".&buftype." ".@%
    " autocmd BufNew      * echom "BufNew:      ".win_getid()." ".&buftype." ".@%
    " autocmd WinEnter    * echom "WinEnter:    ".win_getid()." ".&buftype." ".@%
    " autocmd WinNew      * echom "WinNew:      ".win_getid()." ".&buftype." ".@%
    " autocmd BufWinEnter * echom "BufWinEnter: ".win_getid()." ".&buftype." ".@%

    "autocmd BufLeave    * echom "BufLeave:    ".win_getid()." ".&buftype." ".@%
    "autocmd WinLeave    * echom "WinLeave:    ".win_getid()." ".&buftype." ".@%
    "autocmd BufWinLeave * echom "BufWinLeave: ".win_getid()." ".&buftype." ".@%

    " StatusLine colouring dependant on active/none active window
    autocmd BufWinEnter,BufEnter,WinEnter * setlocal statusline=%!MyStatusLine(1) | redrawstatus!
    autocmd WinLeave * setlocal statusline=%!MyStatusLine(0) | redrawstatus!

    " Quickfix custom Coloring
    autocmd BufWinEnter,BufEnter * if &buftype == 'quickfix' | set winhighlight=Normal:_qfNormal,LineNr:_qfLineNr,CursorLineNr:_qfCursorLineNr,CursorLine:_qfCursorLine | endif
    autocmd BufWinLeave * if &buftype == 'quickfix' | set winhighlight=Normal:Normal | endif
augroup END

