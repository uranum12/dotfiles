return {
    setup = function()
        vim.api.nvim_create_autocmd("WinEnter", { command = "checktime" })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                vim.opt_local.formatoptions:remove({ "r", "o" })
            end,
        })
    end,
}
