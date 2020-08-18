" {{{1 DOCSTRING
" If get error ould not read Username for ... probably type the plugin name wrong

" TO TRY
" LOOK AWESOME!!! https://github.com/iamcco/markdown-preview.nvim
" Plug 'vim-scripts/indentpython.vim'    " https://github.com/vim-scripts/indentpython
" https://github.com/janko/vim-test
" https://github.com/EinfachToll/DidYouMean
" https://github.com/justinmk/vim-sneak
" https://github.com/tpope/vim-repeat
" https://github.com/simnalamburt/vim-mundo

" Indicator for what was yanked
" Plug 'machakann/vim-highlightedyank'

" Aligning stuff
" Plug 'junegunn/vim-easy-align'


" ABANDONDED - Autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'carlitux/deoplete-ternjs'
" Plug 'davidhalter/jedi-vim'
" Plug 'scrooloose/nerdcommenter'
" Plug 'neomake/neomake'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_enabled = 0

" {{{1 PLUGINS
" Vim-plug installation
"   Step 1. Download https://github.com/junegunn/vim-plug -> plug.vim
"   Step 2. Place vim.plug in C:\Users\Michael\AppData\Local\nvim\autoload\
"               Note: E:\Dropbox\Software\neovim\nvim\ is symlinked to C:\Users\Michael\AppData\Local\nvim\
"   Step 3. Run the command --> :PlugInstall


" Using linux app image we dont have access to $VIM
let plugdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/vim-plug"
call plug#begin(plugdir)
"call plug#begin('$VIM\vim-plug')
" Only place plug items within here or else can get weird errors with some packages

" Plug own plugin at nvim/tmp/nvim-rgflow.lua
let rgflow_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/nvim-rgflow.lua"
Plug rgflow_local

" Plug own plugin at nvim/tmp/vim-wsl
let wsl_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/vim-wsl"
Plug wsl_local

" Plug own plugin at nvim/tmp/vim-capesky
let wsl_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/vim-capesky"
Plug wsl_local

" {{{2 OPERATOR + MOTION + TEXT-OBJECT = AWESOME
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-titlecase'

" {{{2 SMALL MISC
Plug 'tpope/vim-unimpaired'
Plug 'AndrewRadev/bufferize.vim'

" {{{2 CCOLOR RELATED
Plug 'norcalli/nvim-colorizer.lua'
Plug 'pangloss/vim-javascript'
" Plug 'zefei/vim-colortuner'

" {{{2 SPELLCHECK EXTRAS
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'

" {{{2 GIT
Plug 'tpope/vim-fugitive'

" {{{2 FZF
let fzfdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/fzf"
" Plug 'junegunn/fzf', { 'dir': fzfdir, 'do': './install --all' }
" Install FZF via scoop
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" {{{2 TREE BROWSER
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
" TODO: Could replace syntax tree highligthing with this:
" https://github.com/preservim/nerdtree/issues/433#issuecomment-92590696
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'kshenoy/vim-signature', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin'

" {{{2 Python
Plug 'tmhedberg/SimpylFold'

" {{{2 LSP
"Plug 'Shougo/deoplete.nvim'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'

" {{{2 Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

call plug#end()


" {{{1 OPERATOR + MOTION + TEXT-OBJECT = AWESOME

" {{{2 SURROUND
" https://github.com/tpope/vim-surround
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=24m42
" s = (surrounding) Creates a text-object
" ys = Add surround
" yss = Add surrounding to current line
" If changing to a bracket, left brackets means bracket with space, right bracket means just the bracket
" e.g. ysiw" = Add surround - inner word - double quote
" e.g. cst<div> = Change surround <span> to <div>

" {{{2 COMMENTARY
" https://github.com/tpope/vim-commentary
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m02
" gc = comment
" gcc = comment out a line
" gcgc = Uncomment above, else below line

" {{{2 vim-eunuch
" Vim sugar for the UNIX shell commands that need it the most:
" :Delete:    Delete a buffer and the file on disk simultaneously.
" :Unlink:    Like :Delete, but keeps the now empty buffer.
" :Move:      Rename a buffer and the file on disk simultaneously.
" :Rename:    Like :Move, but relative to the current file's containing directory.
" :Chmod:     Change the permissions of the current file.
" :Mkdir:     Create a directory, defaulting to the parent of the current file.
" :Cfind:     Run find and load the results into the quickfix list.
" :Clocate:   Run locate and load the results into the quickfix list.
" :Lfind/:Llocate: Like above, but use the location list.
" :Wall:      Write every open window. Handy for kicking off tools like guard.
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit:  Edit a privileged file with sudo.

