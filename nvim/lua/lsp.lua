print("hello from lsp.lua")

local map_key = function(mode, key, func)
  vim.fn.nvim_buf_set_keymap(0, mode, key, func, {noremap = true, silent = true})
end

local on_attach = function()
    vim.api.nvim_command('setlocal signcolumn=auto:1')
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach()
    require'diagnostic'.on_attach()

    -- if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'lua' then
    --     <not lua type maps here>
    -- end
    -- gl is free! Mnemonic: Go Lsp
    -- <C-k> conflights with

    -- Yes: pyls_ms
    map_key('n', 'K',           '<cmd>lua vim.lsp.buf.hover()<CR>')
    -- Yes: pyls_ms
    map_key('n', '<c-]>',       '<cmd>lua vim.lsp.buf.definition()<CR>')
    -- gr conflicts with Go Register, but changed go register to gl (go lekker!)
    -- Yes: pyls_ms
    map_key('n', 'gr',          '<cmd>lua vim.lsp.buf.references()<CR>')
    -- Yes: pyls_ms, worked if there were multiple references
    map_key('n', '<leader>cr',  '<cmd>lua vim.lsp.buf.rename()<CR>')-- from ":help lsp
    -- Yes: pyls_ms
    map_key('n', '<leader>sl',  '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')

    -- No: pyls_ms
    map_key('n', 'gD',          '<cmd>lua vim.lsp.buf.implementation()<CR>')
    -- No: pyls_ms
    map_key('n', '1gD',         '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- No: pyls_ms
    map_key('n', '<leader>gd',  '<cmd>lua vim.lsp.buf.definition { callbacks = { Location.jump_first, Location.highlight.with { timeout = 300 } } }<CR>')
    -- No: pyls_ms
    map_key('n', '<leader>pd',  '<cmd>lua vim.lsp.buf.definition { callbacks = Location.preview.with { lines_below = 5 } }<CR>')
    -- No: pyls_ms
    map_key('i', '<leader>sl',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')

    -- Not sure: pyls_ms
    map_key('n', '<leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map_key('n', '<leader>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- nnoremap <silent> <LEADER>ld  <cmd>lua vim.lsp.buf.declaration()<CR>

    -- Rust is currently the only thing w/ inlay hints
    if vim.api.nvim_buf_get_option(0, 'filetype') == 'rust' then
	vim.cmd [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { aligned = true, prefix = " » " }]]
    end

    -- ASCII 23 = CTRL+W
    --or vim.api.nvim_input('\23k'))<CR>
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- List symbols in the current document matching the query string.
    -- nnoremap <silent> <LEADER>l?  <cmd>lua vim.lsp.buf.document_symbol()<CR>
    -- List project-wide symbols matching the query string.
    -- nnoremap <silent> <LEADER>lw  <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    -- From https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.vim
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wl', '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
end

require('nvim_lsp').html.setup {on_attach = on_attach}
require('nvim_lsp').cssls.setup {on_attach = on_attach}
require('nvim_lsp').jsonls.setup {on_attach = on_attach}
require('nvim_lsp').bashls.setup {on_attach = on_attach}
require('nvim_lsp').vimls.setup {on_attach = on_attach}
require('nvim_lsp').tsserver.setup {on_attach = on_attach}

-- Refer to https://github.com/neovim/nvim-lspconfig#pyls_ms
require('nvim_lsp').pyls_ms.setup {
    on_attach = on_attach,
    root_dir = function() return '/home/michael/linkcube/src' end,
    init_options = {
         interpreter = {
             properties = {
                 InterpreterPath = "/home/michael/venv/linkcube/bin/python",
                 Version = "3.8"
             }
         }
     }
}
-- Jedi LS Only provides syntax errors, not powerful diagnostics
-- require('nvim_lsp').jedi_language_server.setup {on_attach = on_attach}

-- {'pyflakes','rope','mccabe','black','flake8','pycodestyle',autopep8','yapf'}
-- configurationSources kiad sources files
-- require'nvim_lsp'.pyls.setup {
--     on_attach = on_attach,
--     settings = {
--       pyls = {
--         configurationSources = {},
--         plugins = {
--           pyflakes = {enabled = true},
--           rope     = {enabled = true},
--           mccabe   = {enabled = true},
--           black    = {enabled = true},
--           -- jedi_signature_help = {enabled = false}, -- stupid slow
--           flake8   = {enabled = false},
--           pycodestyle = {enabled = false, maxLineLength = 88},
--           autopep8    = {enabled = false},
--           yapf        = {enabled = false}
--         }
--       }
--     }
--   }
