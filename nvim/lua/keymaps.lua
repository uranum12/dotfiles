return {
    setup = function()
        vim.keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>")

        vim.keymap.set("n", "<leader>a", "<cmd>vsplit<cr>")
        vim.keymap.set("n", "<leader>s", "<cmd>split<cr>")

        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end)
        vim.keymap.set("n", "<space>r", vim.lsp.buf.rename)
        vim.keymap.set("n", "<space>d", vim.lsp.buf.hover)
        vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
        vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>")
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope frecency<cr>")
        vim.keymap.set("n", "<leader>fw", "<cmd>Telescope frecency workspace=CWD<cr>")
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
        vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
        vim.keymap.set("n", "<leader>fp", "<cmd>Telescope neoclip<cr>")

        vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>")
        vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>")
        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>")
        vim.keymap.set("n", "<leader><leader>", "<cmd>Chowcho<cr>")
    end,
}
