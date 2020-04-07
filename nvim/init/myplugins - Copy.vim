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


" TO TRY
" Plug 'tpope/vim-surround'              " https://github.com/tpope/vim-surround
" Plug 'vim-scripts/indentpython.vim'    " https://github.com/vim-scripts/indentpython

" ABANDONDED
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'carlitux/deoplete-ternjs'
" Plug 'davidhalter/jedi-vim'
" Plug 'neomake/neomake'


" ==============================================================================
" SMALL PLUGINS
" ==============================================================================
" Allow key chords
Plug 'kana/vim-arpeggio'
" jk or df  for escape


" https://github.com/kshenoy/vim-signature
" Show marks in line column
Plug 'kshenoy/vim-signature', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

Plug 'tpope/vim-unimpaired'            " https://github.com/tpope/vim-unimpaired

" ==============================================================================
" FZF (Fuzzy Finding)
" ==============================================================================
let fzfdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/fzf"
Plug 'junegunn/fzf', { 'dir': fzfdir, 'do': './install --all' }
Plug 'junegunn/fzf.vim'


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
Plug 'tpope/vim-surround'

" ______________________________________________________________________________
" PLUGIN: COMMENTARY
" https://github.com/tpope/vim-commentary
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m02
" gc = comment
" gcc = comment out a line
" gcgc = Uncomment above, else below line
Plug 'tpope/vim-commentary'

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
Plug 'vim-scripts/ReplaceWithRegister'

" ______________________________________________________________________________
" PLUGIN: TITLECASE
" https://github.com/christoomey/vim-titlecase
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=27m40
" Create operator to title case over a range
" gT = Title case
" e.g. "foo bar" -> "Foo Bar"
Plug 'christoomey/vim-titlecase'

" ______________________________________________________________________________
" PLUGIN: ENTIRE
" https://github.com/kana/vim-textobj-entire
" Requires: https://github.com/kana/vim-textobj-entire
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=31m08
" Creates text-objects for the entire buffer
" ae = entire buffer
" ie = like ae but leading and trailing empty lines are excluded.
" Make just `e` ro vw `ae` by default
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
omap e ae

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
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

" Show NERDTree at CWD
nnoremap <leader>nn :NERDTreeToggle<CR>
" Find file and show within CWD
nnoremap <silent> <leader>nf :NERDTreeFind<CR>
" Change NERDTree Browse - Open.browse to current buffer
" nnoremap <leader>nb :NERDTreeToggle %:p:h<CR>

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

" ______________________________________________________________________________
" PLUGIN: 'Xuyuanp/nerdtree-git-plugin'
" ●✗
Plug 'Xuyuanp/nerdtree-git-plugin'
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
" PLUGIN: 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

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
" Webcoc-html   coc-css
" Misc Formats  coc-json coc-svg markdownlint
" To try        coc-snippets coc-pairs coc-prettier
 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
call plug#end()
call arpeggio#map('i', '', 0, 'jk', '<Esc>')
call arpeggio#map('i', '', 0, 'kj', '<Esc>')
call arpeggio#map('i', '', 0, 'df', '<Esc>')
call arpeggio#map('i', '', 0, 'fd', '<Esc>')
