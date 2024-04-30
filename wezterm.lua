local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "Tokyo Night"
config.default_prog = { "gitbash" }
config.keys = {
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "h", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "'", mods = "CTRL", action = wezterm.action.SendString("\x1b[27;5;39~") },
	{ key = "+", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "r", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "s", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "q", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane { confirm = false }},
}

return config
