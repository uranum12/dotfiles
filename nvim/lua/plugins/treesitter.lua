return {
    now = function(add)
        add({
            source = "nvim-treesitter/nvim-treesitter",
            checkout = "main",
            depends = {
                "nvim-treesitter/nvim-treesitter-context",
                "JoosepAlviste/nvim-ts-context-commentstring",
            },
        })

        require("nvim-treesitter").setup()

        require("treesitter-context").setup({
            enable = true,
            mode = "topline",
        })

        require("ts_context_commentstring").setup({
            enable_autocmd = false,
            languages = {
                c = "// %s",
                cpp = "// %s",
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
}
