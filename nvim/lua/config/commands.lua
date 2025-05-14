return {
    setup = function()
        vim.api.nvim_create_user_command("BufRemove", function()
            local bufnr = vim.api.nvim_get_current_buf()

            local windows = vim.fn.win_findbuf(bufnr)
            for _, win in ipairs(windows) do
                local alt = vim.fn.bufnr("#")
                if vim.api.nvim_buf_is_valid(alt) and vim.api.nvim_buf_is_loaded(alt) then
                    vim.api.nvim_win_set_buf(win, alt)
                else
                    vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(true, false))
                end
            end

            vim.api.nvim_buf_delete(bufnr, { force = false })

            local total_tabs = vim.fn.tabpagenr("$")

            if 2 <= total_tabs then
                for i = 2, total_tabs do
                    vim.cmd(i .. "tabclose")
                end
            end
        end, {})
    end,
}
