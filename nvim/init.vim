" TODO make it at end of jumplist, then tab opens current fold.
" :help usr_toc
" :help usr_41 (write a vim script)
" nested fold mappings
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" testing git access tokens
noremap <leader>v :call GrepWithHighlight()<Cr>

" Add hot key to exe set env etc:
" function! ExecuteManagerCheck(file)
"     execute ':!start cmd /k "C:\Users\xyz\Documents\checker\manager check '.a:file.'"'
" endfunction
"
" nmap <leader>m :call ExecuteManagerCheck(expand('%:p'))<cr>
" {{{1 TITLE
" TODO : NERD TRee status line, open vs when switch back to it
"
" A really good reference: https://github.com/jdhao/nvim-config
" To create a link which loads a session file with neovim-qt:
" C:\Neovim\bin\vim.exe -- -S
" Notemap commands cant have comment on same line as them.

" {{{1 VARIABLES
"==============================================================================
" System Dependant variables
let g:is_win   = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac   = has('macunix')

" {{{1 LEADER
"==============================================================================
" Change leader from \ to ;
" Must appear before any mappings, as the mapping uses the current value of
" variable at the time of the mapping.
let mapleader = " "

" {{{1 SETTINGS (same on linux servers)
"==============================================================================
" COLORS
set background=dark
set termguicolors

" GENERAL
set nocompatible            " Must be first command. Enter the current millenium
set autoindent              " When opening a new line keep indentation
set hidden                  " Allows one to reuse the same window and switch without saving
set history=10000           " NeoVim 10000. Number of previous commands remembered.
set inccommand=split        " Neovim - See a live preview of :substitute as you type.
set scrolloff=3             " When doing a search etc, always show at least n lines above and below the match
set numberwidth=4           " Default number column width
set mousefocus
set nostartofline           " Stop certain movements going to start of line (more like modern editors)
set nowrap                  " Disable word wrapping
set showcmd                 " Show partial commands in the last line of the screen
set showmatch               " When a bracket is inserted, briefly jump to the matching one.
set matchtime=3             " 1/10ths of a second for which showmatch applies to matching a bracket

set nolist                  " Dont show spaces/tabs/newlines etc
set nomodeline              " Modelines are vimscript snippets in normal files which vim interprets, e.g. `ex:`
set undolevels=2000         " Default 1000.
set shortmess+=c            " Do not show "match xx of xx" and other messages during auto-completion
set shiftround              " Round indent to multiple of 'shiftwidth'. Applies to > and < commands. CTRL-T and CTRL-D in insert mode always round to a multiple of shiftwidths.
set virtualedit=block       " Virtual edit is useful for visual block edit
set nojoinspaces            " Do not add two space after a period when joining lines or formatting texts, see https://tinyurl.com/y3yy9kov
set synmaxcol=500           " Text after this column number is not highlighted
set noswapfile              " Disable creating swapfiles, see https://goo.gl/FA6m6h

" UNSET
"set cmdheight=2            " Set the command bar height to 2 lines, fixed with ginit GuiTabline 0
"set noswapfiles             " Disable making swap files to indicate file is open.
"set undofile                " Persistent undo even after you close a file and re-open it
"set noshowmode              " Do not show mode on command line since vim-airline can show it
"set switchbuf=usetab,newtab " Control how QUICKFIX ONLY window links are opened are handled and :sb
"set winaltkeys=menu         " Default value, if a ALT+... hotkey is pressed, first let windowing system handle it, if not then vim will try
"set winblend=30             " Enables pseudo-transparency for a floating window.

