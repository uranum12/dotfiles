require("toggleterm").setup({
  direction = "float"
})

local lazygit = require("toggleterm.terminal").Terminal:new({
  cmd = "lazygit",
  direction = "float",
})

function _lazygit_toggle()
  lazygit:toggle()
end

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>ToggleTerm<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", opts)

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "t", "<Esc><Esc>", [[<C-\><C-n>]], { noremap = true })
  end
})

