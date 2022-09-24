local telescope = require("telescope")
local telescope_actions = require('telescope.actions')

require('neoclip').setup()

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["<esc>"] = telescope_actions.close,
      },
      i = {
        ["<esc>"] = telescope_actions.close,
      }
    }
  }
})
telescope.load_extension("file_browser")
telescope.load_extension("frecency")
telescope.load_extension("neoclip")

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files hidden=true<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fe", "<cmd>Telescope file_browser hidden=true<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fr", "<cmd>Telescope frecency workspace=CWD<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fk", "<cmd>Telescope keymaps<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fp", "<cmd>Telescope neoclip<CR>", opts)

