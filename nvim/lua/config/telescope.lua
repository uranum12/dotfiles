return {
    setup = function()
        local telescope = require("telescope")
        local telescope_actions = require("telescope.actions")
        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
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
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
                file_browser = {
                    mappings = {
                        ["n"] = {
                            ["a"] = telescope.extensions.file_browser.actions.create,
                            ["c"] = telescope.extensions.file_browser.actions.copy,
                            ["m"] = telescope.extensions.file_browser.actions.move,
                            ["r"] = telescope.extensions.file_browser.actions.rename,
                            ["d"] = telescope.extensions.file_browser.actions.remove,
                        },
                    },
                },
                frecency = {
                    show_unindexed = false,
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.load_extension("frecency")
        telescope.load_extension("neoclip")
    end,
}
