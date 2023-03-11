vim.opt.scrolloff = 20
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.directory = vim.fn.stdpath("cache") .. "/swap"
vim.opt.laststatus = 3

vim.g.mapleader = "."

vim.keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<leader>a", "<cmd>vsplit<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>split<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                options = {
                    transparency = true,
                    cursorline = true,
                },
            })
            vim.cmd("colorscheme onedark")
        end,
    },
    {
        "folke/noice.nvim",
        config = true,
        event = "VimEnter",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    background_colour = "#000000",
                },
            },
        },
    },
    {
        "romgrk/barbar.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = "VimEnter",
	opts = {
		excluded_buftypes = {
			"starter",
			"toggleterm",
		}
	},
        config = true,
    },
    {
        "echasnovski/mini.starter",
        event = "VimEnter",
        config = function()
            local header_art = table.concat({
                [[                +                            ___]],
                [[                                 *        ,o88888]],
                [[        /                              ,o8888888']],
                [[       /         ,:o:o:oooo.        ,8O88Pd8888"]],
                [[      /      ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"]],
                [[     /     ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"]],
                [[    *     , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"]],
                [[         , ..:.::o:ooOoOO8O888O8O,COCOO"       o]],
                [[        , . ..:.::o:ooOoOOOO8OOOOCOCO"]],
                [[         . ..:.::o:ooOoOoOO8O8OCCCC"o]],
                [[            . ..:.::o:ooooOoCoCCC"o:o]],
                [[            . ..:.::o:o:,cooooCo"oo:o:    .]],
                [[   *     `   . . ..:.:cocoooo"'o:o:::'    :]],
                [[         .`   . ..::ccccoc"'o:o:o:::'    -+-]],
                [[        :.:.    ,c:cccc"':.:.:.:.:.'      :]],
                [[      ..:.:"'`::::c:"'..:.:.:.:.:.'       ']],
                [[    ...:.'.:.::::"'    . . . . .'    ~+]],
                [[   .. . ....:."' `   .  . . ''                +]],
                [[ . . . ...."'                   ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮]],
                [[ .. . ."'                       │││├┤ │ │╰┐┌╯││││]],
                [[                         *      ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴]],
            }, "\n")

            local footer_hook = function()
                local version = vim.version()
                local neovim_version = "  " .. version.major .. "." .. version.minor .. "." .. version.patch
                local total_plugins = "  " .. require("lazy").stats().count
                return "               " .. neovim_version .. "     " .. total_plugins
            end

            local section_builtin = function()
                return {
                    { name = "Edit new buffer", action = "enew", section = "Builtin" },
                    { name = "Quit NeoVim", action = "qall", section = "Builtin" },
                }
            end

            local section_update = function()
                return {
                    { name = "Plugin", action = "Lazy update", section = "Update" },
                    { name = "Language Server", action = "Mason", section = "Update" },
                    { name = "TreeSitter", action = "TSUpdate", section = "Update" },
                }
            end

            local section_telescope = function()
                return {
                    { name = "Files", action = "Telescope find_files", section = "Telescope" },
                    { name = "Recent", action = "Telescope frecency", section = "Telescope" },
                    { name = "Browser", action = "Telescope file_browser", section = "Telescope" },
                    { name = "Grep", action = "Telescope live_grep", section = "Telescope" },
                }
            end

            local section_recent_files = function()
                local cwd = vim.loop.cwd()
                local files = vim.tbl_filter(function(f)
                    return vim.fn.filereadable(f) == 1
                end, vim.v.oldfiles or {})
                files = vim.tbl_filter(function(f)
                    return f:sub(1, cwd:len()) == cwd
                end, files)
                if #files == 0 then
                    return { { name = "There are no recent files", action = "", section = "Recent files" } }
                end
                local items = {}
                for _, f in next, vim.list_slice(files, 1, 7) do
                    local path = vim.fn.fnamemodify(f, ":~:.")
                    table.insert(items, { name = path, action = "edit " .. path, section = "Recent files" })
                end
                return items
            end

            require("mini.starter").setup({
                autoopen = true,
                header = header_art,
                footer = footer_hook,
                items = {
                    section_builtin,
                    section_update,
                    section_telescope,
                    section_recent_files,
                },
                content_hooks = {
                    require("mini.starter").gen_hook.adding_bullet("» "),
                    require("mini.starter").gen_hook.indexing("all", { "Builtin", "Update", "Telescope" }),
                    require("mini.starter").gen_hook.aligning("center", "center"),
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "onedark",
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        {
                            function()
                                return require("nvim-navic").get_location()
                            end,
                            cond = function()
                                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = { "filename" },
                    lualine_y = { "encoding", "filetype" },
                    lualine_z = { "location" },
                },
            })
        end,
        dependencies = {
            "olimorris/onedarkpro.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "VeryLazy" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
            })

            require("lspconfig").clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "-query-driver",
                    "/usr/bin/*",
                },
            })

            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end)
            vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<cr>")
            vim.keymap.set("n", "<space>d", "<cmd>Lspsaga hover_doc<cr>")
            vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>")
            vim.keymap.set("n", "<space>g", "<cmd>Lspsaga peek_definition<cr>")
            vim.keymap.set("n", "<leader>l", "<cmd>Lspsaga lsp_finder<cr>")
            vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>")
            vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>")
        end,
        dependencies = {
            {
                "williamboman/mason.nvim",
                cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = true,
            },
            {
                "j-hui/fidget.nvim",
                config = true,
            },
            {
                "SmiteshP/nvim-navic",
                config = true,
            },
            {
                "folke/trouble.nvim",
                config = true,
            },
            {
                "simrat39/symbols-outline.nvim",
                config = true,
            },
            {
                "glepnir/lspsaga.nvim",
                opts = {
                    code_action_lightbulb = {
                        virtual_text = false,
                    },
                    finder_action_keys = {
                        open = "<CR>",
                        quit = "q",
                    },
                    code_action_keys = {
                        exec = "<CR>",
                        quit = "q",
                    },
                    rename_action_quit = "<esc>",
                    symbol_in_winbar = {
                        enable = false,
                    },
                },
            },
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("null-ls").setup({
                        sources = {
                            require("null-ls").builtins.formatting.stylua,
                        },
                    })
                end,
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            require("cmp").setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "text_symbol",
                        maxwidth = 50,
                    }),
                },
                mapping = require("cmp").mapping.preset.insert({
                    ["<C-e>"] = require("cmp").mapping.abort(),
                    ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
                    ["<Tab>"] = require("cmp").mapping(function(fallback)
                        if require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = require("cmp").mapping(function(fallback)
                        if require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = require("cmp").config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lsp_signature_help" },
                }, {
                    { name = "buffer" },
                }),
            })

            require("cmp").setup.cmdline("/", {
                mapping = require("cmp").mapping.preset.cmdline(),
                sources = require("cmp").config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            require("cmp").setup.cmdline(":", {
                mapping = require("cmp").mapping.preset.cmdline(),
                sources = require("cmp").config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "VeryLazy" },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = { "c", "lua", "vim", "help", "query" },
                highlight = {
                    enable = true,
                },
                rainbow = {
                    enable = true,
                    max_file_lines = nil,
                },
                context_commentstring = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
            })

            require("mini.comment").setup({
                hooks = {
                    pre = function()
                        require("ts_context_commentstring.internal").update_commentstring()
                    end,
                },
            })
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    enable = true,
                    mode = "topline",
                },
            },
            {
                "haringsrob/nvim_context_vt",
                opts = {
                    enabled = true,
                },
            },
            "p00f/nvim-ts-rainbow",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
            "echasnovski/mini.comment",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                defaults = {
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
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
                                ["a"] = require("telescope").extensions.file_browser.actions.create,
                                ["c"] = require("telescope").extensions.file_browser.actions.copy,
                                ["m"] = require("telescope").extensions.file_browser.actions.move,
                                ["r"] = require("telescope").extensions.file_browser.actions.rename,
                                ["d"] = require("telescope").extensions.file_browser.actions.remove,
                            },
                        },
                    },
                    frecency = {
                        show_unindexed = false,
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("neoclip")
        end,
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>" },
            { "<leader>fe", "<cmd>Telescope file_browser<cr>" },
            { "<leader>fr", "<cmd>Telescope frecency<cr>" },
            { "<leader>fw", "<cmd>Telescope frecency workspace=CWD<cr>" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>" },
            { "<leader>fp", "<cmd>Telescope neoclip<cr>" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "kkharji/sqlite.lua",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = {
                    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                },
            },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            {
                "AckslD/nvim-neoclip.lua",
                event = { "VeryLazy" },
                config = true,
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = {
            "ToggleTerm",
            "LazyGit",
        },
        keys = {
            { "<leader>t", "<cmd>ToggleTerm<cr>" },
            { "<leader>g", "<cmd>LazyGit<cr>" },
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

            vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
        end,
    },
    {
        "gpanders/editorconfig.nvim",
        event = { "VeryLazy" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "VeryLazy" },
        config = true,
    },
    {
        "mbbill/undotree",
        cmd = {
            "UndotreeToggle",
            "UndotreeHide",
            "UndotreeShow",
            "UndotreeFocus",
        },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>" },
        },
    },
    {
        "tkmpypy/chowcho.nvim",
        cmd = "Chowcho",
        keys = {
            { "<leader><leader>", "<cmd>Chowcho<cr>" },
        },
        opts = {
            icon_enabled = true,
            border_style = "rounded",
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "echasnovski/mini.cursorword",
        event = { "VeryLazy" },
        config = function()
            require("mini.cursorword").setup()
        end,
    },
    {
        "echasnovski/mini.indentscope",
        event = { "VeryLazy" },
        config = function()
            require("mini.indentscope").setup()
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = { "VeryLazy" },
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "myusuf3/numbers.vim",
        event = "InsertEnter",
        config = function()
            vim.g.numbers_exclude = {
                "starter",
		"toggleterm",
            }
        end,
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = { "VeryLazy" },
        config = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = { "VeryLazy" },
        config = true,
    },
    {
        "mechatroner/rainbow_csv",
        ft = "csv",
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}

require("lazy").setup(plugins)
