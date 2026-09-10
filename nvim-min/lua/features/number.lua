return {
    setup = function()
        local group = vim.api.nvim_create_augroup("number_insert_mode", { clear = true })

        local function set_relativenumber(value)
            if vim.bo.buftype ~= "" then
                return
            end

            vim.opt_local.relativenumber = value
        end

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = group,
            callback = function()
                set_relativenumber(false)
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            group = group,
            callback = function()
                set_relativenumber(true)
            end,
        })
    end,
}
