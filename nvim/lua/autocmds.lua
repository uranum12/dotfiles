return {
    setup = function()
        vim.api.nvim_create_augroup("number_insert_mode", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            group = "number_insert_mode",
            callback = function()
                local ftype, _ = vim.filetype.match({ buf = 0 })
                if ftype then
                    vim.opt_local.relativenumber = false
                end
            end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            group = "number_insert_mode",
            callback = function()
                local ftype, _ = vim.filetype.match({ buf = 0 })
                if ftype then
                    vim.opt_local.relativenumber = true
                end
            end,
        })
    end,
}
