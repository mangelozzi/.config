" Note: With regards to dashes being considered a word (iskeyword) character,
" that is set via ftplugin

" Create text-object `A` which operates on the whole buffer (i.e. All)
" Keeps the cursor position in the same position
function TextObjectAll()
    let g:restore_position = winsaveview()
    normal! ggVG
    call feedkeys("\<Plug>(RestoreView)")
endfunction
onoremap A :<C-U>call TextObjectAll()<CR>
nnoremap <silent> <Plug>(RestoreView) :call winrestview(g:restore_position)<CR>
vnoremap A :<C-U>normal! ggVG<CR>

" Line Wise text objects (excludes the ending line char)
" g_ means move to the last printable char of the line
onoremap il :<C-U>normal! ^vg_<Cr>
onoremap al :<C-U>normal! 0vg_<Cr>
vnoremap il :<C-U>normal! ^vg_<Cr>
vnoremap al :<C-U>normal! 0vg_<Cr>

