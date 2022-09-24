local navic = require("nvim-navic")
local lualine = require("lualine")

lualine.setup({
  options = {
    theme = "onedark",
    icons_enabled = true,
    section_separators = "",
    component_separators = ""
  },
  sections = {
    lualine_a = {
      "mode"
    },
    lualine_b = {
      "branch",
      "diff"
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available }
    },
    lualine_x = {
      "filetype",
      "filename"
    },
    lualine_y = {
       "diagnostics"
    },
    lualine_z = {
      "location"
    }
  }
})

