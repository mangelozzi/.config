"onoremap <expr> d (v:count == 0 \|\| v:operator != 'd') ? 'd' : '<Esc>cc' . v:count . '<Esc>'
"onoremap zz :<c-u>call MyQTest()<cr>

let pos = getpos('.')
let startpos = [0,1,0,'off']
let endpos   = [0,line("$"),0,'off']
echom "Let current".string(pos)
echom "Let start  ".string(startpos)
call setpos("'[", startpos)
call setpos("']", endpos)
echom v:operator."getpos start".string(getpos("'["))
echom v:operator."getpos end  ".string(getpos("']"))

function MyTest_F()
    exe "normal ggVG"
endfun
onoremap F :<C-u> call MyTest_F()<Cr>

function! OperateBufferAll_D()
    echom ':\<C-u>normal! ggVG\<CR>'.((v:operator != 'c' && v:operator != 'd') ? '\<C-o>' : '')
endfun
"onoremap <expr> C (v:operator != 'c' && v:operator != 'd') ? ':\<C-u>normal! ggVG\<CR>\<C-o>' : ':\<C-u>normal! ggVG\<CR>'

noremap <leader>aca :echo "the count is " . v:count<CR>
noremap <leader>acb :echo "the count is " . v:count1<CR>
noremap <leader>acc :<C-U>echo "the count is " . v:count<CR>
noremap <leader>acd :<C-U>echo "the count is " . v:count1<CR>
cnoremap <leader>ace :echo "the count is " . v:count<CR>
cnoremap <leader>acf :echo "the count is " . v:count1<CR>
cnoremap <leader>acg :<C-U>echo "the count is " . v:count<CR>
cnoremap <leader>ach :<C-U>echo "the count is " . v:count1<CR>


function MyTest_J(mode)
    echom "---------------------"
    echom "J orig_op: ".g:orig_op
endfun
onoremap J :let g:orig_op=v:operator<Cr>:set opfunc=MyTest_J<Cr>g@

fun! SetOpFunc()
    set opfunc=CountSpaces
    return 'g@'
endfun
nno <expr> <F4> SetOpFunc()



# 1 Liner Solution
```
" Use operator pending mode to visually select the whole buffer
" e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
onoremap <silent> A :<C-u>normal! ggVG<CR>

" Allow one to press A in visual mode to select the whole buffer (ALL)
vnoremap <silent> A :<C-U>normal! ggVG<CR>
```

# Medium Length Solution 1
This snippet preserves the cursor position/window view for y (Yank) and = (Auto indent) operators: (but unfortunately echos a message about the winrestview())
```
function! OperateBufferAll()
    let g:oba_winview = winsaveview()
    let cmd = ":\<C-u>normal! ggVG\<CR>"
    if index(['y','='], v:operator) != -1
        let cmd .= ":silent! call winrestview(g:oba_winview)\<CR>"
    endif
    return cmd
endfun
onoremap <expr> A OperateBufferAll()
vnoremap <silent> A :<C-U>normal! ggVG<CR>
```

# Medium Length Solution 2:
This does not always jump back to the right place reliably, and screen may shift a little when it does so.
```
function! OperateBufferAll()
    let cmd = ":\<C-u>normal! ggVG\<CR>"
    if (v:operator != 'c' && v:operator != 'd')
        let cmd .= "\<C-o>"
    endif
    return cmd
endfun
onoremap <expr> A OperateBufferAll()
vnoremap <silent> A :<C-U>normal! ggVG<CR>
```

