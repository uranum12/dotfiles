local wezterm = require("wezterm")

return {
    font = wezterm.font_with_fallback({
        "Moralerspace Argon HW",
        "HackGen Console NF",
    }),
    font_size = 12,
    color_scheme = "OneDark (base16)",
    use_ime = true,
    send_composed_key_when_left_alt_is_pressed = true,
    keys = {
        { key = "t", mods = "SUPER", action = wezterm.action.SpawnCommandInNewTab({ cwd = "~" }) },
    },
    show_new_tab_button_in_tab_bar = false,
    show_close_tab_button_in_tabs = false,
    background = {
        {
            source = {
                Color = "#282c34",
            },
            opacity = 1.0,
            width = "100%",
            height = "100%",
        },
        {
            source = {
                File = wezterm.config_dir .. "/wallpaper.jpg",
            },
            opacity = 0.15,
        },
    },
}
