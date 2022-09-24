local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[               +                            ___]],
  [[                                *        ,o88888]],
  [[       /                              ,o8888888']],
  [[      /         ,:o:o:oooo.        ,8O88Pd8888"]],
  [[     /      ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"]],
  [[    /     ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"]],
  [[   *     , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"]],
  [[        , ..:.::o:ooOoOO8O888O8O,COCOO"       o]],
  [[       , . ..:.::o:ooOoOOOO8OOOOCOCO"]],
  [[        . ..:.::o:ooOoOoOO8O8OCCCC"o]],
  [[           . ..:.::o:ooooOoCoCCC"o:o]],
  [[           . ..:.::o:o:,cooooCo"oo:o:    .]],
  [[  *     `   . . ..:.:cocoooo"'o:o:::'    :]],
  [[        .`   . ..::ccccoc"'o:o:o:::'    -+-]],
  [[       :.:.    ,c:cccc"':.:.:.:.:.'      :]],
  [[     ..:.:"'`::::c:"'..:.:.:.:.:.'       ']],
  [[   ...:.'.:.::::"'    . . . . .'    ~+]],
  [[  .. . ....:."' `   .  . . ''                +]],
  [[. . . ...."'                   ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮]],
  [[.. . ."'                       │││├┤ │ │╰┐┌╯││││]],
  [[                        *      ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴]],
}

dashboard.section.buttons.val = {
  dashboard.button("r", "  > Recent File", "<cmd>Telescope frecency workspace=CWD<CR>"),
  dashboard.button("f", "  > Find File", "<cmd>Telescope find_files hidden=true<CR>"),
  dashboard.button("w", "  > Find Text", "<cmd>Telescope live_grep<CR>"),
  dashboard.button("e", "  > New File", "<cmd>ene <BAR> startinsert<CR>"),
  dashboard.button("u", "  > Update Plugin", "<cmd>JetpackSync<CR><cmd>TSUpdate<CR>"),
  dashboard.button("q", "  > Quit", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = function()
  local version = vim.version()
  local neovim_version = "  " .. version.major .. "." .. version.minor .. "." .. version.patch
  local total_plugins = "  " .. #vim.fn["jetpack#names"]()
  return neovim_version .. "     " .. total_plugins
end
dashboard.section.footer.opts.hl = 'Comment'

dashboard.config.layout = {
  { type = "padding", val = math.max(0, math.ceil((vim.fn.winheight("$") - 20) * 0.3)) },
  dashboard.section.header,
  { type = "padding", val = 4 },
  dashboard.section.buttons,
  { type = "padding", val = 3 },
  dashboard.section.footer
}

alpha.setup(dashboard.config)

