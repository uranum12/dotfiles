return {
    setup = function()
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
