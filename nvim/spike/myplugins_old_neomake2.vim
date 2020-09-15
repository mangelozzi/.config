"=========================================================
" PLUG INS
"=========================================================
" Vim-plug installation
"   Step 1. Download https://github.com/junegunn/vim-plug -> plug.vim
"   Step 2. Place vim.plug in C:\Users\Michael\AppData\Local\nvim\autoload\
"               Note: E:\Dropbox\Software\neovim\nvim\ is symlinked to C:\Users\Michael\AppData\Local\nvim\
"   Step 3. Run the command --> :PlugInstall
" :CocInstall coc-python
" 
" :CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-html
 

" call plug#begin('~/AppData/Local/nvim/plugged')
call plug#begin('$VIM\vim-plug')
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'kshenoy/vim-signature', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'scrooloose/nerdcommenter'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'carlitux/deoplete-ternjs'
" Plug 'davidhalter/jedi-vim'
" Plug 'neomake/neomake'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" TO TRY
" Plug 'tpope/vim-surround'              " https://github.com/tpope/vim-surround
" Plug 'vim-scripts/indentpython.vim'    " https://github.com/vim-scripts/indentpython
" Plug 'tpope/vim-unimpaired'            " https://github.com/tpope/vim-unimpaired

" Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
call plug#end()

" ________________________________________________________
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

" ________________________________________________________
" PLUGIN: NERDCommenterToggle
"   https://github.com/scrooloose/nerdcommenter
"   Hotkeys:
"       <leader>cc to force comment
" In visual and normal mode <leacer>c toggles comments
nnoremap <leader>c :call NERDComment(0,"toggle")<CR>
vnoremap <leader>c :call NERDComment(0,"toggle")<CR>

" ________________________________________________________
" PLUGIN: Deoplete-Jedi
"   Auto-complete engine
"
let g:deoplete#enable_at_startup = 1

" ________________________________________________________
" PLUGIN: Deoplete-Jedi
"   Auto-complete popup when typing
"   https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/#auto-completion-plugin-deoplete
" Hotkeys:
"   ^n / ^p - Next previous suggestion
" In pop up menu mode alt+hjkl does not work
inoremap <expr><A-h> "<Esc>h"
inoremap <expr><A-j> "<Esc>j"
inoremap <expr><A-k> "<Esc>k"
inoremap <expr><A-l> "<Esc>l"
inoremap <expr><^A-^> "<Esc><^A-6>"

" ________________________________________________________
" PLUGIN: Jedi-vim
"   Jump to code definition
"   https://github.com/davidhalter/jedi-vim
"   https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/#how-to-use-jedi-vim
"   Jump to code definition, rename variables, etc
" VIM options (like completeopt and key defaults) auto configuration
let g:jedi#auto_vim_configuration = 0
" disable autocompletion, cause we use deopelete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

let g:jedi#goto_command = "<leader>jj"              " Jump to the file of function definition (new window)
let g:jedi#goto_assignments_command = "<leader>ja"  " Jumps to where the variable was assigned
let g:jedi#goto_definitions_command = "<leader>jd"  " Same as goto_command?
let g:jedi#documentation_command = "<leader>jk"     " Shows docstring
let g:jedi#usages_command = "<leader>ju"            " Jump to usage
let g:jedi#rename_command = "<leader>jr"            " Renames in multiple files!

" ________________________________________________________
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

" ________________________________________________________
" PLUGIN: Neomake
"   Syntax Linting https://github.com/neomake/neomake
" enable automatical code check
" This call must come after call plug#end()
" C0103 = arguments in camelcase
" C0301 = Line too long
" C0326 = bad whitespace
" R1705 = Return after another return
" R0903 = Class has too few public methods
"  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0103',
  \ '-d', 'C0326',
  \ '-d', 'C0301',
  \ '-d', 'R1705',
  \ '-d', 'R0903',
  \ '-d', 'W',
  \ '-f', 'text',
  \ '-r', 'n',
  \ '--docstring-min-length', '5',
  \ '--load-plugins', 'pylint_django',
  \ ],
  \ }
"\ 'args': ['--ignore=E221,E241,E272,E251,W503,W702,E203,E201,E202',  '--format=default'],
" Black will autofix style issues.
" Full list of codes here: https://gist.github.com/sharkykh/c76c80feadc8f33b129d846999210ba3
" E1XX indentation, E2XX = whitepsace, E3XX = blank line, W2 = whitespace warning
" W3 = blank line at end of file
let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E1,E2,E3,E402,E501,F403,W2,W391,W503', '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
"let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_python_enabled_makers = ['flake8']
call neomake#configure#automake('nwir', 500)
