--[[
See for jobstart!!!
https://teukka.tech/vimloop.html

nvim_buf_add_highlight()

To execute VimL from Lua:
:lua vim.api.nvim_command('echo "Hello, Nvim!"')
:lua vim.api.nvim_call_function("namemodify', {fname, ':p'})
To see contents of a table use: print(vim.inspect(table))
Consider tree sitter for auto copmlete: parser = vim.treesitter.get_parser(bufnr, lang)
local foo = vim.fn.getpos("[") and then foo[1],…,foo[4]

Basically all such programs do the same: they set 'grepprg' and 'grepformat'

vim.{g,v,o,bo,wo}
vim.bo[0].bufhidden=hide

Command:  vim.api.nvim_command('startinsert')
Function: vim.fn.getcwd()

Auto complete algo
map tab to custom function, if line 2 call feedkeys hotkey for built in complete (ctrl-X ctrl-N)
3 complete functions: complete_rg_glags, complete_from_buffer, complete
depending on line number call corresponding set corresponding complete func
set completeopt accordingly to menu,preview, and load in preview

if dict file for rg does not exist, then create it

Depending on line, set 'completefunc' diffferent
setlocal completefunc=csscomplete#CompleteFA

echo:
nvim_out_write({str})
--]]

function create_hotkeys(buf)
    -- map-<cmd> does not change the mode

    -- Map tab to be general autocomplete flags/buffer/file depending on which line user is on
    api.nvim_buf_set_keymap(buf, "i", "<TAB>", "<cmd>lua rgflow.complete()<CR>", {noremap=true})

    -- Map <CR> to start search in normal and insert (not command) modes
    api.nvim_buf_set_keymap(buf, "", "<CR>", "<cmd>lua rgflow.start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "i", "<CR>", "<ESC><cmd>lua rgflow.start()<CR>", {noremap=true})

    -- When cursor at line end, press <DEL> should not join it with the next line
    api.nvim_buf_set_keymap(buf, "i", "<DEL>", "( col('.') == col('$') ? '' : '<DEL>')", {expr=true, noremap=true})

    -- When cursor at line start, press <BS> should not join it with the next line
    api.nvim_buf_set_keymap(buf, "i", "<BS>", "( col('.') == 1 ? '' : '<BS>')", {expr=true, noremap=true})

    -- Disable join lines
    api.nvim_buf_set_keymap(buf, "n", "J", "<NOP>", {noremap=true})

    -- nnoremap <buffer> <C-^>   <Nop>
-- nnoremap <buffer> <C-S-^> <Nop>
-- nnoremap <buffer> <C-6>   <Nop>

    -- Map various abort like keys to cancel search
    api.nvim_buf_set_keymap(buf, "n", "<ESC>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "n", "<C-]>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "n", "<C-C>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
end
