vim.opt.scrolloff = 20
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.laststatus = 3

vim.g.mapleader = "."

require("keymap")
require("autocmd")
require("plugin")
require("plugin.mini")
require("plugin.misc")
require("plugin.treesitter")
require("plugin.telescope")
require("plugin.cmp")
require("plugin.lsp")
