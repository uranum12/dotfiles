require('lspsaga').init_lsp_saga({
  code_action_lightbulb = {
    virtual_text = false,
  },
  finder_action_keys = {
    open = "<CR>",
    quit = "<esc>",
  },
  code_action_keys = {
    quit = "<esc>",
    exec = "<CR>",
  },
  symbol_in_winbar = {
    enable = false,
  },
})
vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "<Space>k", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<Space>g", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>", { silent = true })

