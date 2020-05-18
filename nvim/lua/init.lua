-- print(" loading init.lua")
local api = vim.api

-- Keymappings
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {opts})
-- {mode}  Mode short-name (map command prefix: "n", "i",
--            "v", "x", …) or "!" for |:map!|, or empty string
--            for |:map|.
--    {lhs}   Left-hand-side |{lhs}| of the mapping.
--    {rhs}   Right-hand-side |{rhs}| of the mapping.
--    {opts}  Optional parameters map. Accepts all
--            |:map-arguments| as keys excluding |<buffer>| but
--            including |noremap|. Values are Booleans. Unknown
--            key is an error.
api.nvim_set_keymap("", "Y", "y$", {noremap=true,})

test = {}
function test.make_window()
    buf  = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"one", "two", "three"})
    local configi = {relative='editor', anchor='SW', width=9, height=3, col=10, row=5,  style='minimal'}
    local win = vim.api.nvim_open_win(buf, true, configi)
    vim.api.nvim_win_set_option(win, 'winhl', 'Normal:_NormalReversed')
end
return test

--[[
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
