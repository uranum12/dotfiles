return {
    later = function(add)
        add({
            source = "neovim/nvim-lspconfig",
            depends = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
            },
        })

        require("mason").setup()
        require("mason-lspconfig").setup()

        vim.lsp.enable({ "clangd" })
    end,
}
