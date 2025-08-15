local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "Tokyo Night"
config.font_size = 14.0
config.use_dead_keys = false
config.keys = {
    { key = "7", mods = "OPT", action = wezterm.action.SendString("|") }, -- Needed for some reason
	{ key = "¨", mods = "OPT", action = wezterm.action.SendString('~') }, -- Needed for swedish_no_deadkeys
	{ key = "2", mods = "OPT", action = wezterm.action.SendString('@') }, -- Needed for some reason
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendKey({ key='b', mods='ALT'}) }, -- For jumping one word in the terminal input
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendKey({ key='f', mods='ALT'}) },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "h", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "'", mods = "CTRL", action = wezterm.action.SendString("\x1b[27;5;39~") },
	{ key = "+", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "r", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "s", mods = "CTRL|CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "CTRL|CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "q", mods = "CTRL|CMD", action = wezterm.action.CloseCurrentPane { confirm = false }},
	{ key = "h", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(-1),},
	{ key = "l", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(1),},

}
return config
