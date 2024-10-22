local wezterm = require('wezterm')
local act = wezterm.action
local c = wezterm.config_builder()
local ARROW = wezterm.nerdfonts.pl_left_hard_divider
local FILLED_BLOCK = '█'
local GREEN = "#98c379"
local GRAY = "#abb2bf"
local BLACK = "#1e222a"
local BG = "#282c34"
local DO_NOTHING_ACT = wezterm.action_callback(function(_, __)
end)

-- general
c.font = wezterm.font_with_fallback({{
    family = "Roboto Mono",
    weight = "Regular"
}, {
    family = "Noto Sans JP",
    weight = "Regular"
}})
c.font_size = 10.5
c.color_scheme = "OneDark (base16)"
c.default_cursor_style = "SteadyBar"
c.use_ime = true

-- tab
c.use_fancy_tab_bar = false
c.show_tab_index_in_tab_bar = false
c.show_new_tab_button_in_tab_bar = false
c.colors = {
    tab_bar = {
        background = BG,
        active_tab = {
            bg_color = GREEN,
            fg_color = BLACK,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false
        },
        inactive_tab = {
            bg_color = GRAY,
            fg_color = BLACK,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false
        },
        inactive_tab_hover = {
            bg_color = GRAY,
            fg_color = BLACK,
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false
        }
    }
}
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local edge_background = BG
    local edge_foreground = GRAY
    local background = GRAY
    local foreground = BLACK
    if tab.is_active then
        background = GREEN
        edge_foreground = GREEN
    end
    title = 'Tab #' .. tab.tab_index
    return {{
        Background = {
            Color = edge_foreground
        }
    }, {
        Foreground = {
            Color = edge_background
        }
    }, {
        Text = ARROW
    }, {
        Background = {
            Color = edge_background
        }
    }, {
        Foreground = {
            Color = edge_foreground
        }
    }, {
        Text = FILLED_BLOCK
    }, {
        Background = {
            Color = background
        }
    }, {
        Foreground = {
            Color = foreground
        }
    }, {
        Text = title
    }, {
        Background = {
            Color = edge_background
        }
    }, {
        Foreground = {
            Color = edge_foreground
        }
    }, {
        Text = FILLED_BLOCK
    }, {
        Background = {
            Color = edge_background
        }
    }, {
        Foreground = {
            Color = edge_foreground
        }
    }, {
        Text = ARROW
    }}
end)

-- window
c.initial_cols = 170
c.initial_rows = 30
c.window_background_opacity = 0.8
c.window_close_confirmation = 'NeverPrompt'
c.window_padding = {
    left = 0,
    right = 0,
    top = 5,
    bottom = 5
}
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "WezTerm"
end)

-- keybind
c.disable_default_key_bindings = true
c.keys = {{
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
        selection_text = window:get_selection_text_for_pane(pane)
        is_selection_active = string.len(selection_text) ~= 0
        if is_selection_active then
            window:perform_action(act.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
            window:perform_action(act.SendKey {
                key = 'c',
                mods = 'CTRL'
            }, pane)
        end
    end)
}, {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo("ClipboardAndPrimarySelection")
}, {
    key = 'v',
    mods = 'CTRL',
    action = act.PasteFrom("Clipboard")
}, {
    key = 't',
    mods = 'CTRL',
    action = act.SpawnTab("DefaultDomain")
}, {
    key = 'p',
    mods = 'CTRL',
    action = act.SplitHorizontal {
        domain = "CurrentPaneDomain"
    }
}, {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection("Right")
}, {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection("Left")
}, {
    key = 'UpArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection("Up")
}, {
    key = 'DownArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection("Down")
}, {
    key = 'RightArrow',
    mods = 'CTRL',
    action = act.ActivateTabRelative(1)
}, {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = act.ActivateTabRelative(-1)
}}
c.mouse_bindings = {{
    event = {
        Up = {
            streak = 1,
            button = 'Left'
        }
    },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor
}, {
    event = {
        Up = {
            streak = 1,
            button = 'Left'
        }
    },
    mods = 'NONE',
    action = DO_NOTHING_ACT
}, {
    event = {
        Up = {
            streak = 1,
            button = 'Left'
        }
    },
    mods = 'ALT',
    action = DO_NOTHING_ACT
}, {
    event = {
        Up = {
            streak = 2,
            button = 'Left'
        }
    },
    mods = 'NONE',
    action = DO_NOTHING_ACT
}, {
    event = {
        Up = {
            streak = 3,
            button = 'Left'
        }
    },
    mods = 'NONE',
    action = DO_NOTHING_ACT
}}

return c
