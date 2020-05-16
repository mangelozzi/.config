" To execute VimL from Lua:
" :lua vim.api.nvim_command('echo "Hello, Nvim!"')
" :lua vim.api.nvim_call_function("namemodify', {fname, ':p'})
" To see contents of a table use: print(vim.inspect(table))
" Consider tree sitter for auto copmlete: parser = vim.treesitter.get_parser(bufnr, lang)
" local foo = vim.fn.getpos("[") and then foo[1],…,foo[4]

let testing = 1
if testing
    " When testing, wish to reload lua files, and reset global values
    hi RgFlowHead guifg=white guibg=black gui=bold, ctermfg=15, ctermbg=0, cterm=bold
    hi RgFlowInput guifg=black guibg=white ctermfg=0, ctermbg=15
    let g:rgflow_flags = "--smart-case"
    let g:rgflow_set_incsearch = 1
    "lua package.loaded.rgflow = nil
    let g:rgflow_mark_str = "■"
    let g:rgflow_test = 123

    lua rgflow = dofile("C:/Users/Michael/.config/nvim/nvim-rgflow.lua/lua/rgflow.lua")
    lua rgflow.test()
else
    " When not testing, dont use cached setup
    if exists('g:loaded_rgflow')
        finish
    endif
    if !hlexists('RgFlowHead')
        " Highlighting group for the input dialogue headings
        hi RgFlowHead guifg=white guibg=black gui=bold, ctermfg=15, ctermbg=0, cterm=bold
        echom "set RgFlowHead"
    endif

    if !hlexists('RgFlowInput')
        " Highlighting group for the input dialogue input text
        hi RgFlowInput guifg=black guibg=white ctermfg=0, ctermbg=15
        echom "set RgFlowInput"
    endif

    " Default settings, if not set yet
    " For some reason --no-messages makes it stop working
    let g:rgflow_flags = get(g:, 'rgflow_flags', "--vimgrep --smart-case --no-messages")

    " After a search, whether to set incsearch to be the pattern searched for
    let g:rgflow_set_incsearch = get(g:, 'rgflow_set_incsearch', 1)

    " String to prepend when marking an entry in the quick fix
    let g:rgflow_mark_str = get(g:, 'rgflow_mark_str', "■")

    lua rgflow = require("rgflow")
endif

" Rip grep in files, use <cword> under the cursor as starting point
nnoremap <leader>rg :<C-U>lua rgflow.search('n')<CR>

" Rip grep in files, use visual selection as starting point
xnoremap <leader>rg :<C-U>call v:lua.rgflow.search(visualmode())<Cr>

" Map functions to commands, for easy mapping to hot keys
nnoremap <Plug>RgflowDeleteQuickfix       :<C-U>set  opfunc=v:lua.rgflow.del_operator<CR>g@
nnoremap <Plug>RgflowDeleteQuickfixLine   :<C-U>call v:lua.rgflow.del_operator('line')<CR>
vnoremap <Plug>RgflowDeleteQuickfixVisual :<C-U>call v:lua.rgflow.del_operator(visualmode())<CR>
nnoremap <Plug>RgflowMarkQuickfixLine     :<C-U>call v:lua.rgflow.mark_operator(v:true, 'line')<CR>
vnoremap <Plug>RgflowMarkQuickfixVisual   :<C-U>call v:lua.rgflow.mark_operator(v:true, visualmode())<CR>
nnoremap <Plug>RgflowUnmarkQuickfixLine   :<C-U>call v:lua.rgflow.mark_operator(v:false, 'line')<CR>
vnoremap <Plug>RgflowUnmarkQuickfixVisual :<C-U>call v:lua.rgflow.mark_operator(v:false, visualmode())<CR>

" in init.vim
" command! -nargs=+ -complete=dir -bar Grep lua rgflow.asyncGrep(<q-args>)

" lua rgflow.search()

let g:loaded_rgflow = 1
" lua <<EOF
" rgflow_settings = {
" -- For each search, ask which dir to use (if false will use cwd)
" dir_ask = true,
"
" -- Examples of other possible flags:
" --   -F=no regex, -L=follow symlinks, --hidden=hidden files, --no-ignore=incl.Non VC files, --no-messages=no IO errors, --trim=Leading whitespace, -s=case sensitive, -i=ignore case"
" flags = "--smart-case --no-messages",
"
" -- For each search, after asking for the pattern and then path, whether to
" -- give the opertunity to alter the flags.
" flags_ask = false,
"
" mark_str = "■",
"
" default_hotkeys = true,
" }
" -- print(vim.inspect(rgflow_settings))
" EOF

