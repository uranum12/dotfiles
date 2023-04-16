return {
    setup = function()
        vim.opt.scrolloff = 20
        vim.opt.ignorecase = true
        vim.opt.hidden = true
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.termguicolors = true
        vim.opt.undofile = true
        vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
        vim.opt.directory = vim.fn.stdpath("cache") .. "/swap"
        vim.opt.laststatus = 3

        vim.g.mapleader = "."
    end,
}
