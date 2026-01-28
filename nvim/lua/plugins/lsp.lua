return {
    later = function(add)
        add({
            source = "neovim/nvim-lspconfig",
            depends = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
            },
        })

        add("stevearc/conform.nvim")

        require("mason").setup()
        require("mason-lspconfig").setup()

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                yaml = { "yamlfmt" },
                toml = { "taplo" },
                cmake = { "cmake_format" },
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
