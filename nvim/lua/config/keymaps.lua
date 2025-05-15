return {
    setup = function()
        vim.keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>")
        vim.keymap.set("n", "<leader>h", "<cmd>HiWord<cr>", { desc = "highlight the word" })

        vim.keymap.set("n", "<leader>a", "<cmd>vsplit<cr>", { desc = "sprit (left/right)" })
        vim.keymap.set("n", "<leader>s", "<cmd>split<cr>", { desc = "spilit (top/bottom)" })

        vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "select next buffer" })
        vim.keymap.set("n", "<s-tab>", "<cmd>bprev<cr>", { desc = "select previous buffer" })
        vim.keymap.set("n", "<leader>q", "<cmd>BufRemove<cr>", { desc = "remove buffer" })

        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, { desc = "format (lsp)" })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename (lsp)" })
        vim.keymap.set("n", "<leader>d", vim.lsp.buf.hover, { desc = "hover docs (lsp)" })
        vim.keymap.set("n", "<leader>c", vim.lsp.buf.code_action, { desc = "code action (lsp)" })

        vim.keymap.set("n", "<leader>e", "<cmd>Telescope find_files<cr>", { desc = "files (telescope)" })
        vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "grep (telescope)" })
        vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "buffers (telescope)" })

        vim.keymap.set("n", "<leader>w", "<cmd>Files<cr>", { desc = "explorer" })
        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "undotree" })
        vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "terminal" })
    end,
}
