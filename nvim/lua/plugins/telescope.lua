return {
    later = function(add)
        add({
            source = "nvim-telescope/telescope.nvim",
            depends = {
                "nvim-lua/plenary.nvim",
                "kkharji/sqlite.lua",
                "nvim-telescope/telescope-frecency.nvim",
            },
        })

        local telescope = require("telescope")
        local telescope_actions = require("telescope.actions")
        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
                grep_string = {
                    additional_args = { "--hidden" },
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
            defaults = {
                generic_sorter = require("mini.fuzzy").get_telescope_sorter,
                mappings = {
                    i = {
                        ["<esc>"] = telescope_actions.close,
                    },
                },
                file_ignore_patterns = {
                    ".git/.*",
                    "node_modules/.*",
                },
            },
            extensions = {
                frecency = {
                    show_unindexed = false,
                },
            },
        })

        telescope.load_extension("frecency")
    end,
}
