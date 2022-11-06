local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local file_browser_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["q"] = telescope_actions.close,
            },
        },
        file_ignore_patterns = {
            ".git/.*",
            "node_modules/.*",
        },
    },
    extensions = {
        file_browser = {
            mappings = {
                ["n"] = {
                    ["a"] = file_browser_actions.create,
                    ["c"] = file_browser_actions.copy,
                    ["m"] = file_browser_actions.move,
                    ["r"] = file_browser_actions.rename,
                    ["d"] = file_browser_actions.remove,
                },
            },
        },
        frecency = {
            show_unindexed = false,
        },
    },
})

require("neoclip").setup()

telescope.load_extension("file_browser")
telescope.load_extension("frecency")
telescope.load_extension("neoclip")
