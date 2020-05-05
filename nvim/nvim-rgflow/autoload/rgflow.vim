" TODO
" tab toggles line color
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" https://neovim.io/doc/user/eval.html#termopen()
" https://neovim.io/doc/user/eval.html#jobstart()
" when :terminal system vs jobstart

" Autoload is only loaded on demand (i.e. when a function is called), hence
" mappings cannot be placed here, they will never be applied so it can call
" itself.
" Current neovim bug: multi line msg ... then input to get enter press.

function! s:GetLineRange(mode, op) range
    " the range attribute passes in a
    let current_pos = getpos(".")
    if a:mode ==# 'v' || a:mode ==# 'V' || a:mode ==# ''
        let startl = getpos("'<")[1]
        let endl   = getpos("'>")[1]
    else
        let startl = line('.')
        let endl = v:count1 + startl - 1
    endif
    echom a:
    return [current_pos, startl, endl]
    " call a:op([current_pos, startl, endl])
endfun

function! rgflow#QuickfixMarkOperator(mode) range
    :  execute (a:firstline + 1) . "," . a:lastline . 's/^/\t\\ '
    let [currentl, startl, endl] = s:GetLineRange(a:mode)
    echom "_______" currentl startl endl
    return
    let i = startl - 1
    let qflist = getqflist()
    while i <= endl - 1
        echom i." > "
        " the quickfix list is an arrow of dictionary entries, an example of one entry:
        " {'lnum': 57, 'bufnr': 5, 'col': 1, 'pattern': '', 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'module': '', 'text': 'function! myal#StripTrailingWhitespace()'}
        " echom i." >>> ".qflist[i]['text']." >>> ".s:MarkLine(qflist[i]['text'])
        let qflist[i]['text'] = s:MarkLine(qflist[i]['text'])
        let i += 1
    endwhile
    call setqflist(qflist)
    call setpos('.', currentl)
endfun

function! rgflow#QuickfixDeleteOperator(mode)
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    "call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    let [current_pos, startl, endl] = s:GetLineRange(a:mode)
    call setqflist(filter(getqflist(), {idx -> idx < startl-1 || idx > endl-1}), 'r')
    call setpos('.', current_pos)
endfun
function! EscapeForVimRegexp(str)
    return escape(a:str, '^$.*?/\[]')
endfunction
function! s:MarkLine(line)
    " Require to insert the marker after any whitespace
    let marker = g:rgflow_mark_str
    " Replace double marks with nothing (net affect toggles the mark)
    " Note: substitute returns a copy (does not replace in place)
    if match(a:line, '^\s*'.marker) == -1
        " If not a match, add the marker
        return substitute(a:line, '^\s*', '\0'.marker, '')
    else
        " If a match remove the marker
        return substitute(a:line, '\(^\s*\)'.marker, '\1', '')
    endif
endfun


function! rgflow#SearchPearl2VimRegex(pearl)
    let vim_re = a:pearl
    return vim_re
endfun


function! rgflow#GetVisualSelection(mode)
    " call with visualmode() as the argument
    " vnoremap <leader>zz :<C-U>call rgflow#GetVisualSelection(visualmode())<Cr>
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end]     = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode ==? "\<c-v>"
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

function! rgflow#CompleteFromBufferWords(ArgLead, CmdLine, ...)
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

function! rgflow#CompleteFromBufferWords(ArgLead, CmdLine, ...)
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


