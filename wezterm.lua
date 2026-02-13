local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 14.0
config.use_dead_keys = false
config.keys = {
    { key = "7",          mods = "CMD",        action = wezterm.action.SendString("\\") },                     -- Needed for some reason
    { key = "4",          mods = "OPT",        action = wezterm.action.SendString("$") },                      -- Needed for some reason
    { key = "7",          mods = "OPT",        action = wezterm.action.SendString("|") },                      -- Needed for some reason
    { key = "¨",          mods = "OPT",        action = wezterm.action.SendString('~') },                      -- Needed for swedish_no_deadkeys
    { key = "2",          mods = "OPT",        action = wezterm.action.SendString('@') },                      -- Needed for some reason
    { key = "LeftArrow",  mods = "OPT",        action = wezterm.action.SendKey({ key = 'b', mods = 'ALT' }) }, -- For jumping one word in the terminal input
    { key = "RightArrow", mods = "OPT",        action = wezterm.action.SendKey({ key = 'f', mods = 'ALT' }) },
    { key = "w",          mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
    { key = "h",          mods = "CMD",        action = wezterm.action.ActivateTabRelative(-1) },
    { key = "l",          mods = "CMD",        action = wezterm.action.ActivateTabRelative(1) },
    { key = "'",          mods = "CTRL",       action = wezterm.action.SendString("\x1b[27;5;39~") },
    { key = "+",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
    { key = "r",          mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
    { key = "Tab",        mods = "CTRL",       action = wezterm.action.DisableDefaultAssignment },
    { key = "Tab",        mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "s",          mods = "CTRL|CMD",   action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "v",          mods = "CTRL|CMD",   action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h",          mods = "CTRL|CMD",   action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l",          mods = "CTRL|CMD",   action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k",          mods = "CTRL|CMD",   action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j",          mods = "CTRL|CMD",   action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "q",          mods = "CTRL|CMD",   action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = "h",          mods = "CMD|SHIFT",  action = wezterm.action.MoveTabRelative(-1), },
    { key = "l",          mods = "CMD|SHIFT",  action = wezterm.action.MoveTabRelative(1), },
    -- { key = "Enter",      mods = "SHIFT",      action = wezterm.action { SendString = "\x1b\r" } }, -- For newlines in Claude Code
    { key = "+",          mods = "CMD",        action = wezterm.action.IncreaseFontSize, },
}

-- Set tab title to git branch name if in a git repo (cached to avoid slowness)
local branch_cache = {}
local cache_ttl = 5 -- seconds

local function get_git_branch(cwd)
    local now = os.time()
    local cached = branch_cache[cwd]
    if cached and (now - cached.time) < cache_ttl then
        return cached.branch
    end

    local branch = nil
    local handle = io.popen("/usr/bin/git -C '" .. cwd .. "' rev-parse --abbrev-ref HEAD 2>/dev/null")
    if handle then
        local output = handle:read("*a"):gsub("%s+$", "")
        handle:close()
        if output ~= "" then
            branch = output
        end
    end

    branch_cache[cwd] = { branch = branch, time = now }
    return branch
end

wezterm.on("format-tab-title", function(tab)
    local cwd = nil

    local cwd_uri = tab.active_pane.current_working_dir
    if cwd_uri then
        cwd = tostring(cwd_uri):match("file://[^/]*(/.+)")
    end

    if not cwd then
        local pane = wezterm.mux.get_pane(tab.active_pane.pane_id)
        if pane then
            local ok, info = pcall(pane.get_foreground_process_info, pane)
            if ok and info and info.cwd then
                cwd = info.cwd
            end
        end
    end

    if cwd then
        local branch = get_git_branch(cwd)
        if branch then
            return branch
        end
    end

    return tab.active_pane.title
end)

return config
