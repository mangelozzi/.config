" GIT GUTTER LOOK AT PLUGIN
" ESPECIALLY FOR JUMPING AROUNG "HUNKS"

" Run eternal command and open output in a new temp window
" Following function is from https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap ft=diff
" call setline(1, 'You entered:  ' . a:cmdline)
" call setline(2, 'Expanded to:  ' . expanded_cmdline)
" call append(line('$'), substitute(getline(1), '.', '=', 'g'))
  normal gg
  silent execute 'read !'. expanded_cmdline
  1
endfunction
" example:
" :Shell ls -la


" <leader>d -> GIT DIFF THE CURRENT FILE
" Following function is adapted from https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
function! GitDiff()
  let git_file_path = expand('%')
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap ft=diff
  normal gg
  "silent execute 'read !git diff --word-diff '. git_file_path
  silent execute 'read !git diff '. git_file_path
  1
endfunction
:nmap <leader>gd1 :call GitDiff()<cr>


" <leader>d -> GIT STATUS
" Place cursor over file and press gf to go there
function! GitStatus()
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap ft=gitcommit
  silent execute 'read !git status'  
  " Place cursor at first file in list
  normal ggddjjddjddddjwww
endfunction
:nmap <leader>gs1 :call GitStatus()<cr>

"GIT STATUS
" Place cursor over file and press gf to go there
function! GitStatus2()
  terminal git status
  " Place cursor at first file in list
  call chansend(&channel, "q\r<Esc>")
  normal 7j3w
endfunction
:nmap <leader>gs2 :call GitStatus2()<cr>


" <leader>d -> GIT STATUS
" Place cursor over file and press gf to go there
function GitDiff2()
  terminal git diff --word-diff %
  " Place cursor at first file in list
  normal Gaq<Esc>gg
endfunction
:nmap <leader>gd2 :call GitDiff2()<cr>

" terminal git diff --word-diff % \| normal Gaq<Esc>gg