# Long Solution (what I use)
Uses the ex mode commands, e.g. `%y+` which is much faster for your common commands. Preserves cursor location with other unknown operators too. It works by storing the register being used by the command, and the operator (to global variables), then it cancels the current operation, and calls OperateBufferAll().
```
let g:OBA_yank_to_clipboard_always = 0
function! OperateBufferAll()
    " Yank in ex mode works with unamed register, i.e. :%y
    let register = g:OBA_register
    let operator = g:OBA_operator

    if index(['"','+','*'], register) != -1 && index(['y','d','c'], operator) != -1
        " Common case where one can use fast ex mode copy/del whole file
        " commands into register ", +, or *. Doesnt work on other registers.
        " E.g. yank buffer to unamed register  :%y
        " E.g. delete buffer to + register     :%d+
        let cmd = ':%'
        let cmd .= (operator == 'y') ? 'y' : 'd'
        let cmd .= (register == '"') ? ''  : register
        let cmd .= (operator == 'c') ? '|:startinsert' : ''
        exe cmd
    elseif index(['y','d','c'], operator) != -1
        " Case where base y/d/c command, but not a common register. Use the
        " fast ex mode, copy from unnamed register, and then restore unamed
        " register afterwards.
        let reg_backup_value = getreg('"')    " Backup the contents of the unnamed register
        let reg_backup_type = getregtype('"')      " Save the type of the register as well

        let cmd = ':%'
        let cmd .= (operator == 'y') ? 'y' : 'd'
        let cmd .= (operator == 'c') ? '|:startinsert' : ''
        exe cmd
        exe ':let @'.register.'=@"'
        call setreg('"', reg_backup_value, reg_backup_value) " Restore register
    elseif operator == '='
        " Auto indent whole buffer, preserve cursor location
        let restore_position = winsaveview()
        normal gg=G
        call winrestview(restore_position)
    else
        " The default case, i.e. where the operator is not y, d, c, or =
        " For future and unknown commands
        let restore_position = winsaveview()
        exe 'gg"'.register.operator.'G'
        call winrestview(restore_position)
    endif
    if g:OBA_yank_to_clipboard_always
        " If whole buffer copy, and register is not clipboard, can copy it to
        " the clipboard too:
        if (operator == 'y' && register != '+')
            exe ':let @+=@'.register
            echom 'Copied from "'.register.' to the clipboard "+'
        endif
    endif
endfun
function! OBA_SaveState()
    let g:OBA_register = v:register
    let g:OBA_operator = v:operator
    return "\<Esc>:call OperateBufferAll()\<CR>"
endfun
" Create text object 'A' to be mean ALL, i.e. the entire buffer
onoremap <expr> A OBA_SaveState()
vnoremap <silent> A :<C-U>normal! ggVG<CR>
```

# Long Solution as above but no Save state func
```
let g:OBA_yank_to_clipboard_always = 0
function! OperateBufferAll()
    " Yank in ex mode works with unamed register, i.e. :%y
    let register = g:OBA_register
    let operator = g:OBA_operator

    if index(['"','+','*'], register) != -1 && index(['y','d','c'], operator) != -1
        " Common case where one can use fast ex mode copy/del whole file
        " commands into register ", +, or *. Doesnt work on other registers.
        " E.g. yank buffer to unamed register  :%y
        " E.g. delete buffer to + register     :%d+
        let cmd = ':%'
        let cmd .= (operator == 'y') ? 'y' : 'd'
        let cmd .= (register == '"') ? ''  : register
        let cmd .= (operator == 'c') ? '|:startinsert' : ''
        exe cmd
    elseif index(['y','d','c'], operator) != -1
        " Case where base y/d/c command, but not a common register. Use the
        " fast ex mode, copy from unnamed register, and then restore unamed
        " register afterwards.
        let reg_backup_value = getreg('"')    " Backup the contents of the unnamed register
        let reg_backup_type = getregtype('"')      " Save the type of the register as well

        let cmd = ':%'
        let cmd .= (operator == 'y') ? 'y' : 'd'
        let cmd .= (operator == 'c') ? '|:startinsert' : ''
        exe cmd
        exe ':let @'.register.'=@"'
        call setreg('"', reg_backup_value, reg_backup_value) " Restore register
    elseif operator == '='
        " Auto indent whole buffer, preserve cursor location
        let restore_position = winsaveview()
        normal gg=G
        call winrestview(restore_position)
    else
        " The default case, i.e. where the operator is not y, d, c, or =
        " For future and unknown commands
        let restore_position = winsaveview()
        exe 'gg"'.register.operator.'G'
        call winrestview(restore_position)
    endif
    if g:OBA_yank_to_clipboard_always
        " If whole buffer copy, and register is not clipboard, can copy it to
        " the clipboard too:
        if (operator == 'y' && register != '+')
            exe ':let @+=@'.register
            echom 'Copied from "'.register.' to the clipboard "+'
        endif
    endif
endfun
" Create text object 'A' to be mean ALL, i.e. the entire buffer
vnoremap <silent> A :<C-U>normal! ggVG<CR>
onoremap <expr> A OperateBufferAll()
```


