local wezterm = require('wezterm')
local c = wezterm.config_builder()

c.font = wezterm.font_with_fallback({
  {family="Roboto Mono", weight="Regular"},
  {family="Noto Sans JP", weight="Regular"},
})
c.font_size = 10.5
c.color_scheme = "OneHalfDark"
c.adjust_window_size_when_changing_font_size = false
c.default_cursor_style = "SteadyBar"
c.window_background_opacity = 0.8
c.window_close_confirmation = 'NeverPrompt'
c.use_fancy_tab_bar = false
c.show_tab_index_in_tab_bar = false
c.enable_tab_bar = false
c.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
c.initial_cols = 170
c.initial_rows = 30
c.disable_default_key_bindings = true
c.default_prog = {"fish", "-l", "-c", "zellij attach --index 0 --create"}
c.keys = {
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SendKey{ key='c', mods='ALT' }, pane)
      window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
    end),
  }
}

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return "WezTerm"
end)

return c
