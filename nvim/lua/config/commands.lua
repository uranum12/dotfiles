return {
    setup = function()
        vim.api.nvim_create_user_command("X", function()
            -- vim.api.nvim_buf_delete(0, { force = false })
            require("mini.bufremove").delete(0, false)

            local current_tab = vim.fn.tabpagenr()
            local total_tabs = vim.fn.tabpagenr("$")

            if total_tabs > 1 then
                for i = total_tabs, 1, -1 do
                    if i ~= current_tab then
                        vim.cmd(i .. "tabclose")
                    end
                end
            end
        end, {})
    end,
}
