local wezterm = require("wezterm")
local act = wezterm.action
config = wezterm.config_builder()

-- Initialize global state for cycling features
wezterm.GLOBAL.bg_index = wezterm.GLOBAL.bg_index or 2           -- Start with bg-2 (current)
wezterm.GLOBAL.opacity_index = wezterm.GLOBAL.opacity_index or 4 -- Start with 0.97 (closest to current)
wezterm.GLOBAL.opacity_enabled = wezterm.GLOBAL.opacity_enabled or true
wezterm.GLOBAL.saved_opacity = wezterm.GLOBAL.saved_opacity or 0.97
wezterm.GLOBAL.theme_index = wezterm.GLOBAL.theme_index or 3 -- Start with Ryuuko (current)

-- Background cycling function
local function cycle_background(window)
	wezterm.GLOBAL.bg_index = (wezterm.GLOBAL.bg_index % 4) + 1
	local overrides = window:get_config_overrides() or {}
	overrides.window_background_image = "C:/Users/alexr/.config/wezterm/assets/bg-" .. wezterm.GLOBAL.bg_index .. ".jpg"
	window:set_config_overrides(overrides)
end

-- Opacity cycling function
local function cycle_opacity(window)
	local opacities = { 0.85, 0.9, 0.93, 0.96, 0.98, 0.99 }
	wezterm.GLOBAL.opacity_index = (wezterm.GLOBAL.opacity_index % #opacities) + 1
	local new_opacity = opacities[wezterm.GLOBAL.opacity_index]
	if wezterm.GLOBAL.opacity_enabled then
		wezterm.GLOBAL.saved_opacity = new_opacity
	end

	local overrides = window:get_config_overrides() or {}
	if wezterm.GLOBAL.opacity_enabled then
		overrides.window_background_opacity = wezterm.GLOBAL.saved_opacity
	else
		overrides.window_background_opacity = 1.0
	end
	window:set_config_overrides(overrides)
end

-- Opacity toggle function
local function toggle_opacity(window)
	wezterm.GLOBAL.opacity_enabled = not wezterm.GLOBAL.opacity_enabled

	local overrides = window:get_config_overrides() or {}
	if wezterm.GLOBAL.opacity_enabled then
		overrides.window_background_opacity = wezterm.GLOBAL.saved_opacity
	else
		overrides.window_background_opacity = 1.0
	end
	window:set_config_overrides(overrides)
end

-- Theme cycling function
local function cycle_theme(window)
	local themes = { "Ryuuko", "Catppuccin Mocha", "Sea Shells (Gogh)", "Tokyo Night" }
	wezterm.GLOBAL.theme_index = (wezterm.GLOBAL.theme_index % #themes) + 1
	local new_theme = themes[wezterm.GLOBAL.theme_index]

	local overrides = window:get_config_overrides() or {}
	overrides.color_scheme = new_theme
	window:set_config_overrides(overrides)
end

config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe", "-nologo" }
config.initial_cols = 120
config.initial_rows = 28

config.launch_menu = {
	{
		label = "PowerShell 7",
		args = { "C:/Program Files/PowerShell/7/pwsh.exe", "-nologo" },
	},
	{
		label = "Nvim",
		args = { "C:/tools/neovim/nvim-win64/bin/nvim" },
	},
}

config.font_size = 12
config.line_height = 1.2
config.color_scheme = "Sea Shells (Gogh)"
config.colors = { compose_cursor = "#5D8AA8" }

-- (AKA: CaskaydiaCove NFM)
-- C:\WINDOWS\FONTS\CASKAYDIACOVENERDFONTMONO-REGULAR.TTF, DirectWrite

config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", {
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})

-- tmux
config.leader = { key = "b", mods = "CTRL", timeout = "5000" }
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = act.CloseCurrentPane({ confirm = true }),
	},

	{
		mods = "LEADER",
		key = "b",
		action = act.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = act.ActivateTabRelative(1),
	},
	{
		mods = "LEADER|SHIFT",
		key = "|",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "y",
		action = wezterm.action_callback(cycle_background),
	},
	{
		mods = "LEADER",
		key = "u",
		action = wezterm.action_callback(cycle_opacity),
	},
	{
		mods = "LEADER",
		key = "i",
		action = wezterm.action_callback(toggle_opacity),
	},
	{
		mods = "LEADER",
		key = "o",
		action = wezterm.action_callback(cycle_theme),
	},
}

for i = 1, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		mods = "LEADER",
		key = tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) .. " " -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#eeaf61" } },
		{ Text = prefix },
	}))
end)

-- tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Appearance
config.window_decorations = "RESIZE"
-- config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = "C:/Users/alexr/.config/wezterm/assets/bg-2.jpg"
config.window_background_opacity = 0.97

-- Micsellaneous settings
config.max_fps = 240
config.animation_fps = 240
config.prefer_egl = true

return config
