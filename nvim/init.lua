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
        "echasnovski/mini.nvim",
        version = "*",
        event = "VimEnter",
        config = function()
            require("mini.base16").setup({
                palette = {
                    base00 = "#282c34",
                    base01 = "#353b45",
                    base02 = "#3e4451",
                    base03 = "#545862",
                    base04 = "#565c64",
                    base05 = "#abb2bf",
                    base06 = "#b6bdca",
                    base07 = "#c8ccd4",
                    base08 = "#e06c75",
                    base09 = "#d19a66",
                    base0A = "#e5c07b",
                    base0B = "#98c379",
                    base0C = "#56b6c2",
                    base0D = "#61afef",
                    base0E = "#c678dd",
                    base0F = "#be5046",
                },
                use_cterm = true,
            })

            require("mini.statusline").setup({
                content = {
                    active = function()
                        local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
                        local git = require("mini.statusline").section_git({ trunc_width = 75 })
                        local diagnostics = require("mini.statusline").section_diagnostics({ trunc_width = 75 })
                        local filename = require("mini.statusline").section_filename({ trunc_width = 140 })
                        local fileinfo = require("mini.statusline").section_fileinfo({ trunc_width = 120 })
                        local location = require("mini.statusline").section_location({ trunc_width = 75 })

                        return require("mini.statusline").combine_groups({
                            { hl = mode_hl,                  strings = { mode } },
                            "%<",
                            { hl = "MiniStatuslineDevinfo",  strings = { git, diagnostics } },
                            { hl = "MiniStatuslineFilename", strings = { filename } },
                            "%=",
                            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                            { hl = mode_hl,                  strings = { location } },
                        })
                    end,
                },
                set_vim_settings = false,
            })

            require("mini.tabline").setup({
                tabpage_section = "right",
            })

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
                    { name = "Quit NeoVim",     action = "qall", section = "Builtin" },
                }
            end

            local section_update = function()
                return {
                    { name = "Plugin",          action = "Lazy update", section = "Update" },
                    { name = "Language Server", action = "Mason",       section = "Update" },
                    { name = "TreeSitter",      action = "TSUpdate",    section = "Update" },
                }
            end

            local section_telescope = function()
                return {
                    { name = "Files",   action = "Telescope find_files",   section = "Telescope" },
                    { name = "Recent",  action = "Telescope frecency",     section = "Telescope" },
                    { name = "Browser", action = "Telescope file_browser", section = "Telescope" },
                    { name = "Grep",    action = "Telescope live_grep",    section = "Telescope" },
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

            require("mini.cursorword").setup()
            require("mini.indentscope").setup()
            require("mini.pairs").setup()
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })

            require("lspconfig").clangd.setup({
                cmd = {
                    "clangd",
                    "-query-driver",
                    "/usr/bin/*",
                },
            })

            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end)
            vim.keymap.set("n", "<space>r", vim.lsp.buf.rename)
            vim.keymap.set("n", "<space>d", vim.lsp.buf.hover)
            vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action)
        end,
        dependencies = {
            {
                "j-hui/fidget.nvim",
                config = true,
            },
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                config = true,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                config = true,
            },
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    local null_ls = require("null-ls")
                    null_ls.setup({
                        sources = {
                            null_ls.builtins.formatting.stylua,
                            null_ls.builtins.formatting.isort,
                            null_ls.builtins.formatting.black,
                            null_ls.builtins.formatting.cmake_format,
                            null_ls.builtins.formatting.prettier,
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

            require("cmp").setup.cmdline({ "/", "?" }, {
                mapping = require("cmp").mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
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
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = { "c", "lua", "vim", "help", "query" },
                highlight = {
                    enable = true,
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
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    enable = true,
                    mode = "topline",
                },
            },
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
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
        "myusuf3/numbers.vim",
        event = "InsertEnter",
        init = function()
            vim.g.numbers_exclude = {
                "starter",
                "toggleterm",
            }
        end,
    },
    {
        "editorconfig/editorconfig-vim",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "VeryLazy" },
        config = true,
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = { "VeryLazy" },
        config = true,
    },
}

require("lazy").setup(plugins)
