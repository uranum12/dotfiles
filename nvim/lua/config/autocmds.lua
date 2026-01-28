return {
    setup = function()
        vim.api.nvim_create_autocmd("WinEnter", { command = "checktime" })
    end,
}
