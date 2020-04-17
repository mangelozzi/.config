set nowrap
set norelativenumber

nnoremap <Plug>MyDeleteQuickfix       :<C-U>set  opfunc=myautoload#DeleteQuickfixOperator<CR>g@
nnoremap <Plug>MyDeleteQuickfixLine   :<C-U>call myautoload#DeleteQuickfixOperator('line')<CR>
vnoremap <Plug>MyDeleteQuickfixVisual :<C-U>call myautoload#DeleteQuickfixOperator(visualmode())<CR>

nmap <silent> <buffer> d  <Plug>MyDeleteQuickfix
nmap <silent> <buffer> dd <Plug>MyDeleteQuickfixLine
vmap <silent> <buffer> d  <Plug>MyDeleteQuickfixVisual

set winhighlight=Normal:_qfNormal,LineNr:_qfLineNr,CursorLineNr:_qfCursorLineNr,CursorLine:_qfCursorLine
",StatusLine:_qfStatusLine,StatusLineNC:_qfStatusLineNC

