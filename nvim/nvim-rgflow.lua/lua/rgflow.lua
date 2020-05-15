--[[
See for jobstart!!!
https://teukka.tech/vimloop.html

vim.{g,v,o,bo,wo}
vim.bo[0].bufhidden=hide

Command:
vim.api.nvim_command('startinsert')
Function:
vim.fn.getcwd()

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


Examples:

GLOBAL FUNCTIONS
:lua print(vim.inspect(vim.api.nvim_get_commands({builtin=false})))
lua vim.inspect(vim.api.nvim_get_color_map())
lua vim.api.nvim_del_current_line()
lua vim.api.nvim_create_buffer(true, false)
lua print(vim.inspect(vim.api))
lua print(vim.inspect(vim.api.nvim_get_current_line()))
lua print(vim.inspect(vim.api.nvim_get_keymap("n")))

lua print(vim.inspect(vim.api.nvim_get_current_buf()))

-- This can only access global options, not buffer or window local ones:
lua print(vim.api.nvim_get_option('hidden'))

nvim_get_var

-- GET VIM GLOBAL VAR:
-- let g:rgflow_test = 123
lua print(vim.inspect(vim.api.nvim_get_var('rgflow_test')))

vim.api.nvim_set_current_buf(5)
nvim_set_current_dir({dir})
nvim_set_current_line({line})  
nvim_set_current_win({window})
nvim_set_option({name}, {value})
-- Set Global variable
nvim_set_var({name}, {value})

LOCAL FUNCTIONS
nvim_buf_get_option
nvim_buf_get_var
nvim_buf_get_virtual_text
nvim_buf_set_keymap({buffer}, {mode}, {lhs}, {rhs}, {opts})
nvim_buf_set_name({buffer}, {name})
nvim_buf_set_option({buffer}, {name}, {value})
nvim_buf_set_virtual_text({buffer}, {ns_id}, {line}, {chunks}, {opts})

WINDOW FUNCTIONS
nvim_win_close


function hlyank(event, timeout)
if event.operator ~= 'y' or event.regtype == '' then return end
local timeout = timeout or 500

local bn = api.nvim_get_current_buf()
local ns = api.nvim_create_namespace('hlyank')
api.nvim_buf_clear_namespace(bn, ns, 0, -1)

local pos1 = api.nvim_call_function('getpos',{"'["})
local lin1, col1, off1 = pos1[2] - 1, pos1[3] - 1, pos1[4]
local pos2 = api.nvim_call_function('getpos',{"']"})
local lin2, col2, off2 = pos2[2] - 1, pos2[3] - (event.inclusive and 0 or 1), pos2[4]
for l = lin1, lin2 do
local c1 = (l == lin1 or event.regtype:byte() == 22) and (col1+off1) or 0
local c2 = (l == lin2 or event.regtype:byte() == 22) and (col2+off2) or -1
api.nvim_buf_add_highlight(bn, ns, 'TextYank', l, c1, c2)
end
local timer = vim.loop.new_timer()
timer:start(timeout,0,vim.schedule_wrap(function() api.nvim_buf_clear_namespace(bn, ns, 0, -1) end))
end

------------------
lua require'hlyank'
highlight default link TextYank IncSearch
autocmd TextYankPost * lua hlyank(vim.v.event)
]]--

-- nvim_buf_add_highlight()
--
print("Loading rgflow.lua")

local api = vim.api
rgflow = {}


-- let g:rgflow_test = 123

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
    local rg_args = {}

    -- 1. Add the flags first to the Ripgrep command
    for flag in flags:gmatch("[-%w]+") do table.insert(rg_args, flag) end

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
local function onread2(err, data)
    if err then
        -- print('ERROR: ', err)
        -- TODO handle err
    end
    if data then
        local vals = vim.split(data, "\n")
        for _, d in pairs(vals) do
            if d ~= "" then
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
    print("at least it was called:", term)
    results = {}
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local function setQF()
        vim.fn.setqflist({}, 'r', {title = 'Search Results', lines = results})
        api.nvim_command('cwindow')
        local count = #results
        for i=0, count do results[i]=nil end -- clear the table for the next search
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
    vim.loop.read_start(stdout, onread2)
    vim.loop.read_start(stderr, onread2)
end

return rgflow
