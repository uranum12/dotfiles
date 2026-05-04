return {
    setup = function()
        vim.api.nvim_create_autocmd("WinEnter", { command = "checktime" })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                vim.opt_local.formatoptions:remove({ "r", "o" })

                pcall(vim.treesitter.start)
            end,
        })

        vim.api.nvim_create_autocmd({
            "BufRead",
            "BufWritePost",
        }, {
            pattern = "*",
            callback = function()
                local file_path = vim.api.nvim_buf_get_name(0)
                if file_path ~= "" then
                    vim.system({ "nvim-oldfiles", "add", file_path }, { text = true })
                end
            end,
        })
    end,
}
