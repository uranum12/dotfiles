require("nvim-navic").setup()
require("fidget").setup()
require("trouble").setup()
require("symbols-outline").setup()
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
