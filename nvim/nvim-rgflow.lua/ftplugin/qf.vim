" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal nowrap
setlocal norelativenumber
setlocal colorcolumn=

" conceal options are always window local
set conceallevel=2
set concealcursor=nvic

"Disable accidental alternate buffer switching in quickfix window
nnoremap <buffer> <C-^>   <Nop>
nnoremap <buffer> <C-S-^> <Nop>
nnoremap <buffer> <C-6>   <Nop>

nnoremap <buffer> <Plug>MyDeleteQuickfix       :<C-U>set  opfunc=rgflow#QuickfixDeleteOperator<CR>g@
nnoremap <buffer> <Plug>MyDeleteQuickfixLine   :<C-U>call rgflow#QuickfixDeleteOperator('line')<CR>
vnoremap <buffer> <Plug>MyDeleteQuickfixVisual :<C-U>call rgflow#QuickfixDeleteOperator(visualmode())<CR>

nmap <silent> <buffer> d  <Plug>MyDeleteQuickfix
nmap <silent> <buffer> dd <Plug>MyDeleteQuickfixLine
vmap <silent> <buffer> d  <Plug>MyDeleteQuickfixVisual

