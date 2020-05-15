print(" loading init.lua")
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
