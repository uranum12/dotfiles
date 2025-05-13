return {
    later = function(add)
        add({
            source = "neovim/nvim-lspconfig",
            depends = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "nvimtools/none-ls.nvim",
            },
        })

        require("mason").setup()
        require("mason-lspconfig").setup()

        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
            },
        })

        vim.lsp.enable({ "clangd" })

        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
        })
    end,
}
