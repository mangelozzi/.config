" TODO : NERD TRee status line, open vs when switch back to it
"
" A really good reference: https://github.com/jdhao/nvim-config
" To create a link which loads a session file with neovim-qt:
" C:\Neovim\bin\vim.exe -- -S
" Notemap commands cant have comment on same line as them.

" TO TRY:
" https://github.com/EinfachToll/DidYouMean
" https://github.com/justinmk/vim-sneak

set nocompatible            " Must be first command. Enter the current millenium

" System Dependant variables
let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac = has('macunix')

"==============================================================================
" VARIABLES
"==============================================================================

"==============================================================================
" settings - standard (same on linux servers)
"==============================================================================
" COLORS
set background=dark
set termguicolors

" GENERAL
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
set matchtime=3             " 1/10ths of a second for which showmatch applies
set wildmenu                " Better command-line completion
" Ignore certain files and folders when globbing
set wildignore=*.pyc,*.zip,package-lock.json
set wildignore+=**/spike/**,**/ignore/**,**/temp/static/**
set wildignore+=**/venv/**,**/node_modules/**,**/.git/**
set nolist                  " Dont show spaces/tabs/newlines etc
"set noswapfiles
set nomodeline              " Modelines are vimscript snippets in normal files which vim interprets, e.g. `ex:`
"set undofile                " Persistent undo even after you close a file and re-open it
set undolevels=2000         " Default 1000.
"set noshowmode              " Do not show mode on command line since vim-airline can show it
set shortmess+=c            " Do not show "match xx of xx" and other messages during auto-completion
set shiftround              " Round indent to multiple of 'shiftwidth'. Applies to > and < commands. CTRL-T and CTRL-D in insert mode always round to a multiple of shiftwidths.
set virtualedit=block       " Virtual edit is useful for visual block edit
set nojoinspaces            " Do not add two space after a period when joining lines or formatting texts, see https://tinyurl.com/y3yy9kov
set synmaxcol=500           " Text after this column number is not highlighted
set noswapfile              " Disable creating swapfiles, see https://goo.gl/FA6m6h


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

"==============================================================================
" SETTINGS - GUI computer
"==============================================================================
set mouse=a                 " Enable use of the mouse for all modes
set number                  " Display line numbers on the left
set relativenumber

"==============================================================================
" COPY PASTE
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

"==============================================================================
" KEY MAPPINGS
"==============================================================================
" Can show a list of mappings with :map
" Useful to check no leader clashes

" ___ LEADER __________________________________________________________________
" Change leader from \ to ;
let mapleader = " "

" ___ ALL MODES _______________________________________________________________


" Map ; to : for speed
map ; :
map! <M-;> <Esc>:

" CTRL+S to save
map <C-s> :w<CR>
" map! <C-s> <C-o>:w<CR>
map! <C-s> <Esc>:w<CR>

" ___ MAP (NOREMAP)____________________________________________________________
"   Normal, Visual+Select, and Operator Pending modes

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

" ___ MAP! (NOREMAP!)__________________________________________________________
" Map other forms of escape to true <Esc>, e.g. useful for multiline editing
" requres <Esc>.
noremap! <C-[> <Esc>
noremap! <C-Space> <Esc>
" required for escaping out of the terminal too (especially with FZF)
tnoremap <C-Space> <Esc>

" Left/Right arrow backspace and delete
" <C-u> - Natively supports delete to beginning of line
" <C-h> - Natively is <Backspace>
noremap! <C-l> <Del>
noremap! <C-a> <Home>

" ___ FUNCTION KEYS ___________________________________________________________

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
map  <F4>      :call myautoload#DeleteCurBufferNotCloseWindow()<CR>
map! <F4> <Esc>:call myautoload#DeleteCurBufferNotCloseWindow()<CR>

" <F5> to <F8> SETTINGS -------------------------------------------------------
map <F8>      :call myautoload#CopyEntireBuffer()<CR>
map <F8> <Esc>:call myautoload#CopyEntireBuffer()<CR>

" <F9> to <F12> QUICK INSERTS -------------------------------------------------
" To paste the current filename, use "%p

" DATETIME - Echo it in normal mode, insert it in insert mode.
map  <F9> :echo 'Current date/time is ' . strftime('%Y-%m-%d %T')<CR>
map! <F9> <C-R>=strftime('%Y-%m-%d %T')<CR>

" ___ VISUAL MODE _____________________________________________________________
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
vnoremap <S-Right>  pgvloxlo
vnoremap <S-left>   hPgvhxoho
vnoremap <S-Down>   jPgvjxojo
vnoremap <S-Up>     xkPgvkoko

" ___ SEARCHING & REPLACING ___________________________________________________
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m48s
" He uses a plugin to achieve this.
" Mapped with visual mode so that can use the mouse and press *
" In visual mode press * to search for the current selected region y = yank visual range into the " buffer
"   / = start search
"   \V = very NO magic
"   <C-R> = CTRL+R to paste from " buffer
"   escape = escape the / and \ which are the only none literals in no magic
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>

" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=07m36s
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
noremap <Leader>rr :%s///g<Left><Left>
noremap <Leader>rc :%s///gc<Left><Left><Left>

" vnoremap <Leader>rc :s///gc<Left><Left><Left>
" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m25s
" Similar to above, but in visual mode search within current selected region
" for the previously search term. No need to add the '<,'> as it will be auto
" added.
vnoremap <Leader>rr :s///g<Left><Left>
vnoremap <Leader>rc :s///gc<Left><Left><Left>

" ___ COPY & PASTE ____________________________________________________________
" Copy to system clipboard
" vnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

" ___ TERMINAL MODE ___________________________________________________________
" <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" ___ COMMAND MODE ____________________________________________________________
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

"==============================================================================
" COMMANDS
"==============================================================================
" Change dir to that of Vim config ($MYVIMRC head)
" Not used, rather use more generic solution cd %:p:h
" command! Cdv exe 'cd ' . fnamemodify($MYVIMRC, ':p:h')

"==============================================================================
" SPLIT VIMRC files
"==============================================================================
"Where <sfile> when executing a ":source" command, is replaced with the file name of the sourced file.
source <sfile>:h/init/env.vim
source <sfile>:h/init/git.vim
source <sfile>:h/init/myplugins.vim
source <sfile>:h/init/coc.vim
source <sfile>:h/init/visual.vim
source <sfile>:h/init/talk.vim

" ----------------------------------------
" Control quick fix windows are handled and :sb
" set switchbuf=usetab,newtab

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

" ----------------------------------------
" DUMPING GROUND:
" set cmdheight=2         " Set the command bar height to 2 lines, fixed with ginit GuiTabline 0
"Auto reload VIMRC file after changed
"autocmd BufWritePost .vimrc source %

" =============================================================================
" KEYMAPPINGS
"   Note!!! Comments on a separate line.
"   CTRL (^) maps lower and uppercase to same key (by convention use uppercase)
"   Meta (M-?) can map lower and upper case words)
" =============================================================================

" =============================================================================
" AUTOCOMMANDS
" =============================================================================
" https://learnvimscriptthehardway.stevelosh.com/chapters/14.html
" Autocommands are duplicated everytime the file is sourced.
" To navigate this issue, place commands within an autocommand group, and
" always clear the autocmds in the group by placing a autocmd! within the
" group.
"

augroup save_programming_file
    " Strips trailing whitespace and auto indents the file
    autocmd!
    autocmd BufWritePre *.vim :call myautoload#SaveProgrammingFile()
augroup END


