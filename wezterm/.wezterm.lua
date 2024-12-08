-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 18.0
config.color_scheme = "Tokyo Night Storm"
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
