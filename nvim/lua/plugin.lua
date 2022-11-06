local jetpackfile = vim.fn.stdpath("data") .. "/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
    vim.fn.system("curl -fsSLo " .. jetpackfile .. " --create-dirs " .. jetpackurl)
end

vim.cmd("packadd vim-jetpack")
local jetpack = require("jetpack")

jetpack["begin"]()

jetpack["add"]("tani/vim-jetpack", { opt = true })

jetpack["add"]("nvim-lua/plenary.nvim")
jetpack["add"]("kkharji/sqlite.lua")
jetpack["add"]("kyazdani42/nvim-web-devicons")

jetpack["add"]("echasnovski/mini.nvim")

jetpack["add"]("lewis6991/gitsigns.nvim")
jetpack["add"]("akinsho/toggleterm.nvim")
jetpack["add"]("windwp/nvim-autopairs")
jetpack["add"]("gpanders/editorconfig.nvim")
jetpack["add"]("kevinhwang91/nvim-hlslens")
jetpack["add"]("norcalli/nvim-colorizer.lua")
jetpack["add"]("mechatroner/rainbow_csv")
jetpack["add"]("tkmpypy/chowcho.nvim")
jetpack["add"]("mbbill/undotree")
jetpack["add"]("L3MON4D3/LuaSnip")
jetpack["add"]("rafamadriz/friendly-snippets")

jetpack["add"]("nvim-treesitter/nvim-treesitter", { branch = "v0.8.0" })
jetpack["add"]("nvim-treesitter/nvim-treesitter-context", { opt = true })
jetpack["add"]("haringsrob/nvim_context_vt")
jetpack["add"]("p00f/nvim-ts-rainbow")
jetpack["add"]("JoosepAlviste/nvim-ts-context-commentstring")
jetpack["add"]("windwp/nvim-ts-autotag", { opt = true })

jetpack["add"]("neovim/nvim-lspconfig")
jetpack["add"]("williamboman/mason.nvim")
jetpack["add"]("williamboman/mason-lspconfig.nvim")
jetpack["add"]("j-hui/fidget.nvim")
jetpack["add"]("SmiteshP/nvim-navic")
jetpack["add"]("folke/trouble.nvim")
jetpack["add"]("glepnir/lspsaga.nvim")
jetpack["add"]("simrat39/symbols-outline.nvim")

jetpack["add"]("hrsh7th/nvim-cmp")
jetpack["add"]("hrsh7th/cmp-nvim-lsp")
jetpack["add"]("hrsh7th/cmp-path")
jetpack["add"]("hrsh7th/cmp-cmdline")
jetpack["add"]("hrsh7th/cmp-buffer")
jetpack["add"]("hrsh7th/cmp-nvim-lsp-signature-help")
jetpack["add"]("hrsh7th/cmp-nvim-lsp-document-symbol")
jetpack["add"]("saadparwaiz1/cmp_luasnip")
jetpack["add"]("onsails/lspkind.nvim")

jetpack["add"]("nvim-telescope/telescope.nvim", { tag = "0.1.0" })
jetpack["add"]("nvim-telescope/telescope-file-browser.nvim")
jetpack["add"]("nvim-telescope/telescope-frecency.nvim")
jetpack["add"]("AckslD/nvim-neoclip.lua")

for _, name in next, jetpack["names"]() do
    if not jetpack["tap"](name) then
        jetpack["sync"]()
        break
    end
end

jetpack["end"]()
jetpack["load"]("nvim-treesitter-context")
jetpack["load"]("nvim-ts-autotag")
