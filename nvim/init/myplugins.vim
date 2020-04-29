" TO TRY
" Plug 'vim-scripts/indentpython.vim'    " https://github.com/vim-scripts/indentpython
" https://github.com/janko/vim-test
" https://github.com/EinfachToll/DidYouMean
" https://github.com/justinmk/vim-sneak


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

"===============================================================================
" PLUG INS
"===============================================================================
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

" OPERATOR + MOTION + TEXT-OBJECT = AWESOME
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-titlecase'
"Plug 'kana/vim-textobj-user'
"Plug 'kana/vim-textobj-entire'

" SMALL MISC
Plug 'tpope/vim-unimpaired'
" Plug 'ap/vim-css-color' " Buggy, when save michael.vim theme, looses the coloring
Plug 'chrisbra/Colorizer'

" GIT
Plug 'tpope/vim-fugitive'

" FZF
let fzfdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/fzf"
Plug 'junegunn/fzf', { 'dir': fzfdir, 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" TREE BROWSER
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'kshenoy/vim-signature', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'neomake/neomake'
" LSP (Autocomplete)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

" Python
Plug 'tmhedberg/SimpylFold'

call plug#end()


" ==============================================================================
" OPERATOR + MOTION + TEXT-OBJECT = AWESOME
" ==============================================================================
" ______________________________________________________________________________
" PLUGIN: SURROUND
" https://github.com/tpope/vim-surround
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=24m42
" s = (surrounding) Creates a text-object
" ys = Add surround
" yss = Add surrounding to current line
" If changing to a bracket, left brackets means bracket with space, right bracket means just the bracket
" e.g. ysiw" = Add surround - inner word - double quote
" e.g. cst<div> = Change surround <span> to <div>

" ______________________________________________________________________________
" PLUGIN: COMMENTARY
" https://github.com/tpope/vim-commentary
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m02
" gc = comment
" gcc = comment out a line
" gcgc = Uncomment above, else below line
" ______________________________________________________________________________
" PLUGIN: vim-eunuch
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

" ______________________________________________________________________________
" PLUGIN: REPLACE WITH REGISTER
" https://github.com/vim-scripts/ReplaceWithRegister
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m49
" [count]["x]gr{motion} = Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr        = Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr        = Replace the selection with the contents of register x.

" ______________________________________________________________________________
" PLUGIN: TITLECASE
" https://github.com/christoomey/vim-titlecase
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=27m40
" Create operator to title case over a range
" gT = Title case
" e.g. "foo bar" -> "Foo Bar"

" ______________________________________________________________________________
" PLUGIN: ENTIRE
" Removed in favour of own mapping
" https://github.com/kana/vim-textobj-entire
" Requires: https://github.com/kana/vim-textobj-entire
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=31m08
" Creates text-objects for the entire buffer
" ae = entire buffer
" ie = like ae but leading and trailing empty lines are excluded.

" ==============================================================================
" SMALL MISC
" ==============================================================================
" ______________________________________________________________________________
" PLUGIN: VIM-UNIMPAIRED
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

" ==============================================================================
" TREE BROWSER
" ==============================================================================
" ______________________________________________________________________________
" PLUGIN: NERDTRee
"   https://github.com/scrooloose/nerdtree
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
let NERDTreeQuitOnOpen = 1
" Automatically close a tab if the only remaining window is NerdTree
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

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

" ==============================================================================
" GIT
" ==============================================================================
" Git status
nnoremap <silent> <leader>gs :Git status<cr>

" ==============================================================================
" FZF
" ==============================================================================
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=20m10s
" To search within a dir `:FZF [dir] <CR>`
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

let $FZF_DEFAULT_COMMAND = 'rg --files . 2> nul'

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

" FZF in Open buffers
nnoremap <silent> <leader><leader> :Buffers<cr>

" Files
" FZF in Open buffers
nnoremap <silent> <leader><leader> :Buffers<cr>

" FZF Search for Files
nnoremap <silent> <leader>f :Files<cr>

" FZF Search for previous opened Files
nnoremap <silent> <leader>zh :History<cr>

" FZF in Git files
nnoremap <silent> <leader>zg :GFiles<cr>

" Map to FZF command, so one can type commands interactively before enter.
" nnoremap <leader>zz :FZF<Space>

" Map to Rg command, so one can type commands interactively before enter.
nnoremap <leader>zr :Rg<Space>HighlightSearchTerm<CR>

" Files under current home
nnoremap <silent> <leader>zh :FZF ~<cr>

" FZF in Lines in loaded buffers
nnoremap <silent> <leader>zl :Lines<cr>

" FZF in Lines in the current buffer
nnoremap <silent> <leader>zb :BLines<cr>

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


" ______________________________________________________________________________
" PLUGIN: 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 0 " Preview docstring in fold text  0
let g:SimpylFold_fold_docstring    = 0 " Fold docstrings 1
let g:SimpylFold_fold_import       = 0 " Fold imports    1


" ______________________________________________________________________________
" PLUGIN: 'Xuyuanp/nerdtree-git-plugin'
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

" ______________________________________________________________________________
" PLUGIN: vim-multiple-cursors
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

" ______________________________________________________________________________
" PLUGIN: CoC
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
source <sfile>:h/coc.vim

" Colorizer
let g:colorizer_auto_color = 1
