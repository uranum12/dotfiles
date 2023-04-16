return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        config = function()
            require("config.telescope").setup()
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "kkharji/sqlite.lua",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = {
                    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release" ..
                    " && cmake --build build --config Release" ..
                    " && cmake --install build --prefix build",
                },
            },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            {
                "AckslD/nvim-neoclip.lua",
                event = "VeryLazy",
                config = true,
            },
        },
    },
}
