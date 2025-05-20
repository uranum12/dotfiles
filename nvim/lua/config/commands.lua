return {
    setup = function()
        vim.api.nvim_create_user_command("BufRemove", function()
            local bufnr_current = vim.fn.bufnr("%")
            local bufnr_alt = vim.fn.bufnr("#")

            for _ = 2, vim.fn.tabpagenr("$") do
                vim.cmd("tabclose 2")
            end

            local windows = vim.fn.win_findbuf(bufnr_current)
            for _, win in ipairs(windows) do
                if bufnr_alt ~= -1 then
                    vim.fn.win_execute(win, "buffer " .. bufnr_alt)
                else
                    vim.fn.win_execute(win, "enew")
                end
            end

            vim.api.nvim_buf_delete(bufnr_current, { force = false })
        end, {})

        vim.api.nvim_create_user_command("HiWord", function()
            vim.fn.setreg("/", [[\<]] .. vim.fn.expand("<cword>") .. [[\>]])
            vim.api.nvim_set_option_value("hlsearch", true, {})
            require("hlslens").start()
        end, {})

        vim.api.nvim_create_user_command("Files", function()
            if not require("mini.files").close() then
                require("mini.files").open()
            end
        end, {})
    end,
}
