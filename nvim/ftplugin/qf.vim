set nowrap
set norelativenumber
set colorcolumn=

nnoremap <Plug>MyDeleteQuickfix       :<C-U>set  opfunc=myautoload#QuickfixDeleteOperator<CR>g@
nnoremap <Plug>MyDeleteQuickfixLine   :<C-U>call myautoload#QuickfixDeleteOperator('line')<CR>
vnoremap <Plug>MyDeleteQuickfixVisual :<C-U>call myautoload#QuickfixDeleteOperator(visualmode())<CR>

nmap <silent> <buffer> d  <Plug>MyDeleteQuickfix
nmap <silent> <buffer> dd <Plug>MyDeleteQuickfixLine
vmap <silent> <buffer> d  <Plug>MyDeleteQuickfixVisual

