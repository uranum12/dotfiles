return {
    setup = function()
        vim.api.nvim_create_augroup("number_insert_mode", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            group = "number_insert_mode",
            callback = function()
                local ftype, _ = vim.filetype.match({ buf = 0 })
                if ftype then
                    vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
                end
            end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            group = "number_insert_mode",
            callback = function()
                local ftype, _ = vim.filetype.match({ buf = 0 })
                if ftype then
                    vim.api.nvim_set_option_value("relativenumber", true, { scope = "local" })
                end
            end,
        })

        vim.api.nvim_create_autocmd("WinEnter", { command = "checktime" })
    end,
}
