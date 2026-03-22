--- wezterm.lua - personal configuration
local wezterm = require("wezterm")
-- local mux = wezterm.mux
local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- Set the default program (shell) to launch
config.default_prog = { "pwsh.exe" }
-- Set colorscheme
config.color_scheme = "Tokyo Night (Gogh)"
-- Font settings
config.font = wezterm.font("0xProto Nerd Font")
config.font_size = 14
-- Window setting/ appearance
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Transparency settings
config.window_background_opacity = 0.85  -- Adjust between 0.0 (fully transparent) and 1.0 (opaque)

-- Optional: Add blur effect on Windows 10/11
config.win32_system_backdrop = "Acrylic"  -- Options: "Auto", "Disable", "Acrylic", "Mica", "Tabbed"
-- config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 10
-- config.window_frame = {
--  font = wezterm.font({ family = "0xProto Nerd Font" }),
--  font_size = 20,
-- }
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.0cell",
	bottom = "0.5cell",
}
config.initial_rows = 42
config.initial_cols = 124
config.enable_scroll_bar = true
config.scrollback_lines = 5000
config.default_workspace = "main"

-- Launch menu: choose between shells when opening new tabs/panes
config.launch_menu = {
	{ label = " PowerShell", args = { "pwsh.exe" } },
	{ label = " Ubuntu (WSL)", args = { "wsl.exe", "--distribution", "Ubuntu" } },
}
-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}
-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.status_update_interval = 1000

-- Keybindings with Hyper key (CapsLock = Ctrl+Alt+Shift)
config.keys = {
	-- Create new tab (shows shell picker)
	{ key = "t", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" }) },

	-- Close current tab
	{ key = "w", mods = "CTRL|ALT|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

	-- Jump to specific tabs (using physical key positions)
	{ key = "phys:1", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(0) },
	{ key = "phys:2", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(1) },
	{ key = "phys:3", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(2) },
	{ key = "phys:4", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(3) },
	{ key = "phys:5", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(4) },
	{ key = "phys:6", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(5) },
	{ key = "phys:7", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(6) },
	{ key = "phys:8", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(7) },
	{ key = "phys:9", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTab(8) },

	-- Cycle through tabs
	{ key = "n", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

	-- Alternative: Use Tab key to cycle
	{ key = "Tab", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	-- Move tabs left/right (use shifted versions: { } )
	{ key = "{", mods = "CTRL|ALT|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|ALT|SHIFT", action = wezterm.action.MoveTabRelative(1) },

	-- Split panes
	{ key = "d", mods = "CTRL|ALT|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "CTRL|ALT|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Navigate between panes
	{ key = "h", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Resize panes
	{ key = "LeftArrow", mods = "CTRL|ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	-- Close current pane
	{ key = "x", mods = "CTRL|ALT|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Toggle pane zoom (fullscreen current pane)
	{ key = "z", mods = "CTRL|ALT|SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Command palette (great for discovering actions)
	{ key = "Space", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateCommandPalette },

	-- Search in scrollback
	{ key = "f", mods = "CTRL|ALT|SHIFT", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- Copy mode (vim-like selection)
	{ key = "v", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ActivateCopyMode },

	-- Quick select mode (clickable hints for URLs, paths, etc.)
	{ key = "q", mods = "CTRL|ALT|SHIFT", action = wezterm.action.QuickSelect },

	-- Rename current tab
	{ key = "r", mods = "CTRL|ALT|SHIFT", action = wezterm.action.PromptInputLine({
		description = "Enter new tab title",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	}) },

	-- Show debug overlay
	{ key = "F12", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ShowDebugOverlay },

	-- Clear scrollback and viewport
	{ key = "Backspace", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },

	-- ============================================================
	-- SIMPLE KEYBINDS (not Hyper - used too frequently)
	-- ============================================================
	-- Copy/Paste - keep simple, used constantly
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Font size - keep simple for quick adjustments
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

	-- Scroll - keep simple for frequent use
	{ key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
}

wezterm.on("update-status", function(window, pane)
	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			cwd = basename(cwd.file_path)
		else
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Right status
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

-- Return the configuration to wezterm
return config

