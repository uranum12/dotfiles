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
local now, later = require("plugins.setup").setup()

later("plugins.misc")

now("plugins.mini")
later("plugins.mini")

later("plugins.cmp")
later("plugins.lsp")
later("plugins.treesitter")
later("plugins.telescope")
