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
    -- misc
    "https://github.com/jiaoshijie/undotree",
})

require("plugins.mini").setup()
require("plugins.treesitter").setup()

vim.defer_fn(function()
    require("plugins.misc").setup()

    -- features
    require("features.hilens").setup()
    require("features.number").setup()
    require("features.terminal").setup()
    require("features.localconfig").setup()
end, 100)
