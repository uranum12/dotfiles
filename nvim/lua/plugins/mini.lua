return {
    now = function(add)
        local icons = require("mini.icons")
        icons.setup()
        icons.mock_nvim_web_devicons()

        require("mini.diff").setup({
            view = {
                style = "sign",
                signs = { add = "┃", change = "┃", delete = "_" },
            },
        })

        require("mini.basics").setup({
            options = {
                basic = true,
                extra_ui = true,
                win_borders = "double",
            },
            mapping = {
                basic = false,
                option_toggle_prefix = "",
            },
            autocommands = {
                basic = false,
            },
        })

        require("mini.base16").setup({
            palette = {
                base00 = "#282c34",
                base01 = "#353b45",
                base02 = "#3e4451",
                base03 = "#545862",
                base04 = "#565c64",
                base05 = "#abb2bf",
                base06 = "#b6bdca",
                base07 = "#c8ccd4",
                base08 = "#e06c75",
                base09 = "#d19a66",
                base0A = "#e5c07b",
                base0B = "#98c379",
                base0C = "#56b6c2",
                base0D = "#61afef",
                base0E = "#c678dd",
                base0F = "#be5046",
            },
            use_cterm = true,
        })
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

        require("mini.tabline").setup({
            tabpage_section = "right",
        })

        local mini_statusline = require("mini.statusline")

        mini_statusline.setup({
            content = {
                active = function()
                    local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 120 })
                    local git = mini_statusline.section_git({ trunc_width = 75 })
                    local diagnostics = mini_statusline.section_diagnostics({ trunc_width = 75 })
                    local filename = mini_statusline.section_filename({ trunc_width = 140 })
                    local fileinfo = mini_statusline.section_fileinfo({ trunc_width = 120 })
                    local location = mini_statusline.section_location({ trunc_width = 75 })

                    return mini_statusline.combine_groups({
                        { hl = mode_hl, strings = { mode } },
                        "%<",
                        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                        { hl = "MiniStatuslineFilename", strings = { filename } },
                        "%=",
                        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                        { hl = mode_hl, strings = { location } },
                    })
                end,
            },
            set_vim_settings = false,
        })

        local header_art = table.concat({
            [[                +                            ___]],
            [[                                 *        ,o88888]],
            [[        /                              ,o8888888']],
            [[       /         ,:o:o:oooo.        ,8O88Pd8888"]],
            [[      /      ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"]],
            [[     /     ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"]],
            [[    *     , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"]],
            [[         , ..:.::o:ooOoOO8O888O8O,COCOO"       o]],
            [[        , . ..:.::o:ooOoOOOO8OOOOCOCO"]],
            [[         . ..:.::o:ooOoOoOO8O8OCCCC"o]],
            [[            . ..:.::o:ooooOoCoCCC"o:o]],
            [[            . ..:.::o:o:,cooooCo"oo:o:    .]],
            [[   *     `   . . ..:.:cocoooo"'o:o:::'    :]],
            [[         .`   . ..::ccccoc"'o:o:o:::'    -+-]],
            [[        :.:.    ,c:cccc"':.:.:.:.:.'      :]],
            [[      ..:.:"'`::::c:"'..:.:.:.:.:.'       ']],
            [[    ...:.'.:.::::"'    . . . . .'    ~+]],
            [[   .. . ....:."' `   .  . . ''                +]],
            [[ . . . ...."'                   ╭╮╭╭─╮╭─╮┬  ┬┬╭┬╮]],
            [[ .. . ."'                       │││├┤ │ │╰┐┌╯││││]],
            [[                         *      ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴]],
        }, "\n")

        local footer_hook = function()
            local version = vim.version()
            local neovim_version = "  " .. version.major .. "." .. version.minor .. "." .. version.patch
            return "                     " .. neovim_version
        end

        local section_builtin = function()
            return {
                { name = "Edit new buffer", action = "enew", section = "Builtin" },
                { name = "Quit NeoVim", action = "qall", section = "Builtin" },
            }
        end

        local section_update = function()
            return {
                { name = "Plugin", action = "DepsUpdate", section = "Update" },
                { name = "Language Server", action = "Mason", section = "Update" },
                { name = "TreeSitter", action = "TSUpdate", section = "Update" },
            }
        end

        local section_recent_files = function()
            local oldfiles = vim.v.oldfiles or {}
            local input = table.concat(oldfiles, "\n")
            local files = vim.fn.systemlist("nvim-recent-files", input)

            if vim.tbl_isempty(files) then
                return {
                    {
                        name = "There are no recent files",
                        action = "",
                        section = "Recent files",
                    },
                }
            end

            return vim.tbl_map(function(file)
                return {
                    name = file,
                    action = "edit " .. file,
                    section = "Recent files",
                }
            end, files)
        end

        local mini_starter = require("mini.starter")

        mini_starter.setup({
            autoopen = true,
            header = header_art,
            footer = footer_hook,
            items = {
                section_builtin,
                section_update,
                section_recent_files,
            },
            content_hooks = {
                mini_starter.gen_hook.adding_bullet("» "),
                mini_starter.gen_hook.indexing("all", { "Builtin", "Update" }),
                mini_starter.gen_hook.aligning("center", "center"),
            },
        })

        require("mini.files").setup({
            mappings = {
                close = "q",
                go_in = "<right>",
                go_out = "<left>",
                show_help = "h",
                synchronize = "s",
            },
            windows = {
                preview = true,
            },
        })

        require("mini.notify").setup()
        vim.notify = require("mini.notify").make_notify()
    end,
    later = function(add)
        local miniclue = require("mini.clue")
        miniclue.setup({
            triggers = {
                { mode = "n", keys = "<Leader>" },
                { mode = "n", keys = "<C-w>" },
            },

            clues = {
                miniclue.gen_clues.windows(),
            },
            window = { delay = 0 },
        })

        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        require("mini.cursorword").setup()
        require("mini.indentscope").setup()
        require("mini.pairs").setup()
        require("mini.pick").setup()
    end,
}