Long Solution 2
```
let g:OBA_yank_also_to_clipboard = 1
function! OperateBufferAll()
    " Yank in ex mode works with unamed register, i.e. :%y
    let register = v:register
    let operator = v:operator

    if operator == 'y' || operator =='d' || operator == 'c'
        " Common case where one can use fast ex mode copy/del whole file.
        " Only work for register " (when not specified), +, and *
        " e.g. :%y or :%y+, d%*
        if (register == '"' || register == '*' || register == '+')
            let reg_str = (register == '"') ? '' : register
            let restore_unnamed = 0
        else
            let reg_str = ''
            let restore_unnamed = 1
            " If not operating on the unamed register, then backup it up.
            let unnamed_backup_value = getreg('"')
            let unnamed_backup_type  = getregtype('"')
        endif
        let cmd = (operator == 'c') ? ':%d'.reg_str.'|:startinsert' : ':%'.operator.reg_str
        exe cmd
        if restore_unnamed
            " Restore the unamed register
            exe ':let @'.register.'=@"'
            call setreg('"', unnamed_backup_value, unnamed_backup_value)
        endif
        if g:OBA_yank_also_to_clipboard
            " If whole buffer copy, and register is not clipboard, can copy it to
            " the clipboard too:
            if (operator == 'y' && register != '+')
                exe ':let @+=@'.register
                echom 'Copied from "'.register.' to the clipboard "+'
            endif
        endif
    else
        " Default case, where the operator is not y, d, c, e.g. = (autoindent)
        let restore_position = winsaveview()
        exe 'normal gg'.operator.'G'
        call winrestview(restore_position)
    endif
endfun
" Create text object 'A' to be mean ALL, i.e. the entire buffer
onoremap A :<C-u>call OperateBufferAll()<Cr>
vnoremap <silent> A :<C-U>normal! ggVG<CR>
```


function MyTest_F()
    let myreg = v:register
    let myop  = v:operator
    normal \<Esc>
    echom "----------- reg:".myreg." and op: ".myop
    let restore_position = winsaveview()
    exe 'normal gg"kyG'
    call winrestview(restore_position)
endfun
onoremap F :<C-u> call MyTest_F()<Cr>



























" DELETE FROM init.vim, latest mess:
function! MySave()
    let g:winview = winsaveview()
    let cmd = ":\<C-u>normal! ggVG\<CR>"
    if index(['y','='], v:operator) != -1
        let cmd .= ":silent! call winrestview(g:winview)\<CR>"
    endif
    return cmd
endfun
onoremap <expr> ZA MySave()


let g:OBA_yank_also_to_clipboard = 1
function! OperateBufferAll()
    " Yank in ex mode works with unamed register, i.e. :%y
    let register = v:register
    let operator = v:operator
    "call feedkeys('\<Esc>, 'i')

    if operator == 'y' || operator =='d' || operator == 'c'
        " Common case where one can use fast ex mode copy/del whole file.
        " Only work for register " (when not specified), +, and *
        " e.g. :%y or :%y+, d%*
        if (register == '"' || register == '*' || register == '+')
            let reg_str = (register == '"') ? '' : register
            let restore_unnamed = 0
        else
            let reg_str = ''
            let restore_unnamed = 1
            " If not operating on the unamed register, then backup it up.
            let unnamed_backup_value = getreg('"')
            let unnamed_backup_type  = getregtype('"')
        endif
        let cmd = (operator == 'c') ? ':%d'.reg_str.'|:startinsert' : ':%'.operator.reg_str
        exe cmd
        if restore_unnamed
            " Restore the unamed register
            exe ':let @'.register.'=@"'
            call setreg('"', unnamed_backup_value, unnamed_backup_value)
        endif
        if g:OBA_yank_also_to_clipboard
            " If whole buffer copy, and register is not clipboard, can copy it to
            " the clipboard too:
            if (operator == 'y' && register != '+')
                exe ':let @+=@'.register
                echom 'Copied from "'.register.' to the clipboard "+'
            endif
        endif
    else
        " Default case, where the operator is not y, d, c, e.g. = (autoindent)
        let restore_position = winsaveview()
        exe 'normal gg'.operator.'G'
        call winrestview(restore_position)
    endif