" WILD COMPLETION
set wildmenu                " Better command-line completion
" The parts (stages) in completion:
"     1. longest = Complete until longest common string
"     2. Next tab list = show a list of possible completions
"     3. Next tab full = statusline selectable options
set wildmode=longest,list,full
" Ignore certain files and folders when globbing
set wildignore=*.pyc,*.zip,package-lock.json
set wildignore+=**/spike/**,**/ignore/**,**/temp/static/**
set wildignore+=**/venv/**,**/node_modules/**,**/.git/**

" SEARCHING
set ignorecase              " Use case insensitive search...
set smartcase               " ...except when using capital letters
set incsearch               " Start highlighting partial match as start typing
set wrapscan                " search-next wraps back to start of file (default with neovim)
set hlsearch                " Highlight searches, use :noh to turn off residual highlightin

" WRAPPED LINES
set linebreak               " wrap at word breaks
set showbreak=↪             " show an ellipsis at the start of wrapped lines

syntax on                   " Enable syntax highlighting
filetype plugin on          " Enable plugins (for newtrw), built in, comes with VIM
filetype indent plugin on   " Native plugin, intelligent auto indenting based on file type and content

highlight SpecialKey ctermfg=3

" INDENTATION
set shiftwidth=4
set softtabstop=4
set expandtab

" FINDING FILES
set path+=**
set wildmenu                " Display all matching files when we tab complete

" WORD TOOLS
" Specify the spelling language, have to use `:set spell` to enable it.
" :set spell` is set in ftplugin to enable spell checking
set spelllang=en_gb

" i_CTRL-X_CTRL-T for thesaurus completion
exe 'set thesaurus+='.fnamemodify("%", ":p:h").'/thesaurus/english.txt'

" {{{1 SOURCE INIT FILES
"==============================================================================
" Sourced plugins before own personal maps
" Where <sfile> when executing a ":source" command, is replaced with the file name of the sourced file.
source <sfile>:h/init/env.vim
source <sfile>:h/init/git.vim
source <sfile>:h/init/myplugins.vim
source <sfile>:h/init/visual.vim

" {{{1 COPY PASTE
"==============================================================================
" In Linux there are multiple clipboard like buffers called selections:
"   The PRIMARY (*) selection is updated every time you select text. To paste from it (in graphical programs), middle-click or use ShiftInsert. In Vim, it is accessible through the "* register.
"   The CLIPBOARD (+) selection is updated when you explicitly cut or copy anything (text or other data). In other words, it is used just like the Windows or Mac OS clipboards. To paste from it, the usual shortcut is CtrlV in grapical programs. In Vim, it is accessible through the "+ register. In Windows:
"   * is the system clipboard
"   + is NOT the system clipboard

" Broken current neovim implementation always copies selection to "* and "+
" Note Linux clipboard for pasting into gedit uses +
set clipboard=unnamed      " Use "* for all yank, delete, change and put operations which would normally go to the unnamed register.
set clipboard+=unnamedplus " Use "+ for all yank, delete, change and put operations which would normally go to the unnamed register.

" Left click yank selection to *, then re-select selection, then move left one char. Use middle click to paste, see mousemodel. The neovim default only copies the selection if middle click is pressed (this is required to select text then paste in another OS app).
noremap <LeftRelease> "*ygv

" Left double clicking on the word visual select inner word, yank to "*, then re-select previous selection, then move left one char
noremap <2-LeftMouse> viw"*ygv

"" CTRL+INS should paste, in neoqt it pastes "<S-Insert>" instead
inoremap <S-Insert> <C-r>+
cnoremap <S-Insert> <C-r>+

" =============================================================================
" COPY & PASTE
" =============================================================================
" The following goes into paste mode and out when pasting so that
" indentation is not messed up
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" ________________________________________________________
" Copy paste columns
" Temp solution until this is resolved: https://github.com/neovim/neovim/issues/1822
"   This issue:     https://vi.stackexchange.com/questions/14486/what-does-it-mean-to-set-clipboard-unnamed/17058#17058
"   NOT using this Fix: https://github.com/neovim/neovim/issues/1822#issuecomment-233152833
" Just specify a buffer when copying and pasting

" {{{1 GUI computer
"==============================================================================
set mouse=a                 " Enable use of the mouse for all modes
behave xterm              " Sets selectmode, mousemodel, keymodel, and selection
set number                  " Display line numbers on the left
set relativenumber

" {{{1 KEY MAPPINGS
"==============================================================================
" Can show a list of mappings with :map
" Useful to check no leader clashes
" Note!!! Comments on a separate line.
" CTRL (^) maps lower and uppercase to same key (by convention use uppercase)
" Meta (M-?) can map lower and upper case words)

" {{{2 All modes
" Map ; to : for speed
map ; :
map! <M-;> <Esc>:

" CTRL+S to save
map <C-s> :w<CR>
" map! <C-s> <C-o>:w<CR>
map! <C-s> <Esc>:w<CR>

" {{{2 Escape
" Map other forms of escape to true <Esc>, e.g. useful for multiline editing
" requres <Esc>.
noremap <C-[> <Esc>
noremap <C-c> <Esc>
" Line below makes exiting from input dialogue always fail
" noremap! <C-[> <Esc>
noremap! <C-c> <Esc>
"noremap! <C-Space> <Esc>
" required for escaping out of the terminal too (especially with FZF)
tnoremap <C-Space> <Esc>
"
" {{{2 Map (noremap)
"   Normal, Visual+Select, and Operator Pending modes

" :h yy = If you like "Y" to work from the cursor to the end of line (which is
" more logical, but not Vi-compatible) use ":map Y y$".
noremap Y y$

" Map backspace to other buffer
noremap <BS> <C-^>
noremap <BS> <C-^>

" Make x/X not change the registers, i.e. uses the black hole register
noremap x "_x
noremap X "_X

" Use Magic version of REGEX searching, i.e. all char expect 0-9a-zA-Z_ are
" considered regex special chars "very magic".
" http://vimdoc.sourceforge.net/htmldoc/pattern.html#pattern (scroll down a page to magic)
noremap <leader>/ /\v

"noremap <leader>sf :lvimgrep // %<left><left><left>

" When pressing star, don't jump to the next match
nmap <silent> * yiw<Esc>: let @/ = @""<CR>
nmap <silent> # yiw<Esc>: let @/ = @""<CR>

" {{{2 Map! (noremap!)

" Left/Right arrow backspace and delete
" <C-u> - Natively supports delete to beginning of line
" <C-h> - Natively is <Backspace>
noremap! <C-l> <Del>
noremap! <C-a> <Home>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" {{{2 Function keys
" <F1> to <F4> COMMON ACTIONS -------------------------------------------------
" <F1> ESCAPE If I hit <F1> it was a mistake because I was reaching for <Esc>
map  <F1> <Esc>
map! <F1> <Esc>

" <F2> is reseved for auto completion rename

" <F3> Open VIM RC file and change pwd to it
map  <F3> :e $MYVIMRC<CR> :cd %:p:h<CR>
map! <F3> <Esc>:e $MYVIMRC<CR> :cd %:p:h<CR>

" <F4> CLOSE BUFFER
" Same as buffer delete, however if its the last none help or empty buffer,
" then quit.
map  <F4>      :call myal#DeleteCurBufferNotCloseWindow()<CR>
map! <F4> <Esc>:call myal#DeleteCurBufferNotCloseWindow()<CR>

" <F5> to <F8> SETTINGS -------------------------------------------------------
map <F8>      :call myal#CopyEntireBuffer()<CR>
map <F8> <Esc>:call myal#CopyEntireBuffer()<CR>

" <F9> to <F12> QUICK INSERTS -------------------------------------------------
" To paste the current filename, use "%p

" DATETIME - Echo it in normal mode, insert it in insert mode.
map  <F9> :echo 'Current date/time is ' . strftime('%Y-%m-%d %T')<CR>
map! <F9> <C-R>=strftime('%Y-%m-%d %T')<CR>

" {{{2 Visual mode
" v = select and visual mode, x = visual, s = select (mouse)
" s mode = allows one to select with the mouse, then type any printable
"          character to replace the selection and start typing. Unfortunately
"          this means any hotkeys setup in v-mode will override which keys
"          actually perform this behaviour.
"          DECISION: Ignore select mode, use c to change a selection. Map
"                    hotkeys in v-mode so same behaviour if using the mouse or
"                    keyboard to make a selection.

" Move a block of text with SHIFT+arrows
" https://vim.fandomcom/w.iki/Drag_words_with_Ctrl-left/right
xnoremap <S-Right>  pgvloxlo
xnoremap <S-left>   hPgvhxoho
xnoremap <S-Down>   jPgvjxojo
xnoremap <S-Up>     xkPgvkoko

" {{{2 Searching & replacing
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m48s
" He uses a plugin to achieve this.
" Mapped with visual mode so that can use the mouse and press *
" In visual mode press * to search for the current selected region y = yank visual range into the " buffer
"   / = start search
"   \V = very NO magic
"   <C-R> = CTRL+R to paste from " buffer
"   escape = escape the / and \ which are the only none literals in no magic
xnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
xnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>

" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=07m36s
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
noremap <Leader>rr :%s///g<Left><Left>
noremap <Leader>rc :%s///gc<Left><Left><Left>

" xnoremap <Leader>rc :s///gc<Left><Left><Left>
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m25s
" Similar to above, but in visual mode search within current selected region
" for the previously search term. No need to add the '<,'> as it will be auto
" added.
xnoremap <Leader>rr :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" {{{2 Popup Menu
inoremap <expr><C-J> pumvisible() ? "\<C-n>" : "\<C-J>"
inoremap <expr><C-K> pumvisible() ? "\<C-p>" : "\<C-K>"
inoremap <expr><Cr>  pumvisible() ? "\<C-y>" : "\<Cr>"

" {{{2 Copy & paste
" Copy to system clipboard
" xnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" xnoremap <leader>p "+p
" xnoremap <leader>P "+P

" {{{2 Terminal mode
" <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" {{{2 Command mode
"   Make it more bash like
" If wish to implement more functionality (requiring functions), refer to:
" https://github.com/houtsnip/vim-emacscommandline/blob/master/plugin/emacscommandline.vim

" Delete word before cursor (natively supported)
" C-W

" Backspace (natively supported)
" ^H

" Goto line start / end
" C-E -> natively supported goto line end
cnoremap <C-A>		<Home>
"cnoremap <C-E>         <End>

" Move one character forwards/backwards
cnoremap <C-B>		<Left>
cnoremap <C-F>		<Right>

" Delete character under cursor
cnoremap <C-D>		<Del>

" Recall Next/Previous command-line
cnoremap <C-P>		<Up>
cnoremap <C-N>		<Down>

" Move back/forward one one word
cnoremap <M-b>	        <S-Left>
cnoremap <M-f>	        <S-Right>

" Delete from cursor to line start/end
" C-u (natively supported deleting to line start)
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

" In command mode, if there are no more character to the right of the cursor
" when delete is pressed, it starts to behave like backspace. Disable this.
cnoremap <expr> <Del> getcmdpos() <= strlen(getcmdline()) ? "\<Del>" : ""

" Rip grep in files, use <cword> under the cursor as starting point
nnoremap <leader>rg :call myal#SearchInFiles('n')<Cr>
" Rip grep in files, use visual selection as starting point
xnoremap <leader>rg :<C-U>call myal#SearchInFiles(visualmode())<Cr>

" {{{2 Vim talk (text objects and motions)
" Create text-object `A` which operates on the whole buffer (i.e. All)
" Keeps the cursor position in the same position
function! TextObjectAll()
    let g:restore_position = winsaveview()
    normal! ggVG
    call feedkeys("\<Plug>(RestoreView)")
endfunction
onoremap A :<C-U>call TextObjectAll()<CR>
nnoremap <silent> <Plug>(RestoreView) :call winrestview(g:restore_position)<CR>
" Disabled A in visual mode, cause use A to append at the end of selection.
" xnoremap A :<C-U>normal! ggVG<CR>

" Line Wise text objects (excludes the ending line char)
" g_ means move to the last printable char of the line
onoremap il :<C-U>normal! ^vg_<CR>
onoremap al :<C-U>normal! 0vg_<CR>
xnoremap il :<C-U>normal! ^vg_<CR>
xnoremap al :<C-U>normal! 0vg_<CR>

" Navigate to the start/end of the inner text
nnoremap [t vit<ESC>`<
nnoremap ]t vit<ESC>`>
" Navigate to the start/end of the <tag>...</tag> set
nnoremap [T vat<ESC>`<
nnoremap ]T vat<ESC>`>
" }}}2 End subsection

" {{{1 COMMANDS
"==============================================================================
" Change dir to that of Vim config ($MYVIMRC head)
" Not used, rather use more generic solution cd %:p:h
" command! Cdv exe 'cd ' . fnamemodify($MYVIMRC, ':p:h')

" {{{1 AUTOCOMMAND
" =============================================================================
" https://learnvimscriptthehardway.stevelosh.com/chapters/14.html
" Autocommands are duplicated everytime the file is sourced.
" To navigate this issue, place commands within an autocommand group, and
" always clear the autocmds in the group by placing a autocmd! within the
" group.
" While testing autocommands, can print debug related to them with
"      :set verbose=9
" autocmds spefic to a certain file type are placed here, or else they would
" be remove/added everytime a file of that type is opened.

augroup my_auto_commands
    autocmd!

    " Source a vim file after it is saved
    autocmd BufWritePost *.vim source %

    " Highlight groups of leading whitespace which is not a mutliple of 4
    autocmd FileType javascript,python match _WrongSpacing /\(^\(    \)*\)\zs \{1,3}\ze\S/

    " Strips trailing whitespace and auto indents the file
    autocmd BufWritePre *.vim  call myal#StripTrailingWhitespace() | call myal#AutoIndentFile()
    autocmd BufWritePre *.html call myal#StripTrailingWhitespace()

    " Restore the last position in a file when it was closed. Um-gas how this
    " works.
    " https://vi.stackexchange.com/questions/17007/after-closing-a-file-how-do-i-remember-return-to-the-previous-line
    au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

function! SwitchAwayFromQFWindow()
    if &filetype=='qf'
        wincmd k
        echom "switch 1"
    endif
    if &filetype=='qf'
        wincmd k
        echom "switch 2"
    endif
    if &filetype=='qf'
        new
        echom "switch new"
    endif
endfun
augroup prevent_load_in_quickfix_window
    autocmd!
    "autocmd BufNewFile,BufReadPre * echom "hello" | call SwitchAwayFromQFWindow()
augroup END

