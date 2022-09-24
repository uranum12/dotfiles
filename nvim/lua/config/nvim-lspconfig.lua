local nvim_lsp = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local navic = require("nvim-navic")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd",        "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD",        "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi",        "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gt",        "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Space>f",  "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  if client.name ~= "cmake" then
    navic.attach(client, bufnr)
  end
end

nvim_lsp.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"clangd", "-query-driver", "/usr/bin/arm-none-eabi-gcc"}
})

mason_lspconfig.setup_handlers({
  function(server_name)
    nvim_lsp[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities
    })
  end
})

