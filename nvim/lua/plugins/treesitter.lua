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
                context_commentstring = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
            })

            require("mini.comment").setup({
                hooks = {
                    pre = function()
                        require("ts_context_commentstring.internal").update_commentstring()
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
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    enable = true,
                    mode = "topline",
                },
            },
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
    },
}
