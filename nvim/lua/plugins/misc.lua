return {
    later = function(add)
        add("akinsho/toggleterm.nvim")
        require("toggleterm").setup({
            direction = "float",
            persist_mode = false,
        })

        add("mbbill/undotree")
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1

        add("kevinhwang91/nvim-hlslens")
        require("hlslens").setup()
        vim.api.nvim_set_hl(0, "HlSearchLens", { link = "Search" })
    end,
}