" {{{2 vim-repeat
" using the . will repeat plugin maps for vim surround, and vim unimpaired
" Normally the . just repeats the last operators that fired within the plugin.
" https://github.com/tpope/vim-repeat

" {{{2 REPLACE WITH REGISTER
" https://github.com/vim-scripts/ReplaceWithRegister
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m49
" [count]["x]gr{motion} = Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr        = Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr        = Replace the selection with the contents of register x.

" {{{2 TITLECASE
" https://github.com/christoomey/vim-titlecase
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=27m40
" Create operator to title case over a range
" gT = Title case
" gTT = Title case the whole line
" e.g. "foo bar" -> "Foo Bar"
" gT used for switching buffers, disable default hotkeys with:
let g:titlecase_map_keys = 0
" Menomic h = heading
map gh <Plug>Titlecase
map gH <Plug>TitlecaseLine
vmap gh <Plug>Titlecase
vmap gH <Plug>Titlecase

" {{{1 OWN PLUGINS
" {{{2 CAPESKY
let g:capesky_profiles = [
            \[  5, -30, -15, -30],
            \[  5, -28, -12, -20],
            \[  5, -25,  -5, -15],
            \[  5, -15,  -8,  -8],
            \[  5,  -8,   0,  -5],
            \[  0,   0,   0,   0],
            \[  0, +10, +10, +10],
            \]
let g:capesky_index = get(g:, 'capesky_index', 4)

" {{{1 TREE BROWSER

" {{{2 NERDTree
"   See :help NERDTree
"   https://github.com/preservim/nerdtree
"   https://jdhao.github.io/2018/09/10/nerdtree_usage/
"   Hotkeys:
"     ? = show help on commands
"     u = up a level
"     c = change CWD to select dir
"     O / X = Open/Close recursively
"     J / K = Move to first/last nodes
"     ^J / ^K = Move to next/previous nodes on same level

" Show NERDTree at CWD
nnoremap <leader>nn :NERDTreeToggle<CR>

" Find file and show within CWD
nnoremap <leader>nf :NERDTreeFind<CR>

" Change NERDTree Browse - Open.browse to current buffer dir
nnoremap <leader>nd :NERDTreeToggle %:p:h<CR>

" Automatically close NerdTree when you open a file
" let NERDTreeQuitOnOpen = 1
" let NERDTreeMapCustomOpen = "<F10>" " Default <CR>
let NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 'p', 'keepopen':0, 'stay':0}}
" let NERDTreeCustomOpenArgs = {'file':{'where':'p','keepopen':0,'stay':1}}

" Automatically close a tab if the only remaining window is NerdTree
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Show hidden/dot files
" let NERDTreeShowHidden=1

" Just remember to press ? for help
let NERDTreeMinimalUI = 1

" the ignore patterns are regular expression strings and seprated by comma
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Highlight full name (not only icons). You need to add this if you don't have vim-devicons and want highlight.
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" {{{1 GIT

" {{{2 Git status (own unfishined attempt)
nnoremap <silent> <leader>gs :Git status<cr>

" {{{1 FZF
" ==============================================================================
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=20m10s
" To search within a dir `:FZF [dir] <CR>`

" if has('win32') || has('win64')
"     " If installed using Homebrew
"     set rtp+=$HOME\scoop\apps\fzf\current
" else
"     " set rtp+= I dont know
" end
let $FZF_DEFAULT_OPTS='--bind ctrl-a:select-all'

"let $FZF_DEFAULT_COMMAND='rg --files . 2> nul'
let $FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'

" Don't abort the function, so if no match is found, its communicates it.
nnoremap <silent> <leader>zn :copen<CR> :call clearmatches()<CR>

" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=21m42s
" CTRL+P and CTRL+N previous/next file
" TAB /SHIFT TAB to toggle marking
" CTRL+A to select all matches
" <ENTER> open all marked files in a quickfix window
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
" When aborting fzf in Neovim, <Esc> does not work, so fix it:
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"


" Allow passing optional flags into the Rg command.
"   Example: :Rg foo -g '*.py'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

" Files
" FZF in Open buffers
nnoremap <silent> <leader><leader> :Buffers<cr>

" FZF Search for Files
nnoremap <silent> <leader>f :Files<cr>

" FZF Search for Files in home dir
nnoremap <silent> <leader>~ :Files ~<cr>

" FZF Search for previous opened Files
nnoremap <silent> <leader>zh :History<cr>

" FZF in Git files
nnoremap <silent> <leader>zg :GFiles<cr>

" Map to FZF command, so one can type commands interactively before enter.
nnoremap <leader>zz :FZF<Space>

" Map to Rg command, so one can type commands interactively before enter.
nnoremap <leader>zr :Rg<Space>HighlightSearchTerm<CR>

