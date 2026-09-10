local ns = vim.api.nvim_create_namespace("hilens")

local function cursor_on_match()
    local pattern = vim.fn.getreg("/")
    if pattern == "" then
        return false
    end

    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    local start = 0
    while true do
        local m = vim.fn.matchstrpos(line, pattern, start)
        if m[2] == -1 then
            return false
        end

        local s = m[2]
        local e = m[3]

        if col >= s and col < e then
            return true
        end

        if e <= start then
            start = start + 1
        else
            start = e
        end
    end
end

local function clear_lens()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

local function update_lens()
    clear_lens()

    if vim.v.hlsearch ~= 1 then
        return
    end

    if not cursor_on_match() then
        return
    end

    local sc = vim.fn.searchcount({ recompute = 1, maxcount = 9999 })
    if sc.total == 0 or sc.current == 0 then
        return
    end

    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    vim.api.nvim_buf_set_extmark(0, ns, row, -1, {
        virt_text = {
            { string.format("[%d/%d]", sc.current, sc.total), "Search" },
        },
        virt_text_pos = "eol",
    })
end

return {
    setup = function()
        local group = vim.api.nvim_create_augroup("hilens", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorMoved", "WinEnter" }, {
            group = group,
            callback = update_lens,
        })
    end,
    clear = clear_lens,
    update = update_lens,
}
