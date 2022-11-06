local parsers_path = vim.fn.stdpath("data") .. "/treesitter"
vim.opt.runtimepath:append(parsers_path)

require("nvim-treesitter.configs").setup({
    auto_install = true,
    parser_install_dir = parsers_path,
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        max_file_lines = nil,
    },
    context_commentstring = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
})

require("treesitter-context").setup({
    enable = true,
    mode = "topline",
})

require("nvim_context_vt").setup({
    enabled = true,
})
