local state = {
    buf = nil,
    win = nil,
}

local function open_window()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        style = "minimal",
        border = "rounded",
    }

    state.win = vim.api.nvim_open_win(state.buf, true, opts)

    vim.api.nvim_set_option_value("winblend", 0, { win = state.win })
    vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:Normal", { win = state.win })
end

local function create_terminal()
    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        return
    end

    state.buf = vim.api.nvim_create_buf(false, true)

    local tmp_win = vim.api.nvim_open_win(state.buf, true, {
        relative = "editor",
        width = 1,
        height = 1,
        row = 0,
        col = 0,
        style = "minimal",
    })

    vim.cmd("terminal")

    vim.api.nvim_set_option_value("bufhidden", "hide", { buf = state.buf })
    vim.api.nvim_set_option_value("buflisted", false, { buf = state.buf })

    vim.api.nvim_win_close(tmp_win, true)
end

local function toggle_terminal()
    if vim.bo.filetype == "ministarter" then
        return
    end

    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    create_terminal()

    open_window()
    vim.cmd("startinsert")
end

return {
    setup = function()
        local group = vim.api.nvim_create_augroup("terminal", { clear = true })

        vim.api.nvim_create_autocmd("TermClose", {
            group = group,
            callback = function(ev)
                if ev.buf ~= state.buf then
                    return
                end

                vim.schedule(function()
                    if state.win and vim.api.nvim_win_is_valid(state.win) then
                        vim.api.nvim_win_close(state.win, true)
                    end

                    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
                        vim.api.nvim_buf_delete(state.buf, { force = true })
                    end

                    state.buf = nil
                    state.win = nil
                end)
            end,
        })

        vim.api.nvim_create_autocmd("TermOpen", {
            group = group,
            callback = function(ev)
                if ev.buf ~= state.buf then
                    return
                end

                vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", {
                    buffer = ev.buf,
                    silent = true,
                })
            end,
        })

        vim.api.nvim_create_user_command("Term", toggle_terminal, {})
    end,
    toggle = toggle_terminal,
}
