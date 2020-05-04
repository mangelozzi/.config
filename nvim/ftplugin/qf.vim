setlocal nowrap
setlocal norelativenumber
setlocal colorcolumn=

nnoremap <buffer> <Plug>MyDeleteQuickfix       :<C-U>set  opfunc=myal#QuickfixDeleteOperator<CR>g@
nnoremap <buffer> <Plug>MyDeleteQuickfixLine   :<C-U>call myal#QuickfixDeleteOperator('line')<CR>
vnoremap <buffer> <Plug>MyDeleteQuickfixVisual :<C-U>call myal#QuickfixDeleteOperator(visualmode())<CR>

nmap <silent> <buffer> d  <Plug>MyDeleteQuickfix
nmap <silent> <buffer> dd <Plug>MyDeleteQuickfixLine
vmap <silent> <buffer> d  <Plug>MyDeleteQuickfixVisual

