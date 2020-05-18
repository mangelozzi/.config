--[[
TODO
handle errors if pattern is blank, or if path is blank (set to './')
search history with ctrl-f?
Mark preview hints appear to left on window
Basically all such programs do the same: they set 'grepprg' and 'grepformat'
docs

See for jobstart!!!
https://teukka.tech/vimloop.html

nvim_buf_add_highlight()

To execute VimL from Lua:
:lua vim.api.nvim_command('echo "Hello, Nvim!"')
:lua vim.api.nvim_call_function("namemodify', {fname, ':p'})
To see contents of a table use: print(vim.inspect(table))
Consider tree sitter for auto copmlete: parser = vim.treesitter.get_parser(bufnr, lang)
local foo = vim.fn.getpos("[") and then foo[1],…,foo[4]

vim.{g,v,o,bo,wo}
vim.bo[0].bufhidden=hide

Command:  vim.api.nvim_command('startinsert')
Function: vim.fn.getcwd()

Auto complete algo
map tab to custom function, if line 2 call feedkeys hotkey for built in complete (ctrl-X ctrl-N)
3 complete functions: complete_rg_glags, complete_from_buffer, complete
depending on line number call corresponding set corresponding complete func
set completeopt accordingly to menu,preview, and load in preview

if dict file for rg does not exist, then create it

Depending on line, set 'completefunc' diffferent
setlocal completefunc=csscomplete#CompleteFA

echo:
nvim_out_write({str})
--]]


local api = vim.api
local loop = vim.loop
rgflow = {}

function get_line_range(mode)
    -- call with visualmode() as the argument
    -- vnoremap <leader>zz :<C-U>call rgflow#GetVisualSelection(visualmode())<Cr>
    -- nvim_buf_get_mark({buffer}, {name})
    local startl, endl
    if mode == 'v' or mode=='V' or mode=='\22' then
        startl = unpack(api.nvim_buf_get_mark(0, "<"))
        endl   = unpack(api.nvim_buf_get_mark(0, ">"))
    else
        startl = vim.fn.line('.')
        endl = vim.v.count1 + startl - 1
    end
    return startl, endl
end


function rgflow.del_operator(mode)
    -- Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    local win_pos = vim.fn.winsaveview()
    local startl, endl = get_line_range(mode)
    local count = endl-startl + 1
    local qf_list = vim.fn.getqflist()
    for i=1,count,1 do
        table.remove(qf_list, startl)
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.fn.winrestview(win_pos)
end


function rgflow.mark_operator(add_not_remove, mode)
    -- Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    local win_pos = vim.fn.winsaveview()
    local startl, endl = get_line_range(mode)
    local count = endl-startl + 1
    local qf_list = vim.fn.getqflist()
    local mark = api.nvim_get_var('rgflow_mark_str')

    -- the quickfix list is an arrow of dictionary entries, an example of one entry:
    -- {'lnum': 57, 'bufnr': 5, 'col': 1, 'pattern': '', 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'module': '', 'text': 'function! myal#StripTrailingWhitespace()'}
    if add_not_remove  then
        for i=startl,endl,1 do
            qf_list[i]['text'] = string.gsub(qf_list[i]['text'], "^(%s*)", "%1"..mark, 1)
        end
    else
        for i=startl,endl,1 do
            qf_list[i]['text'] = string.gsub(qf_list[i]['text'], "^(%s*)"..mark, "%1", 1)
        end
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.fn.winrestview(win_pos)
end


function get_flag_data(base)
    local rghelp = vim.fn.systemlist("rg -h")
    local flag_data = {}
    local heading_found = false
    for i, line in ipairs(rghelp) do
        if not heading_found then
            if string.find(line, "OPTIONS:") then heading_found = true end
        else
            local _, _, flag_opt, desc = string.find(line, "^%s*(.-)%s%s+(.-)%s*$")
            local starti, endi, flag = string.find(flag_opt, "^(-%w),%s")
            if flag then
                -- e.g.     -A, --after-context <NUM>               Show NUM lines after each match.
                local option = string.sub(flag_opt, endi, -1)
                local _, _, option = string.find(option, "^%s*(.-)%s*$")
                if not base or string.find(flag, base, 1, true) then
                    table.insert(flag_data, {word=flag, info=desc})
                end
                if not base or string.find(option, base, 1, true) then
                    table.insert(flag_data, {word=option, info=desc})
                end
            else
                -- e.g.         --binary                            Search binary files.
                if not base or string.find(flag_opt, base, 1, true) then
                    table.insert(flag_data, {word=flag_opt, info=desc})
                end
            end
        end
    end
    return flag_data
end


function create_input_dialogue(default_pattern)
    -- bufh / winh / widthh = heading window/buffer/width
    -- bufi / wini / widthi = input dialogue window/buffer/width

    -- get the editor's max width and height
    local width  = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")
    local widthh = width
    local widthi = width - 9

    -- Create Buffers
    -- nvim_create_buf({listed}, {scratch})
    bufi  = api.nvim_create_buf(false, true)
    bufh  = api.nvim_create_buf(false, true)

    -- Generate text content for the buffers
    -- REFER TO HERE FOR BORDER: https://www.2n.pl/blog/how-to-write-neovim-plugins-in-lua
    local flags = api.nvim_get_var('rgflow_flags')
    default_pattern = default_pattern or ""
    local cwd = vim.fn.getcwd()
    local contenti = {flags, default_pattern, cwd}
    local contenth = {string.rep("▄", widthh), " FLAGS ", " PATTERN ", " PATH "}

    -- Add text content to the buffers
    -- nvim_buf_set_lines({buffer}, {start}, {end}, {strict_indexing}, {replacement})
    api.nvim_buf_set_lines(bufi, 0, -1, false, contenti)
    api.nvim_buf_set_lines(bufh, 0, -1, false, contenth)

    -- Window config
    local configi = {relative='editor', anchor='SW', width=widthi, height=3, col=10, row=height-3,  style='minimal'}
    local configh = {relative='editor', anchor='SW', width=widthh, height=4, col=0,  row=height-3,  style='minimal'}

    -- Create windows
    -- nvim_open_win({buffer}, {enter}, {config})
    local winh = api.nvim_open_win(bufh, false, configh)
    local wini = api.nvim_open_win(bufi, true,  configi) -- open input dialogue after so its ontop

    -- Setup Input window
    api.nvim_win_set_option(wini, 'winhl', 'Normal:RgFlowInputBg')
    api.nvim_buf_set_option(bufi, 'bufhidden', 'wipe')
    vim.fn.matchaddpos("RgFlowInputFlags",   {1}, 11, -1, {window=wini})
    vim.fn.matchaddpos("RgFlowInputPattern", {2}, 11, -1, {window=wini})
    vim.fn.matchaddpos("RgFlowInputPath",    {3}, 11, -1, {window=wini})
    -- Position the cursor after the pattern
    api.nvim_win_set_cursor(wini, {2, string.len(default_pattern)})

    -- Setup Heading window
    api.nvim_win_set_option(winh, 'winhl', 'Normal:RgFlowHead')
    api.nvim_buf_set_option(bufh, 'bufhidden', 'wipe')
    -- Autocommand to close the heading window when the input window is closed
    api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! '..bufh..'"')
    vim.fn.matchaddpos("RgFlowHeadLine", {1}, 11, -1, {window=winh})

    create_hotkeys(bufh)
    api.nvim_command('redraw!')
    return bufi, wini, winh
end


function rgflow.flags_complete(findstart, base)
    if findstart == 1 then
        local pos = api.nvim_win_get_cursor(0)
        row = pos[1]
        col = pos[2]
        local line = api.nvim_buf_get_lines(0,row-1,row, false)[1]
        local s = ''
        for i=col,1,-1 do
            local char = tostring(string.sub(line, i, i))
            s = s .. ">".. char
            if char == " " then return i end
        end
        return 0
    else
        local flag_data = get_flag_data(base)
        return flag_data
    end
end


function rgflow.complete()
    local linenr = api.nvim_win_get_cursor(0)[1]
    if vim.fn.pumvisible() ~= 0 then
        api.nvim_input("<C-N>")
    elseif linenr == 1 then
        -- Flags line - Using completefunc
        -- nvim_buf_set_option({buffer}, {name}, {value})
        api.nvim_buf_set_option(0, "completefunc", "v:lua.rgflow.flags_complete")
        api.nvim_input("<C-X><C-U>")
    elseif linenr == 2 then
        -- Pattern line
        api.nvim_input("<C-N>")
    elseif linenr == 3 then
        -- Filename line
        api.nvim_input("<C-X><C-F>")
    end
end


function get_visual_selection(mode)
    -- call with visualmode() as the argument
    -- vnoremap <leader>zz :<C-U>call rgflow#GetVisualSelection(visualmode())<Cr>
    -- nvim_buf_get_mark({buffer}, {name})
    local line_start, column_start = unpack(api.nvim_buf_get_mark(0, "<"))
    local line_end,   column_end   = unpack(api.nvim_buf_get_mark(0, ">"))
    line_start   = line_start - 1
    column_start = column_start + 1
    column_end   = column_end + 2
    -- nvim_buf_get_lines({buffer}, {start}, {end}, {strict_indexing})
    local lines = api.nvim_buf_get_lines(0, line_start, line_end, true)
    local offset = 1
    if api.nvim_get_option('selection') ~= 'inclusive' then local offset = 2 end
    if mode == 'v' then
        -- Must trim the end before the start, the beginning will shift left.
        lines[#lines] = string.sub(lines[#lines], 1, column_end - offset)
        lines[1]      = string.sub(lines[1], column_start, -1)
    elseif  mode == 'V' then
        -- Line mode no need to trim start or end
    elseif  mode == "\22" then
        -- <C-V> = ASCII char 22
        -- Block mode, trim every line
        for i,line in ipairs(lines) do
            lines[i] = string.sub(line, column_start, column_end - offset)
        end
    else
        return ''
    end
    return table.concat(lines, "\n")
end


function create_hotkeys(buf)
    -- map-<cmd> does not change the mode

    -- Map tab to be general autocomplete flags/buffer/file depending on which line user is on
    api.nvim_buf_set_keymap(buf, "i", "<TAB>", "<cmd>lua rgflow.complete()<CR>", {noremap=true})

    -- Map <CR> to start search in normal and insert (not command) modes
    api.nvim_buf_set_keymap(buf, "", "<CR>", "<cmd>lua rgflow.start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "i", "<CR>", "<ESC><cmd>lua rgflow.start()<CR>", {noremap=true})

    -- When cursor at line end, press <DEL> should not join it with the next line
    api.nvim_buf_set_keymap(buf, "i", "<DEL>", "( col('.') == col('$') ? '' : '<DEL>')", {expr=true, noremap=true})

    -- When cursor at line start, press <BS> should not join it with the next line
    api.nvim_buf_set_keymap(buf, "i", "<BS>", "( col('.') == 1 ? '' : '<BS>')", {expr=true, noremap=true})

    -- Disable join lines
    api.nvim_buf_set_keymap(buf, "n", "J", "<NOP>", {noremap=true})

    -- nnoremap <buffer> <C-^>   <Nop>
-- nnoremap <buffer> <C-S-^> <Nop>
-- nnoremap <buffer> <C-6>   <Nop>

    -- Map various abort like keys to cancel search
    api.nvim_buf_set_keymap(buf, "n", "<ESC>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "n", "<C-]>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
    api.nvim_buf_set_keymap(buf, "n", "<C-C>", "<cmd>lua rgflow.abort_start()<CR>", {noremap=true})
end


function rgflow.abort_start()
    api.nvim_win_close(wini, true)
end


function rgflow.start()
    local flags, pattern, path = unpack(api.nvim_buf_get_lines(bufi, 0, 3, true))

    -- Update the g:rgflow_flags so it retains its value for the session.
    api.nvim_set_var('rgflow_flags', flags)

    -- Default flags always included
    local rg_args    = {"--vimgrep", "--no-messages", "--replace",  "\30$0\30"}

    -- 1. Add the flags first to the Ripgrep command
    local flags_list = vim.split(flags, " ")

    -- set conceallevel=2
    -- syntax match Todo /bar/ conceal
    -- :help conceal

    -- for flag in flags:gmatch("[-%w]+") do table.insert(rg_args, flag) end
    for i,flag in ipairs(flags_list) do
        table.insert(rg_args, flag)
    end

    -- 2. Add the pattern
    table.insert(rg_args, pattern)

    -- 3. Add the search path
    table.insert(rg_args, path)

    -- api.nvim_win_close(wini, true)
    -- Closing the input window triggers an Autocmd to close the heading window
    api.nvim_win_close(wini, true)

    config = {
        rg_args=rg_args,
        demo_cmd=flags.." "..pattern.." "..path,
        pattern=pattern,
        path=path,
        error_cnt=0,
        match_cnt=0,
        title="  "..pattern.."    "..path,
        results={},
    }
    rgflow.spawn_job()
    -- api.nvim_win_close(winh, true)
end


function rgflow.search(mode)
    api.nvim_command("messages clear")
    local visual_modes = {v=true, V=true, ['\22']=true}
    local default_pattern
    if visual_modes[mode] then
        default_pattern = get_visual_selection(mode)
    else
        default_pattern = vim.fn.expand('<cword>')
    end
    buf, wini, winh = create_input_dialogue(default_pattern)
    create_hotkeys(buf)
    return
end


function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end


local function schedule_print(msg)
    local msg = msg
    local timer = loop.new_timer()
    timer:start(100,0,vim.schedule_wrap(function() print(msg) end))
end


local function on_stderr(err, data)
    -- On exit stderr will run with nil, nil passed in
    -- err always seems to be nil, and data has the error message
    if not err and not data then return end
    config.error_cnt = config.error_cnt + 1
    local timer = loop.new_timer()
    timer:start(100,0,vim.schedule_wrap(function()
        api.nvim_command('echoerr "'..data..'"')
    end))
end


local function on_stdout(err, data)
    if err then
        config.error_cnt = config.error_cnt + 1
        schedule_print("ERROR: "..vim.inspect(err).." >>> "..vim.inspect(data))
    end
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d ~= "" then
                -- If the last char is a ASCII 13 / ^M / <CR> then trim it
                config.match_cnt = config.match_cnt + 1
                if string.sub(d, -1, -1) == "\13" then d = string.sub(d, 1, -2) end
                table.insert(config.results, d)
            end
        end
        schedule_print("Found "..config.match_cnt.." results..")
    end
end


local function on_exit()
    if config.match_cnt > 0 then
        print("Adding "..config.match_cnt.." results to the quickfix list...")
        -- schedule_print("Adding "..config.match_cnt.." results to the quickfix list...")
        api.nvim_command('redraw!')

        vim.fn.setqflist({}, 'r', {title=config.title, lines=config.results})
        api.nvim_command('copen')
        -- matchadd only works on current window
        -- local winqf = api.nvim_command("getqflist({'winid':1})")
        -- local winqf = vim.fn.getqflist({'winid'=1})
        -- local winqf = api.nvim_call_function("getqflist({'winid':1})")
        vim.fn.clearmatches()
        -- Set char ASCII value 30 (<C-^>),"record separator" as invisible char around the pattern matches
        -- Conceal options set in ftplugin
        vim.fn.matchadd("Conceal", "\30", 12, -1, {conceal=""})

        -- Highlight the matches between the invisible chars
        -- \{-n,} means match at least n chars, none greedy version
        -- priority 0, so that incsearch at priority 1 takes preference
        vim.fn.matchadd("RgFlowQfPattern", "\30.\\{-1,}\30", 0, -1)

        if api.nvim_get_var('rgflow_set_incsearch') then
            -- Set incremental search to be the same value as pattern
            vim.fn.setreg("/", config.pattern, "c")
            -- Trigger the highlighting of search by turning hl on
            api.nvim_set_option("hlsearch", true)
        end
    end
    -- Print exit message
    local msg = config.pattern.." ░ "..config.match_cnt.." result"..(config.match_cnt==1 and '' or 's')
    if config.error_cnt > 0 then
        msg = msg.." ("..config.error_cnt.." errors)"
    else
        msg = msg.." ░ "..config.demo_cmd
    end
    schedule_print(msg)
end


function rgflow.spawn_job()
    term = "function"
    local stdin  = loop.new_pipe(false)
    local stdout = loop.new_pipe(false)
    local stderr = loop.new_pipe(false)

    -- print(vim.inspect(config.rg_args))
    print("Rgflow start search for:  "..config.pattern.."  with  "..config.demo_cmd)

    -- https://github.com/luvit/luv/blob/master/docs.md#uvspawnpath-options-on_exit
    handle = loop.spawn('rg', {
        args = config.rg_args,
        stdio = {stdin, stdout, stderr}
    },
    vim.schedule_wrap(function()
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        handle:close()
        on_exit()
    end)
    )
    loop.read_start(stdout, on_stdout)
    loop.read_start(stderr, on_stderr)
end

return rgflow
