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
    window_background_opacity = 0.9,
}
