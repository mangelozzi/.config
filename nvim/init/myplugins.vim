" TO TRY
" Plug 'vim-scripts/indentpython.vim'    " https://github.com/vim-scripts/indentpython

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
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-titlecase'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'

" SMALL MISC
Plug 'tpope/vim-unimpaired'
Plug 'ap/vim-css-color'

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
" FZF
" ==============================================================================
" nnoremap <silent> <leader>f :FZF<cr>

" Files under current home
" nnoremap <silent> <leader>F :FZF ~<cr>

" Files
nnoremap <silent> <leader>f :Files<cr>

" FZF in Git files
nnoremap <silent> <leader>g :GFiles<cr>

" FZF in Open buffers
nnoremap <silent> <leader><leader> :Buffers<cr>

" FZF in Lines in loaded buffers
nnoremap <silent> <leader>zl :Lines<cr>

" FZF in Lines in the current buffer
nnoremap <silent> <leader>zb :BLines<cr>

" Normal mode mappings
nnoremap <silent> <leader>zm :Maps<cr>




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