" To execute VimL from Lua:
" :lua vim.api.nvim_command('echo "Hello, Nvim!"')
" :lua vim.api.nvim_call_function("namemodify', {fname, ':p'})
" To see contents of a table use: print(vim.inspect(table))
" Consider tree sitter for auto copmlete: parser = vim.treesitter.get_parser(bufnr, lang)
" local foo = vim.fn.getpos("[") and then foo[1],…,foo[4]





" WHOILE DEBUGGING NOT HELPGFUL!!!
" if exists('g:loaded_rgflow')
"     finish
" endif

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
    hi RgFlowHead guifg=white guibg=black gui=bold, ctermfg=15, ctermbg=0, cterm=bold
    hi RgFlowInput guifg=black guibg=white ctermfg=0, ctermbg=15

" Default settings, if not set yet
let g:rgflow_flags = get(g:, 'rgflow_flags', "--smart-case --no-messages")

"lua package.loaded.rgflow = nil
let g:rgflow_test = 123

lua rgflow = require("rgflow")


" Rip grep in files, use <cword> under the cursor as starting point
nnoremap <leader>rg :<C-U>lua rgflow.search('n')<CR>

" Rip grep in files, use visual selection as starting point
xnoremap <leader>rg :<C-U>call v:lua.rgflow.search(visualmode())<Cr>

" lua rgflow.search()

let g:loaded_rgflow = 12
lua <<EOF
rgflow_settings = {
    -- For each search, ask which dir to use (if false will use cwd)
    dir_ask = true,

    -- Examples of other possible flags:
    --   -F=no regex, -L=follow symlinks, --hidden=hidden files, --no-ignore=incl.Non VC files, --no-messages=no IO errors, --trim=Leading whitespace, -s=case sensitive, -i=ignore case"
    flags = "--smart-case --no-messages",

    -- For each search, after asking for the pattern and then path, whether to
    -- give the opertunity to alter the flags.
    flags_ask = false,

    mark_str = "■",

    default_hotkeys = true,
}
-- print(vim.inspect(rgflow_settings))
EOF
