return {
    later = function(add)
        add({
            source = "hrsh7th/nvim-cmp",
            depends = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
            },
        })

        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = {
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
