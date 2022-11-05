vim.opt.scrolloff = 20
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.laststatus = 3

vim.g.mapleader = "."

vim.keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("n", "<leader>a", "<cmd>vsplit<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>split<cr>")

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")

vim.keymap.set("n", "<leader><leader>", "<cmd>Chowcho<cr>")
vim.keymap.set("n", "<leader>m", "<cmd>TableModeToggle<cr>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>")

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>")
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope frecency<cr>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope frecency workspace=CWD<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope neoclip<cr>")

vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
end)
vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<cr>")
vim.keymap.set("n", "<space>k", "<cmd>Lspsaga hover_doc<cr>")
vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<cr>")
vim.keymap.set("n", "<space>g", "<cmd>Lspsaga peek_definition<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>Lspsaga lsp_finder<cr>")
vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>")

vim.api.nvim_create_augroup("number_insert_mode", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = "number_insert_mode",
    callback = function()
        local ftype, _ = vim.filetype.match({ buf = 0 })
        if ftype then
            vim.opt_local.relativenumber = false
        end
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = "number_insert_mode",
    callback = function()
        local ftype, _ = vim.filetype.match({ buf = 0 })
        if ftype then
            vim.opt_local.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "WinEnter" }, {
    callback = function()
        local ftype, _ = vim.filetype.match({ buf = 0 })
        if ftype then
            MiniMap.open()
        end
    end,
})

local jetpackfile = vim.fn.stdpath("data") .. "/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
    vim.fn.system("curl -fsSLo " .. jetpackfile .. " --create-dirs " .. jetpackurl)
end

vim.cmd("packadd vim-jetpack")
local jetpack = require("jetpack")

jetpack["begin"]()

jetpack["add"]("tani/vim-jetpack", { opt = true })

jetpack["add"]("nvim-lua/plenary.nvim")
jetpack["add"]("kkharji/sqlite.lua")
jetpack["add"]("kyazdani42/nvim-web-devicons")

jetpack["add"]("echasnovski/mini.nvim")

jetpack["add"]("lewis6991/gitsigns.nvim")

jetpack["add"]("akinsho/toggleterm.nvim")

jetpack["add"]("windwp/nvim-autopairs")

jetpack["add"]("gpanders/editorconfig.nvim")

jetpack["add"]("kevinhwang91/nvim-hlslens")

jetpack["add"]("mechatroner/rainbow_csv")

jetpack["add"]("tkmpypy/chowcho.nvim")

jetpack["add"]("mbbill/undotree")

jetpack["add"]("dhruvasagar/vim-table-mode")

jetpack["add"]("nvim-treesitter/nvim-treesitter", { branch = "v0.8.0" })
jetpack["add"]("nvim-treesitter/nvim-treesitter-context", { opt = true })
jetpack["add"]("haringsrob/nvim_context_vt")
jetpack["add"]("p00f/nvim-ts-rainbow")
jetpack["add"]("JoosepAlviste/nvim-ts-context-commentstring")
jetpack["add"]("windwp/nvim-ts-autotag", { opt = true })

jetpack["add"]("neovim/nvim-lspconfig")
jetpack["add"]("williamboman/mason.nvim")
jetpack["add"]("williamboman/mason-lspconfig.nvim")
jetpack["add"]("j-hui/fidget.nvim")
jetpack["add"]("SmiteshP/nvim-navic")
jetpack["add"]("folke/trouble.nvim")
jetpack["add"]("glepnir/lspsaga.nvim")
jetpack["add"]("simrat39/symbols-outline.nvim")

jetpack["add"]("hrsh7th/nvim-cmp")
jetpack["add"]("hrsh7th/cmp-nvim-lsp")
jetpack["add"]("hrsh7th/cmp-path")
jetpack["add"]("hrsh7th/cmp-cmdline")
jetpack["add"]("hrsh7th/cmp-buffer")
jetpack["add"]("hrsh7th/cmp-nvim-lsp-signature-help")
jetpack["add"]("hrsh7th/cmp-nvim-lsp-document-symbol")
jetpack["add"]("saadparwaiz1/cmp_luasnip")
jetpack["add"]("onsails/lspkind.nvim")

jetpack["add"]("L3MON4D3/LuaSnip")
jetpack["add"]("rafamadriz/friendly-snippets")

jetpack["add"]("nvim-telescope/telescope.nvim", { tag = "0.1.0" })
jetpack["add"]("nvim-telescope/telescope-file-browser.nvim")
jetpack["add"]("nvim-telescope/telescope-frecency.nvim")
jetpack["add"]("AckslD/nvim-neoclip.lua")

