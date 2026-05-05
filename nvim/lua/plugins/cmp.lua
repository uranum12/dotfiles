return {
    setup = function()
        require("blink.cmp").setup({
            keymap = {
                preset = "none",
                ["<C-e>"] = { "cancel", "hide_signature" },
                ["<CR>"] = { "accept", "fallback" },
                ["<TAB>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 2 },
                            { "kind", "source_name", gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                },
            },
            signature = { enabled = true },
        })
    end,
}
