require("mini.tabline").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.bufremove").setup()
require("mini.surround").setup()
require("mini.jump").setup()
require("mini.jump2d").setup()
require("mini.trailspace").setup()

local context_commentstring = require("ts_context_commentstring.internal")

require("mini.comment").setup({
    hooks = {
        pre = function()
            context_commentstring.update_commentstring()
        end,
    },
})

local map = require("mini.map")

map.setup({
    symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
    },
    integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
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

local navic = require("nvim-navic")

require("mini.statusline").setup({
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })

            local navigation = ""
            if navic.is_available() then
                navigation = navic.get_location()
            end

            return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                "%<",
                { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                { hl = "MiniStatuslineFilename", strings = { navigation } },
                "%=",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { location } },
            })
        end,
    },
    set_vim_settings = false,
})

local starter = require("mini.starter")

local header_art = [[
                +                            ___
                                 *        ,o88888
        /                              ,o8888888'
       /         ,:o:o:oooo.        ,8O88Pd8888"
      /      ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"
     /     ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"
    *     , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"
         , ..:.::o:ooOoOO8O888O8O,COCOO"       o
        , . ..:.::o:ooOoOOOO8OOOOCOCO"
         . ..:.::o:ooOoOoOO8O8OCCCC"o
            . ..:.::o:ooooOoCoCCC"o:o
            . ..:.::o:o:,cooooCo"oo:o:    .
   *     `   . . ..:.:cocoooo"'o:o:::'    :
         .`   . ..::ccccoc"'o:o:o:::'    -+-
        :.:.    ,c:cccc"':.:.:.:.:.'      :
      ..:.:"'`::::c:"'..:.:.:.:.:.'       '
    ...:.'.:.::::"'    . . . . .'    ~+
   .. . ....:."' `   .  . . ''                +
 . . . ...."'                   ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
 .. . ."'                       │││├┤ │ │╰┐┌╯││││
                         *      ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]]

local footer_hook = function()
    local version = vim.version()
    local neovim_version = "  " .. version.major .. "." .. version.minor .. "." .. version.patch
    local total_plugins = "  " .. #require("jetpack").names()
    return "               " .. neovim_version .. "     " .. total_plugins
end

local section_builtin = function()
    return {
        { name = "Edit new buffer", action = "enew", section = "Builtin" },
        { name = "Quit NeoVim", action = "qall", section = "Builtin" },
    }
end

local section_update = function()
    return {
        { name = "Plugin", action = "JetpackSync", section = "Update" },
        { name = "TreeSitter", action = "TSUpdateSync", section = "Update" },
    }
end

local section_telescope = function()
    return {
        { name = "Files", action = "Telescope find_files", section = "Telescope" },
        { name = "Recent", action = "Telescope frecency", section = "Telescope" },
        { name = "Browser", action = "Telescope file_browser", section = "Telescope" },
        { name = "Grep", action = "Telescope live_grep", section = "Telescope" },
    }
end

local section_recent_files = function()
    local cwd = vim.loop.cwd()
    local files = vim.tbl_filter(function(f)
        return vim.fn.filereadable(f) == 1
    end, vim.v.oldfiles or {})
    files = vim.tbl_filter(function(f)
        return f:sub(1, cwd:len()) == cwd
    end, files)
    if #files == 0 then
        return { { name = "There are no recent files", action = "", section = "Recent files" } }
    end
    -- local items = { {name = cwd, action = "", section = "Recent files"} }
    local items = {}
    for _, f in next, vim.list_slice(files, 1, 7) do
        local path = vim.fn.fnamemodify(f, ":~:.")
        table.insert(items, { name = path, action = "edit " .. path, section = "Recent files" })
    end
    return items
end

starter.setup({
    autoopen = true,
    header = header_art,
    footer = footer_hook,
    items = {
        section_builtin,
        section_update,
        section_telescope,
        section_recent_files,
    },
    content_hooks = {
        starter.gen_hook.adding_bullet("» "),
        starter.gen_hook.indexing("all", { "Builtin", "Update", "Telescope" }),
        starter.gen_hook.aligning("center", "center"),
    },
})