" FZF in Lines in loaded buffers
nnoremap <silent> <leader>l :Lines<cr>

" FZF in Lines in the current buffer
nnoremap <silent> <leader>b :BLines<cr>

" Normal mode mappings
nnoremap <silent> <leader>zm :Maps<cr>

let g:fzf_colors =
            \ { 'fg':    ['fg', '_FzfNormal'],
            \ 'bg':      ['bg', '_FzfNormal'],
            \ 'hl':      ['fg', '_FzfHl'],
            \ 'fg+':     ['fg', '_FzfPlus'],
            \ 'bg+':     ['bg', '_FzfPlus'],
            \ 'hl+':     ['fg', '_FzfHlPlus'],
            \ 'info':    ['fg', '_FzfInfo'],
            \ 'border':  ['fg', '_FzfBorder'],
            \ 'prompt':  ['fg', '_FzfPrompt'],
            \ 'pointer': ['fg', '_FzfPointer'],
            \ 'marker':  ['fg', '_FzfMarker'],
            \ 'spinner': ['fg', '_FzfSpinner'],
            \ 'header':  ['fg', '_FzfHeader']}

" Set the FZF status line
augroup Fzf_Status_Line
    autocmd!
    autocmd User FzfStatusLine setlocal statusline=%#_FzfStatusChevron#\ >\ %#_fzfStatus#fzf
augroup END

" {{{1 SMALL MISC

" {{{2 VIM-UNIMPAIRED
" https://github.com/tpope/vim-unimpaired
" [q ]q               cprevious / cnext
" [f ]f               previous/next file in the current dir
" [n ]n               previous/next SCM conflict marker or diff/patch hunk. Try d[n inside a conflict.
" [l ]l               previous/next line error (e.g. CoC completion error.
" [<space> ]<space>   Add [count] blank lines above/below the cursor.
" [x{motion}          XML encode, e.g. <foo bar="baz"> => &lt;foo bar=&quot;baz&quot;&gt;
" ]x{motion}          XML decode
" [e ]e = Exchange the current line with [count] lines above/below it.
" and many more, e.g. url, c string encode, and many other options toggle

" {{{2 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 0 " Preview docstring in fold text  0
let g:SimpylFold_fold_docstring    = 0 " Fold docstrings 1
let g:SimpylFold_fold_import       = 0 " Fold imports    1

" {{{2 'Xuyuanp/nerdtree-git-plugin'
" ●✗
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "⚠",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "●",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }

" {{{2 vim-multiple-cursors
"   https://github.com/terryma/vim-multiple-cursors
"   Multicursor support
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" {{{2 AndrewRadev/bufferize.vim
" Pipe the output of commands into a buffer, e.g.
" :Bufferize messages
" :Bufferize hi
" :Bufferize messages
" :Bufferize digraphs
" :Bufferize map
" :Bufferize command

" {{{2 norcalli/nvim-colorizer.lua
" Colour background
" mode = foreground or background
lua << EOF
    require 'colorizer'.setup({}, {
        mode = 'background';
    })
EOF
" {{{2 Plug 'inkarkat/vim-SpellCheck'
" Can see a list of mispelt word with: :[range]SpellCheck

" {{{1 LSP

" {{{2 CoC
" To Edit Config File: :CocConfig, save then :CocRestart
" CocList extensions

" Python        coc-python
" JavaScript    coc-tsserver coc-eslint
" Webcoc-html   coc-html coc-css
" Misc Formats  coc-json coc-svg coc-markdownlint
" To try        coc-snippets coc-pairs coc-prettier

" Specify with extensions to use
" Can check with :CocList extensions
let g:coc_global_extensions = [
            \ 'coc-python',
            \ 'coc-tsserver',
            \ 'coc-eslint',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-json',
            \ 'coc-svg',
            \ 'coc-markdownlint',
            \ ]

let g:coc_filetype_map = {
            \ 'htmldjango': 'html',
            \ }
" Own vim file for all the coc settings (based on the provided settings file)
if get(g:, 'coc_enabled', 0)
    source <sfile>:h/coc.vim
endif

" {{{2 DEOPLETE (better autocomplete popup)
let g:deoplete#enable_at_startup = 1

" {{{2 NVIM-LSP (Configuration)
" Install
"
" tsserver requires: sudo npm install -g typescript
" Configurations: https://github.com/neovim/nvim-lsp#configurations
"
if &runtimepath =~? 'nvim-lsp'
    " Note, require needs no .lua ext. doFile requies it
lua << EOF
  local on_attach = function()
    vim.api.nvim_command('setlocal signcolumn=auto:1')
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach()
    require'diagnostic'.on_attach()
  end
