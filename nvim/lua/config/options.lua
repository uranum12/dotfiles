return {
    setup = function()
        vim.api.nvim_set_option_value("scrolloff", 20, {})
        vim.api.nvim_set_option_value("ignorecase", true, {})
        vim.api.nvim_set_option_value("hidden", true, {})
        vim.api.nvim_set_option_value("autoread", true, {})
        vim.api.nvim_set_option_value("number", true, {})
        vim.api.nvim_set_option_value("relativenumber", true, {})
        vim.api.nvim_set_option_value("termguicolors", true, {})
        vim.api.nvim_set_option_value("undofile", true, {})
        vim.api.nvim_set_option_value("undodir", vim.fn.stdpath("cache") .. "/undo", {})
        vim.api.nvim_set_option_value("directory", vim.fn.stdpath("cache") .. "/swap", {})
        vim.api.nvim_set_option_value("laststatus", 3, {})

        vim.g.mapleader = " "
    end,
}