function! s:SearchOnStdout(job_id, data, event) dict
    " Refer to `:help setqflist` and `:help setqflist-examples`
    echom self.match_cnt." results added, now processing another ".len(a:data)."..."
    let validList = filter(a:data, {idx, val -> val != ''})

    if len(validList) > 0
        " QUICKFIX PREP
        if self.match_cnt == 0
            " Clear the quickfix of entries
            silent copen " Must be first so over operate on quickfix window
            call setqflist([], ' ', {'title' : self.qf_title, 'context' : self.qf_context})
            redrawstatus!
        endif
        echom self.match_cnt." results added, now processing another ".len(validList)."..."
        let self.match_cnt += len(validList)
        call map(validList, {idx, val -> substitute(val, "\<CR>", '', '')})
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
    let msg = self.pattern." ░ ".self.match_cnt." result".(self.match_cnt==1?'':'s')
    if self.error_cnt
        let msg .= " (".self.error_cnt." errors)"
    else
        let msg.= " ░ ".join(self.cmd, ' ')
    endif
    echom msg
    if self.match_cnt > 0
        call clearmatches()
        let pattern = rgflow#SearchPearl2VimRegex(self.pattern)
        silent call matchadd('Search', pattern) " Hi group / pattern
    endif
    redrawstatus!
endfun


function! SearchHighlighting(cmdline)
    return [[0, len(a:cmdline), 'RgFlowSearchInput']]
endfunc


let g:jump_to_first_match = 0
function! rgflow#SearchInFiles(mode)
    let s:search_dict = {
                \ 'error_cnt': 0,
                \ 'match_cnt': 0}

    " GET SEARCH STRING
    " Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    if index(['v', 'V', "\<c-v>"], a:mode) != -1
        let default_str = rgflow#GetVisualSelection(a:mode)
    else
        let default_str = expand('<cword>')
    endif
    echohl RgFlowFlagTips
    echohl None
    "For list of completion options :h command-completion
    let s:search_dict.pattern = input({
                \ 'prompt'      : 'RGFlow search PATTERN ',
                \ 'default'     : default_str,
                \ 'completion'  : 'customlist,rgflow#CompleteFromBufferWords',
                \ 'cancelreturn': '',
                \ 'highlight'   : 'SearchHighlighting'})
    "let pattern = input(prompt, default_str, 'customlist,rgflow#CompleteFromBufferWords')
    if s:search_dict.pattern == '' || s:search_dict.pattern == '\n'
        echom "Aborted Search."
        return
    endif

    " Get search dir
    let s:search_dict.path = input({
                \ 'prompt'      : 'RGFlow search PATH ',
                \ 'default'     : getcwd(),
                \ 'completion'  : 'file',
                \ 'cancelreturn': '',
                \ 'highlight'   : 'SearchHighlighting'})
    if s:search_dict.path == '' || s:search_dict.path == '\n'
        echom "Aborted Search."
        return
    endif

    if g:rgflow_flags_ask
        let g:rgflow_flags = input({
                    \ 'prompt'      : 'RGFlow Search FLAGS ',
                    \ 'default'     : g:rgflow_flags,
                    \ 'completion'  : 'file',
                    \ 'cancelreturn': '',
                    \ 'highlight'   : 'SearchHighlighting'})
    endif

    " PREP JOBSTART ARGS
    " rg flag --vimgrep is approx --no-heading, --with-filename --line-number --column --color never
    "   look into using --file for single file
    " if a list dont need shellescape(search_dict.pattern)
    let s:search_dict.cmd = ["rg", "--vimgrep"] + split(g:rgflow_flags, ' ') + [s:search_dict.pattern, s:search_dict.path]
    let s:search_dict.qf_title = "  ".s:search_dict.pattern. "    ".s:search_dict.path
    let s:search_dict.qf_context = join(s:search_dict.cmd, ' ')
    let s:opts_dict= {
                \ 'on_exit'  : funcref('s:SearchOnExit',   s:search_dict),
                \ 'on_stdout': funcref('s:SearchOnStdout', s:search_dict),
                \ 'on_stderr': funcref('s:SearchOnStderr', s:search_dict)}

    " JOBSTART
    let s:search_dict.buf_nr = jobstart(join(s:search_dict.cmd, ' '), s:opts_dict)
    echom "Start search for ".s:search_dict.pattern
endfunction
