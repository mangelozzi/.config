--[[
TODO
message how many matches found
qf delete operator
df mark operator
docs

See for jobstart!!!
https://teukka.tech/vimloop.html

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


-- nvim_buf_add_highlight()
--
print("Loading rgflow.lua")

local api = vim.api
rgflow = {}


function get_line_range(mode)
    -- call with visualmode() as the argument
    -- vnoremap <leader>zz :<C-U>call rgflow#GetVisualSelection(visualmode())<Cr>
    -- nvim_buf_get_mark({buffer}, {name})
    local current_pos = vim.fn.getpos(".")
    local startl, endl
    if mode == 'v' or mode=='V' or mode=='\22' then
        startl = unpack(api.nvim_buf_get_mark(0, "<"))
        endl   = unpack(api.nvim_buf_get_mark(0, ">"))
    else
        startl = vim.fn.line('.')
        endl = vim.v.count1 + startl - 1
    end
    print(vim.inspect(current_pos), ">>>", startl, endl)
    return current_pos, startl, endl
end
function rgflow.del_operator(mode)
    -- Only operates linewise, since 1 Quickfix entry is tied to 1 line.
    -- call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')
    local current_pos, startl, endl = get_line_range(mode)
    local count = endl-startl + 1
    local qf_list = vim.fn.getqflist()
    for i=1,count,1 do
        table.remove(qf_list, startl)
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.fn.setpos('.', current_pos)
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
                -- flag_data[flag_opt] = desc
            end
        end
    end
    return flag_data
end

function rgaddy(x, y)
    return x + y + 20
end

function rgflow.test()
    print("Hello from Lua add2: ", rgaddy(1,2))
end

function create_input_dialogue(default_pattern)
    -- get the editor's max width and height
    local width  = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    -- bufh / winh = heading window/buffer
    -- bufi / wini = input dialogue window/buffer

    -- Create Input Dialogue
    -- nvim_create_buf({listed}, {scratch})
    bufi  = api.nvim_create_buf(false, true)
    local flags = api.nvim_get_var('rgflow_flags')
    default_pattern = default_pattern or ""
    local cwd = vim.fn.getcwd()

    -- nvim_buf_set_lines({buffer}, {start}, {end}, {strict_indexing}, {replacement})
    -- print("create_input_dialogue pattern", default_pattern)
    api.nvim_buf_set_lines(bufi, 0, -1, false, {flags, default_pattern, cwd})

    -- nvim_open_win({buffer}, {enter}, {config})
    local configi = {relative='editor', anchor='SW', width=width-9, height=3, col=10, row=height-3,  style='minimal'}
    local wini = api.nvim_open_win(bufi, true, configi)
    api.nvim_win_set_option(wini, 'winhl', 'Normal:RgFlowInput')
    api.nvim_buf_set_option(bufi, 'bufhidden', 'wipe')

    -- Position the cursor after the pattern
    api.nvim_win_set_cursor(wini, {2, string.len(default_pattern)})
    api.nvim_command('redraw!')

    -- Create Headings (relative to input dialogue)
    -- nvim_create_buf({listed}, {scratch})
    bufh  = api.nvim_create_buf(false, true)

    -- nvim_buf_set_lines({buffer}, {start}, {end}, {strict_indexing}, {replacement})
    -- TODO: REFER TO HERE FOR BORDER: https://www.2n.pl/blog/how-to-write-neovim-plugins-in-lua
    api.nvim_buf_set_lines(bufh, 0, -1, false, {" FLAGS ", " PATTERN ", " PATH "})
    create_hotkeys(bufh)

    -- nvim_open_win({buffer}, {enter}, {config})
    -- focusable=false,
    -- Open relative to the input window
    local configh = { relative='editor', anchor='SW', width=9, height=3, col=0, row=height-3, style='minimal'}
    local winh = api.nvim_open_win(bufh, false, configh)
    api.nvim_win_set_option(winh, 'winhl', 'Normal:RgFlowHead')
    api.nvim_buf_set_option(bufh, 'bufhidden', 'wipe')
    -- Autocommand to close the heading window when the input window is closed
    api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..bufh)

    -- os.execute("sleep 1.5")
    -- api.nvim_command('redraw!')

    winh = 0
    return bufi, wini, winh
end
function rgflow.flags_complete(findstart, base)
    -- print("findstart:", findstart, "base:", base)
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
    -- print("after", vim.inspect(lines))
    return table.concat(lines, "\n")
end
function create_hotkeys(buf)
    -- api.nvim_buf_set_keymap(buf, "", "<CR>", ":lua rgflow.start()", {noremap=true,})
    -- api.nvim_buf_set_keymap(buf, "i", "<TAB>", "<ESC>:lua rgflow.complete()<CR>", {noremap=true,})
    -- api.nvim_buf_set_keymap(buf, "i", "<TAB>", "lua rgflow.complete()", {expr=true, noremap=true,})
    -- map-<cmd> does change the mode
    api.nvim_buf_set_keymap(buf, "i", "<TAB>", "<cmd>lua rgflow.complete()<CR>", {noremap = true;})
    api.nvim_buf_set_keymap(buf, "n", "<CR>", "<cmd>lua rgflow.start()<CR>", {noremap = true;})
end












function rgflow.start()
    local flags, pattern, path = unpack(api.nvim_buf_get_lines(bufi, 0, 3, true))

    -- Update the g:rgflow_flags so it retains its value for the session.
    api.nvim_set_var('rgflow_flags', flags)

    -- Default flags always included
    -- TODO get $0 to work
    local rg_args = {"--vimgrep", "--no-messages", "--replace",  "\30$0\30"}

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
    -- print(vim.inspect(rg_args))

    -- api.nvim_win_close(wini, true)
    -- Closing the input window triggers an Autocmd to close the heading window
    api.nvim_win_close(wini, true)

    config = {
        rg_args=rg_args,
        pattern=pattern,
        path=path,
        error_cnt=0,
        match_cnt=0,
        title="  "..pattern.."    "..path,
    }
    rgflow.spawn_job()
    -- api.nvim_win_close(winh, true)
end
function rgflow.search(mode)
    api.nvim_command("messages clear")
    print("cleared-------------------------")
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


local loop = vim.loop
local results = {}
local function on_read(err, data)
    if err then
        print('ERROR: ', err)
        -- TODO handle err
    end
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d ~= "" then
                -- If the last char is a ^M i.e. <CR> then trim it
                if string.sub(d, -1, -1) then d = string.sub(d, 1, -2) end
                table.insert(results, d)
            end
        end
    end
end
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
function rgflow.spawn_job()
    term = "function"
    results = {}
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local function setQF()
        vim.fn.setqflist({}, 'r', {title=config.title, lines=results})
        -- matchadd only works on current window
        api.nvim_command('copen')
        -- local winqf = api.nvim_command("getqflist({'winid':1})")
        -- local winqf = vim.fn.getqflist({'winid'=1})
        -- local winqf = api.nvim_call_function("getqflist({'winid':1})")
        local count = #results
        for i=0, count do results[i]=nil end -- clear the table for the next search
        vim.fn.clearmatches()
        -- Set char ASCII value 30 (<C-^>),"record separator" as invisible char around the pattern matches 
        -- Conceal options set in ftplugin
        api.nvim_command('call matchadd("Conceal", "\\<C-^>", 12, -1, {"conceal":""})')
        -- Highlight the matches between the invisible chars
        -- \{-n,} means match at least n chars, none greedy version
        api.nvim_command('call matchadd("Search", "\\<C-^>.\\{-1,}\\<C-^>", 11, -1)')
        -- Set incremental search to be the same value as pattern

        if api.nvim_get_var('rgflow_set_incsearch') then
            vim.fn.setreg("/", config.pattern, "c")
        end
    end
    -- https://github.com/luvit/luv/blob/master/docs.md#uvspawnpath-options-on_exit
    if not table.contains(config.rg_args, "--vimgrep") then
        table.insert(config.rg_args, 2, "--vimgrep")
    end
    print(vim.inspect(config.rg_args))
    handle = vim.loop.spawn('rg', {
        -- args = {term, '--vimgrep', '--smart-case', './'},
        args = config.rg_args,
        stdio = {stdout,stderr}
    },
    vim.schedule_wrap(function()
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        handle:close()
        setQF()
    end
    )
    )
    vim.loop.read_start(stdout, on_read)
    vim.loop.read_start(stderr, on_read)
end

return rgflow
