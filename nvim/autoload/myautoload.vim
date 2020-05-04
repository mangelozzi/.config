" TODO
"  run jobstart in background - added, but blocks
"  multi line msg ... then input to get enter press. -> Neovim bug
" tab toggles line color

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
endfunction

function! myautoload#StripTrailingWhitespace(...)
    let just_command = a:0 >= 1 ? a:1 : 0
    if !just_command
        let l:winview = winsaveview()
    endif
    %s/\s\+$//e
    if !just_command
        call winrestview(l:winview)
        echom "Trailing whitespace stripped."
    endif
endfun
function! myautoload#AutoIndentFile(...)
    let just_command = a:0 >= 1 ? a:1 : 0
    if !just_command
        let l:winview = winsaveview()
    endif
    normal gg=G
    if !just_command
        call winrestview(l:winview)
        echom "Auto Indented buffer."
    endif
endfun
function! myautoload#SaveProgrammingFile()
    let l:winview = winsaveview()
    silent call myautoload#StripTrailingWhitespace(1)
    silent call myautoload#AutoIndentFile(1)
    call winrestview(l:winview)
    echom "Trailing whitespace stripped & Auto Indented."
endfun

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
function! myautoload#CompleteFromBufferWords(ArgLead, CmdLine, ...)
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

" Add auto completion for dir
" when :terminal system vs jobstart
function! s:SearchOnStdout(job_id, data, event) dict
    " Refer to `:help setqflist` and `:help setqflist-examples`
    let validList = filter(a:data, {idx, val -> val != ''})
    call map(validList, {idx, val -> substitute(val, "\<CR>", '', '')})

    echo "Processing another ".len(a:data)." entries..."
    if len(validList) > 0
        " QUICKFIX PREP
        if self.match_cnt == 0
            let self.match_cnt += len(validList)
            " Clear the quickfix of entries
            silent copen " Must be first so over operate on quickfix window
            call setqflist([], ' ', {'title' : self.qf_title, 'context' : self.qf_context})
            redrawstatus!
        endif
        let addList = getqflist({'lines' : validList}).items
        call setqflist(addList, 'a')  " a = add to the list
    endif
endfun
function! s:SearchOnStderr(job_id, data, event) dict
    " echo "My STDERR, job_id:".a:job_id." event:".a:event." data:".string(a:data)
    if a:data ==  ['']
        " Sometimes stderr emits nothing and it triggers a false negative.
        " echom "data is empty."
        return
    endif
    let self.error_cnt += 1
    cclose
    redraw
    echoerr join(a:data, "    ")
    " echohl ErrorMsg
    " for errorLine in a:data
    "     ec
    " echohl NONE
endfun
function! s:SearchOnExit(job_id, data, event) dict
    " echo "My EXIT, job_id:".a:job_id." event:".a:event." data:".string(a:data)
    " Refer to :h getqflist-examples*
    let num_entries = getqflist({'size' : 0}).size
    if self.error_cnt
        echom "Complete with ".self.error_cnt." ERRORS. ".num_entries." entries for: ".self.pattern
    else
        echom "COMPLETE. ".num_entries." entries for: ".self.pattern
    endif
    call clearmatches()
    let pattern = myautoload#SearchPearl2VimRegex(self.pattern)
    silent call matchadd('Search', pattern) " Hi group / pattern
    redrawstatus!
endfun
function! SearchHighlighting(cmdline)
    hi _SearchHighlighting guifg=lime
    return [[0, len(a:cmdline), '_SearchHighlighting']]
endfunc
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" https://neovim.io/doc/user/eval.html#termopen()
" https://neovim.io/doc/user/eval.html#jobstart()
let g:jump_to_first_match = 0
function! myautoload#SearchInFiles(mode)
    let s:search_dict = {
                \ 'pattern'  : '',
                \ 'qf_title' : '',
                \ 'error_cnt': 0,
                \ 'match_cnt': 0,
                \ 'cmd' : []}
    " GET SEARCH STRING
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    if index(['v', 'V', "\<c-v>"], a:mode) != -1
        let default_str = myautoload#GetVisualSelection(a:mode)
    else
        let default_str = expand('<cword>')
    endif
    let prompt = 'Search in Files '.getcwd().': '
    hi _SearchFlagTips guifg=#808080
    echohl _SearchFlagTips
    echom "Add auto complete for all possible flags, and separate question: Possible Flags: -F=no regex, -L=follow symlinks, --hidden=hidden files, --no-ignore=incl.Non VC files, --no-messages=no IO errors, --trim=Leading whitespace, -s=case sensitive, -i=ignore case"
    echohl None
    "For list of completion options :h command-completion
    let s:search_dict.pattern = input({
                \ 'prompt'      : prompt,
                \ 'default'     : default_str,
                \ 'completion'  : 'customlist,myautoload#CompleteFromBufferWords',
                \ 'cancelreturn': '',
                \ 'highlight'   : 'SearchHighlighting'})
    "let pattern = input(prompt, default_str, 'customlist,myautoload#CompleteFromBufferWords')
    if s:search_dict.pattern == '' || s:search_dict.pattern == '\n'
        echom "Aborted Search."
        return
    endif

    " PREP JOBSTART ARGS
    " rg flag --vimgrep is approx --no-heading, --with-filename --line-number --column --color never
    "   look into using --file for single file
    " if a list dont need shellescape(search_dict.pattern)
    let s:search_dict.cmd = ["rg", "--vimgrep", "--smart-case", s:search_dict.pattern, "./"]
    let s:search_dict.qf_title = " ".s:search_dict.pattern. "     Command: ".join(s:search_dict.cmd, ' ')
    let s:search_dict.qf_context = join(s:search_dict.cmd, ' ')
    let s:opts_dict= {
                \ 'on_exit'  : funcref('s:SearchOnExit',   s:search_dict),
                \ 'on_stdout': funcref('s:SearchOnStdout', s:search_dict),
                \ 'on_stderr': funcref('s:SearchOnStderr', s:search_dict)}
    " JOBSTART
    echom "About to start job..."
    let s:search_dict.buf_nr = jobstart(s:search_dict.cmd, s:opts_dict)
    echom "Start search for ".s:search_dict.pattern." got return start up value: ".s:search_dict.buf_nr
endfunction
