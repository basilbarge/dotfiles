local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Configure fonts
config.font = wezterm.font 'MonaspiceKr Nerd Font Mono'
config.color_scheme = "Catppuccin Mocha"

return config

