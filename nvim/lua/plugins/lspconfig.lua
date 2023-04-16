return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })

            require("lspconfig").clangd.setup({
                cmd = {
                    "clangd",
                    "-query-driver",
                    "/usr/bin/*",
                },
            })
        end,
        dependencies = {
            {
                "j-hui/fidget.nvim",
                config = true,
            },
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                config = true,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = true,
            },
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    local null_ls = require("null-ls")
                    null_ls.setup({
                        sources = {
                            null_ls.builtins.formatting.stylua,
                            null_ls.builtins.formatting.isort,
                            null_ls.builtins.formatting.black,
                            null_ls.builtins.formatting.cmake_format,
                            null_ls.builtins.formatting.prettier,
                        },
                    })
                end,
            },
        },
    },
}