require('nvim_lsp').html.setup {on_attach = on_attach}
require('nvim_lsp').cssls.setup {on_attach = on_attach}
require('nvim_lsp').jsonls.setup {on_attach = on_attach}
require('nvim_lsp').bashls.setup {on_attach = on_attach}
require('nvim_lsp').tsserver.setup {on_attach = on_attach}
require('nvim_lsp').vimls.setup {on_attach = on_attach}
require('nvim_lsp').pyls_ms.setup {on_attach = on_attach}
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
EOF

    " from ":help lsp
    " gl is free! Mnemonic: Go Lsp
    " gr conflicts with Go Register
    " <C-k> conflights with
    nnoremap <silent> <LEADER>ld  <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <LEADER>le  <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <LEADER>lh  <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <LEADER>li  <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <LEADER>ls  <cmd>lua vim.lsp.buf.signature_help()<CR>
    " ASCII 23 = CTRL+W
    "or vim.api.nvim_input('\23k'))<CR>
    nnoremap <silent> <LEADER>lt  <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <LEADER>lr  <cmd>lua vim.lsp.buf.references()<CR>
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    " List symbols in the current document matching the query string.
    " nnoremap <silent> <LEADER>l?  <cmd>lua vim.lsp.buf.document_symbol()<CR>
    " List project-wide symbols matching the query string.
    " nnoremap <silent> <LEADER>lw  <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> <LEADER>lf  <cmd>lua vim.lsp.buf.formatting()<CR>

    " From https://github.com/mjlbach/nix-dotfiles/blob/master/nixpkgs/configs/neovim/init.vim
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', 'wl', '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>', opts)
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    " vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
endif

" {{{2 NVIM-LSP / COMPLETITON
if &runtimepath =~? 'nvim-lsp'
    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect
    " set completeopt=menuone,noinsert
    " possible value: "length", "alphabet", "none"
    let g:completion_sorting = "length"
    let g:completion_trigger_keyword_length = 3 " default = 1
    let g:completion_items_priority = {
          \ 'Field': 5,
          \ 'Function': 7,
          \ 'Variables': 7,
          \ 'Method': 10,
          \ 'Interfaces': 5,
          \ 'Constant': 5,
          \ 'Class': 5,
          \ 'Keyword': 4,
          \ 'UltiSnips' : 1,
          \ 'vim-vsnip' : 0,
          \ 'Buffers' : 1,
          \ 'TabNine' : 0,
          \ 'File' : 0,
          \}
endif

" {{{2 NVIM-LSP / DIAGONOSTIC

" If 0, then diagnostic information only shown when you go Next/PrevDiagnostic
" If 1, then diagnostic information will be shown after the line.

" let g:diagnostic_trimmed_virtual_text = '20'
" let g:diagnostic_show_sign = 1 " default 1
" let g:diagnostic_sign_priority = 20 " default 20
" call sign_define("LspDiagnosticsErrorSign",         {"text" : "E", "texthl" : "LspDiagnosticsError"})
" call sign_define("LspDiagnosticsWarningSign",       {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
" call sign_define("LspDiagnosticsInformationSign",   {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
" call sign_define("LspDiagnosticsHintSign",          {"text" : "H", "texthl" : "LspDiagnosticsHint"})
" let g:diagnostic_enable_underline = 1 " default 1
" PrevDiagnostic
" NextDiagnostic
nnoremap <LEADER>dn    <cmd>NextDiagnosticCycle<CR>
nnoremap <LEADER>dj    <cmd>NextDiagnosticCycle<CR>
nnoremap <LEADER>dp    <cmd>PrevDiagnosticCycle<CR>
nnoremap <LEADER>dk    <cmd>PrevDiagnosticCycle<CR>
nnoremap <LEADER>do    <cmd>OpenDiagnostic<CR>
" Mnemonic Diagnostic List
nnoremap <LEADER>dl    <cmd>OpenDiagnostic<CR>

function! SetDiagosticSettings()
    " setlocal omnifunc=v:lua.vim.lsp.omnifunc
    redraw
    if &ft ==? "vim"
        " In VIM with normal diagonistics settings, its unusable to debug.
        let g:diagnostic_enable_virtual_text = 0 " default 1, 1 for py, 0 for vim?
        let g:diagnostic_insert_delay = 1        " default 0, 1 = don't want to show diagnostics while in insert mode
    else
        let g:diagnostic_enable_virtual_text = 1 " default 1, 1 for py, 0 for vim?
        let g:diagnostic_insert_delay = 0        " default 0, 1 = don't want to show diagnostics while in insert mode
    endif
endfun

augroup my_diagnostic_autocmds
    " Defaut omni-complete hotkey: i_^x^o
    autocmd!
    autocmd BufEnter * :call SetDiagosticSettings()
augroup END

