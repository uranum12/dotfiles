return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = { "c", "lua", "vim", "query" },
                highlight = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
            })

            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    enable = true,
                    mode = "topline",
                },
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = {
                    enable_autocmd = false,
                    languages = {
                        cpp = "// %s",
                    }
                },
            },
            "windwp/nvim-ts-autotag",
        },
    },
}
