return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = {
            "ToggleTerm",
            "LazyGit",
        },
        config = function()
            require("toggleterm").setup({
                direction = "float",
            })

            local lazygit = require("toggleterm.terminal").Terminal:new({
                cmd = "lazygit",
                direction = "float",
            })

            vim.api.nvim_create_user_command("LazyGit", function()
                lazygit:toggle()
            end, { nargs = 0 })
        end,
    },
    {
        "tkmpypy/chowcho.nvim",
        cmd = "Chowcho",
        opts = {
            icon_enabled = true,
            border_style = "rounded",
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "mbbill/undotree",
        cmd = {
            "UndotreeToggle",
            "UndotreeHide",
            "UndotreeShow",
            "UndotreeFocus",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        config = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = true,
    },
}