endfun
" Create text object 'A' to be mean ALL, i.e. the entire buffer
onoremap b2 :<C-u>call OperateBufferAll()<Cr>
vnoremap <silent> b :<C-U>normal! ggVG<CR>

function! OperateBufferAll_b()
    if v:operator == 'y' || v:operator =='d' || v:operator == 'c'
        "e.g. to yank to buffer a: gg"ayG
        let cmd = 'gg"'.v:register.v:operator.'G'
    else
        let cmd = 'gg'.v:operator.'G'
    endif
    let restore_position = winsaveview()
    let cmd = cmd
    echom "cmd: ".cmd
    call feedkeys('\<Esc>, 'nit')
    call feedkeys(cmd)
    call winrestview(restore_position)
endfun
onoremap B :<C-u>call MOperateBufferAll_b()<Cr>
function! Foo()
    call feedkeys("\<esc>")
    return
endfunction
function! MOperateBufferAll_c()
    echom "------------------------------"
    exe "normal! yy"
    return "_"
    if v:operator == 'y' || v:operator =='d' || v:operator == 'c'
        "e.g. to yank to buffer a: gg"ayG
        let cmd = 'gg"'.v:register.v:operator.'G'
    else
        let cmd = 'gg'.v:operator.'G'
    endif
    "call feedkeys('\<Esc>', 'i')
    call Foo()
    let restore_position = winsaveview()
    exe 'normal! '.cmd
    echom "cmd: ".cmd
    echom "after restore "
    call winrestview(restore_position)
endfun
onoremap C :call MOperateBufferAll_c()<Cr>


function! MOperateBufferAll_d()
    let restore_position = winsaveview()
    call cursor(1,1)
    echom "C"
    "call winrestview(restore_position)
    return "G\<Esc>\<C-o>"
endfun
"onoremap D :<C-u>call MOperateBufferAll_d()<Cr>

function! MyTest_E()
    normal! ggVG
endfun
onoremap E :<C-u> call MyTest_E()<Cr>

function! MyTest_F()
    let restore_position = winsaveview()
    normal! ggVG
    call winrestview(restore_position)
endfun
onoremap F :<C-u> call MyTest_F()<Cr>


function! MyTest_H()
    let restore_position = winsaveview()
    let startpos = [0,1,0,'off']
    let endpos   = [0,line("$"),0,'off']
    call setpos("'<", startpos)
    call setpos("'>", endpos)
    normal gv
    call winrestview(restore_position)
endfu
onoremap H :<C-u> call MyTest_H()<Cr>

function! MyTest_I()
    normal \<Esc>
    call feedkeys("\e")
    call feedkeys("\<Esc>")
    call feedkeys("\<Esc>", "ix")
    call feedkeys("\<Esc>", "tx")
    call feedkeys("\<Esc>", "itx")
    normal! ggVGy
    return \<Esc>
endfun

onoremap I :<C-u> call MyTest_I()<Cr>

function! Dummy()
    echom "Psyc!"
endfun
function! MyTest_J(op)
    echom "J orig_op: ".a:op
    set opfunc=Dummy
    normal ggVG
endfun
onoremap J :call MyTest_J(v:operator)<Cr>
"
