return {
    now = function(add)
        add("nvim-tree/nvim-web-devicons")
        require("nvim-web-devicons").setup()
    end,
    later = function(add)
        add("akinsho/toggleterm.nvim")
        require("toggleterm").setup({
            direction = "float",
            persist_mode = false,
        })

        add("mbbill/undotree")
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1

        add("lewis6991/gitsigns.nvim")
        require("gitsigns").setup()

        add("kevinhwang91/nvim-hlslens")
        require("hlslens").setup()
        vim.api.nvim_set_hl(0, "HlSearchLens", { link = "Search" })
    end,
}
