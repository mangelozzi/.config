" Consider using this Grammarly like tool plugin:
" https://www.vim.org/scripts/script.php?script_id=3223

setlocal wrap
noremap <buffer> j gj
noremap <buffer> k gk

" Spell checking on
setlocal spell

" GB spelling
" Set in init.vim for all files
" setlocal spelllang=en_gb

" Add spelling words to autocomplete (i_<C-n> i_<C-p>)
setlocal complete+=kspell
