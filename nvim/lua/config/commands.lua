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
            require("features.hilens").update()
        end, {})

        vim.api.nvim_create_user_command("HiClear", function()
            vim.cmd("nohlsearch")
            require("features.hilens").clear()
        end, {})

        vim.api.nvim_create_user_command("Files", function()
            if not require("mini.files").close() then
                require("mini.files").open()
            end
        end, {})

        vim.api.nvim_create_user_command("PickFiles", function()
            local pick = require("mini.pick")
            pick.builtin.cli({
                command = { "fd", "--hidden", "--type", "f", "--exclude", ".git" },
            }, {
                source = {
                    name = "Files",
                    show = function(buf_id, items, query)
                        pick.default_show(buf_id, items, query, { show_icons = true })
                    end,
                },
            })
        end, {})

        vim.api.nvim_create_user_command("PickAllFiles", function()
            local pick = require("mini.pick")
            pick.builtin.cli({
                command = { "fd", "--unrestricted", "--type", "f" },
            }, {
                source = {
                    name = "All Files",
                    show = function(buf_id, items, query)
                        pick.default_show(buf_id, items, query, { show_icons = true })
                    end,
                },
            })
        end, {})

        vim.api.nvim_create_user_command("PickOldFiles", function()
            local pick = require("mini.pick")

            local valid_items = {}
            for _, path in ipairs(vim.v.oldfiles) do
                if vim.fn.filereadable(path) == 1 then
                    table.insert(valid_items, path)
                end
            end

            pick.start({
                source = {
                    items = valid_items,
                    name = "Old Files",
                    show = function(buf_id, items, query)
                        pick.default_show(buf_id, items, query, { show_icons = true })
                    end,
                },
            })
        end, {})
    end,
}
