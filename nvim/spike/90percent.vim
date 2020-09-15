" NOT USED!!!!
" Only used as documentation! 

"=========================================================
" HOW TO DO WHAT 90% OF PLUGINS DO
"=========================================================
" https://www.youtube.com/watch?v=XA2WjJbmmoM


" ------------------------------------------------------------------------------
" FINDING FILES
" Search into subfolders, provides tab-completion for all file-related tasks
" set path+=**

" Display all matching files when we tab complete
" set wildmenu

" Now we can:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" Things to consider:
" - :b lets you autocomplete any open buffer

" ------------------------------------------------------------------------------
" TAG JUMPING:
" Create the `tags` file (may need to install ctags first)
" command! MakeTags !ctags -R .

" Run the command to build the tags start up
" silent exec "MakeTags"

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" ------------------------------------------------------------------------------
" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" ------------------------------------------------------------------------------
" FILE BROWSING:
" Tweaks for browsing
" let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window - keeps netrw on the left
" let g:netrw_altv=1          " open splits to the right
" let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_winsize = 25    " Set the width of the directory explorer

" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" ------------------------------------------------------------------------------
" SNIPPETS:
" Read a HTML template file into the current file and move cursor to title
" nnoremap ,html :-1read $MYVIMRC/../snippets/template.html<CR>8jwf>a
