" |hl-ColorColumn|.

"Function: s:initVariable() function
"This function is used to initialise a given variable to a given value. The
"variable is only initialised if it does not exist prior
"
"Args:
"var: the name of the var to be initialised
"value: the value to initialise var to
"
"Returns:
"1 if the var is set, 0 otherwise
function! s:initVariable(var, value)
    if !exists(a:var)
        let val = a:value
        let :exec 'let '.a:var.' = '.a:value
        return 1
    endif
    return 0
endfunction

"SECTION: Init variable calls and other random constants
" call s:initVariable('g:NERDTreeAutoCenter', 1)

if !exists('g:rgflow_flags')
    " Examples of other possible flags:
    "    -F=no regex, -L=follow symlinks, --hidden=hidden files, --no-ignore=incl.Non VC files, --no-messages=no IO errors, --trim=Leading whitespace, -s=case sensitive, -i=ignore case"
    let g:rgflow_flags = "--smart-case --no-messages"
endif
if !exists('g:rgflow_flags_ask')
    " For each search, after asking for the pattern and then path, whether to
    " give the opertunity to alter the flags.
    let g:rgflow_flags_ask = 0
endif
let g:rgflow_mark_str = "■"
if !exists('g:rgflow_mark_str')
    let g:rgflow_mark_str = "■"
endif
if !hlexists('RgFlowSearchInput')
    " Highlighting group for the input dialogue input text
    hi RgFlowSearchInput guifg=lime ctermfg=LightGreen
endif

" Rip grep in files, use <cword> under the cursor as starting point
nnoremap <leader>rg :call rgflow#SearchInFiles('n')<Cr>

" Rip grep in files, use visual selection as starting point
xnoremap <leader>rg :<C-U>call rgflow#SearchInFiles(visualmode())<Cr>

" Rip grep in files, use <cword> under the cursor as starting point
" nnoremap <leader>v :call rgflow#QuickfixMarkOperator('n')<Cr>
nmap <silent> <leader>v :<C-U>set opfunc=rgflow#QuickfixMarkOperator<CR>g@

" Rip grep in files, use visual selection as starting point
xnoremap <leader>v :<C-U>call rgflow#QuickfixMarkOperator(visualmode())<Cr>
