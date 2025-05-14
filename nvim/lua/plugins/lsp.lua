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
            signs = false,
            virtual_text = false,
            virtual_lines = {
                format = function(diagnostic)
                    local prefix = diagnostic.code and string.format("%s: ", diagnostic.code) or ""
                    local message = string.format("%s (%s)", diagnostic.message, diagnostic.source)
                    return prefix .. message
                end,
            },
        })
    end,
}
