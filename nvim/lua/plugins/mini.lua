return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        event = "VimEnter",
        config = function()
            require("config.mini").setup()
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
}
