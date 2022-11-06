require("gitsigns").setup()
require("hlslens").setup()
require("nvim-autopairs").setup()
require("colorizer").setup()

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

require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
