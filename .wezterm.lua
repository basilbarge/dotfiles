local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Configure fonts
config.font = wezterm.font 'SpaceMono Nerd Font Mono'
config.color_scheme = "tokyonight"

return config

