let testing = 0
if testing
    " When testing, wish to reload lua files, and reset global values
    hi RgFlowQfPattern    guifg=#A0FFA0   guibg=#000000 gui=bold ctermfg=15 ctermbg=0, cterm=bold
    hi RgFlowHead         guifg=white guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
    hi RgFlowHeadLine     guifg=#00CC00 guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
    hi RgFlowInputBg      guifg=black guibg=white ctermfg=0 ctermbg=15
    hi RgFlowInputFlags   guifg=gray  guibg=white ctermfg=8 ctermbg=15
    hi RgFlowInputPattern guifg=green guibg=white gui=bold ctermfg=2 ctermbg=15 cterm=bold
    hi RgFlowInputPath    guifg=black guibg=white ctermfg=0 ctermbg=15
    let g:rgflow_flags = "--smart-case"
    let g:rgflow_set_incsearch = 1
    let g:rgflow_mark_str = "▉"

    " lua rgflow = dofile("C:/Users/Michael/.config/nvim/nvim-rgflow.lua/lua/rgflow.lua")
    lua rgflow = dofile("/home/michael/.config/nvim/nvim-rgflow.lua/lua/rgflow.lua")
else
    " When not testing, dont use cached setup
    if exists('g:loaded_rgflow')
        finish
    endif

    " HILIGHTING GROUPS
    if !hlexists('RgFlowQfPattern')
        hi RgFlowQfPattern    guifg=#A0FFA0 guibg=#000000 gui=bold ctermfg=15 ctermbg=0, cterm=bold
    endif
    if !hlexists('RgFlowHead')
        hi RgFlowHead         guifg=white   guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
    endif
    if !hlexists('RgFlowHeadLine')
        hi RgFlowHeadLine     guifg=#00CC00 guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
    endif
    if !hlexists('RgFlowInputBg')
        " Even though just a background, add the foreground or else when
        " appending cant see the insert cursor
        hi RgFlowInputBg      guifg=black   guibg=white ctermfg=0 ctermbg=15
    endif
    if !hlexists('RgFlowInputFlags')
        hi RgFlowInputFlags   guifg=gray    guibg=white ctermfg=8 ctermbg=15
    endif
    if !hlexists('RgFlowInputPattern')
        hi RgFlowInputPattern guifg=green   guibg=white gui=bold ctermfg=2 ctermbg=15 cterm=bold
    endif
    if !hlexists('RgFlowInputPath')
        hi RgFlowInputPath    guifg=black   guibg=white ctermfg=0 ctermbg=15
    endif

    " DEFAULT SETTINGS
    " Aapplied only if not already set
    " For some reason --no-messages makes it stop working
    let g:rgflow_flags = get(g:, 'rgflow_flags', '--smart-case')

    " After a search, whether to set incsearch to be the pattern searched for
    let g:rgflow_set_incsearch = get(g:, 'rgflow_set_incsearch', 1)

    " String to prepend when marking an entry in the quick fix
    let g:rgflow_mark_str = get(g:, 'rgflow_mark_str', '▉')

    lua rgflow = require('rgflow')
endif

" PLUG COMMANDS
" Map functions to commands, for easy mapping to hot keys
nnoremap <Plug>RgflowDeleteQuickfix       :<C-U>set  opfunc=v:lua.rgflow.del_operator<CR>g@
nnoremap <Plug>RgflowDeleteQuickfixLine   :<C-U>call v:lua.rgflow.del_operator('line')<CR>
vnoremap <Plug>RgflowDeleteQuickfixVisual :<C-U>call v:lua.rgflow.del_operator(visualmode())<CR>
nnoremap <Plug>RgflowMarkQuickfixLine     :<C-U>call v:lua.rgflow.mark_operator(v:true, 'line')<CR>
vnoremap <Plug>RgflowMarkQuickfixVisual   :<C-U>call v:lua.rgflow.mark_operator(v:true, visualmode())<CR>
nnoremap <Plug>RgflowUnmarkQuickfixLine   :<C-U>call v:lua.rgflow.mark_operator(v:false, 'line')<CR>
vnoremap <Plug>RgflowUnmarkQuickfixVisual :<C-U>call v:lua.rgflow.mark_operator(v:false, visualmode())<CR>

" KEY MAPPINGS
" Rip grep in files, use <cword> under the cursor as starting point
nnoremap <leader>rg :<C-U>lua rgflow.search('n')<CR>
" Rip grep in files, use visual selection as starting point
xnoremap <leader>rg :<C-U>call v:lua.rgflow.search(visualmode())<Cr>

let g:loaded_rgflow = 1
