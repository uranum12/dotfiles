-- bytecode loader
if vim.loader then
    vim.loader.enable()
end

-- providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- configs
require("config.options").setup()
require("config.autocmds").setup()
require("config.keymaps").setup()
require("config.commands").setup()

-- plugins
vim.pack.add({
    -- mini
    "https://github.com/nvim-mini/mini.nvim",
    -- treesitter
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    -- cmp
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = vim.version.range("*"),
    },
    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/stevearc/conform.nvim",
    -- misc
    "https://github.com/mbbill/undotree",
})

require("plugins.mini").setup()
require("plugins.treesitter").setup()

vim.defer_fn(function()
    require("plugins.cmp").setup()
    require("plugins.lsp").setup()
    require("plugins.misc").setup()

    -- features
    require("features.hilens").setup()
    require("features.number").setup()
    require("features.terminal").setup()
    require("features.localconfig").setup()
end, 100)