for _, name in next, jetpack["names"]() do
    if not jetpack["tap"](name) then
        jetpack["sync"]()
        break
    end
end

jetpack["end"]()
jetpack["load"]("nvim-treesitter-context")
jetpack["load"]("nvim-ts-autotag")

require("mini.tabline").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.bufremove").setup()
require("mini.surround").setup()
require("mini.jump").setup()
require("mini.jump2d").setup()
require("mini.trailspace").setup()
require("gitsigns").setup()
require("hlslens").setup()
require("nvim-navic").setup()
require("nvim-autopairs").setup()
require("fidget").setup()
require("trouble").setup()
require("symbols-outline").setup()

require("chowcho").setup({
    icon_enabled = true,
    border_style = "rounded",
})

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

local navic = require("nvim-navic")

require("mini.statusline").setup({
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })

            local navigation = ""
            if navic.is_available() then
                navigation = navic.get_location()
            end

            return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                "%<",
                { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                { hl = "MiniStatuslineFilename", strings = { navigation } },
                "%=",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { location } },
            })
        end,
    },
    set_vim_settings = false,
})

local starter = require("mini.starter")

local header_art = [[
                +                            ___
                                 *        ,o88888
        /                              ,o8888888'
       /         ,:o:o:oooo.        ,8O88Pd8888"
      /      ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"
     /     ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"
    *     , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"
         , ..:.::o:ooOoOO8O888O8O,COCOO"       o
        , . ..:.::o:ooOoOOOO8OOOOCOCO"
         . ..:.::o:ooOoOoOO8O8OCCCC"o
            . ..:.::o:ooooOoCoCCC"o:o
            . ..:.::o:o:,cooooCo"oo:o:    .
   *     `   . . ..:.:cocoooo"'o:o:::'    :
         .`   . ..::ccccoc"'o:o:o:::'    -+-
        :.:.    ,c:cccc"':.:.:.:.:.'      :
      ..:.:"'`::::c:"'..:.:.:.:.:.'       '
    ...:.'.:.::::"'    . . . . .'    ~+
   .. . ....:."' `   .  . . ''                +
 . . . ...."'                   ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
 .. . ."'                       │││├┤ │ │╰┐┌╯││││
                         *      ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]]

local footer_hook = function()
    local version = vim.version()
    local neovim_version = "  " .. version.major .. "." .. version.minor .. "." .. version.patch
    local total_plugins = "  " .. #require("jetpack").names()
    return "               " .. neovim_version .. "     " .. total_plugins
end

local section_update = function()
    return {
        { name = "Plugin", action = "JetpackSync", section = "Update" },
        { name = "TreeSitter", action = "TSUpdateSync", section = "Update" },
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

starter.setup({
    autoopen = true,
    header = header_art,
    footer = footer_hook,
    items = {
        starter.sections.builtin_actions(),
        section_update,
        section_telescope,
        starter.sections.recent_files(7, true, false),
    },
    content_hooks = {
        starter.gen_hook.adding_bullet("» "),
        starter.gen_hook.indexing("all", { "Builtin actions", "Update", "Telescope" }),
        starter.gen_hook.aligning("center", "center"),
    },
})

local context_commentstring = require("ts_context_commentstring.internal")

require("mini.comment").setup({
    hooks = {
        pre = function()
            context_commentstring.update_commentstring()
        end,
    },
})

local map = require("mini.map")

map.setup({
    symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
    },
    integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
    },
})

local parsers_path = vim.fn.stdpath("data") .. "/treesitter"
vim.opt.runtimepath:append(parsers_path)

require("nvim-treesitter.configs").setup({
    auto_install = true,
    parser_install_dir = parsers_path,
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

require("treesitter-context").setup({
    enable = true,
    mode = "topline",
})

require("nvim_context_vt").setup({
    enabled = true,
})

local lspconfig = require("lspconfig")

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
})

lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd",
        "-query-driver",
        "/usr/bin/*",
    },
})

require("lspsaga").init_lsp_saga({
    code_action_lightbulb = {
        virtual_text = false,
    },
    finder_action_keys = {
        open = "<CR>",
        quit = { "q", "<ESC>" },
    },
    code_action_keys = {
        exec = "<CR>",
        quit = { "q", "<ESC>" },
    },
    rename_action_quit = "<esc>",
    symbol_in_winbar = {
        enable = false,
    },
})

local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "text_symbol",
            maxwidth = 50,
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
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

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["<esc>"] = telescope_actions.close,
            },
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

require("neoclip").setup()

telescope.load_extension("file_browser")
telescope.load_extension("frecency")
telescope.load_extension("neoclip")

