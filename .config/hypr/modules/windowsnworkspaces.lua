-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local colors = require('themes.colors-matugen')

hl.window_rule({
    name = 'border-color-float-window',
    match = {
        float = true,
    },
})

hl.window_rule({
    name = 'border-color-fullscreen-window',
    match = {
        fullscreen = true,
    },

    border_color = colors.tertiary,
})

hl.window_rule({
    name = 'center-rofi',
    match = {
        title = '^(rofi - drun)$',
    },

    center = true,
})

hl.layer_rule({
    name = 'no-anim-selection',
    match = {
        namespace = 'selection',
    },

    no_anim = true,
})

-- IntelliJ
hl.window_rule({
    name = 'intellij-focus',
    match = {
        class = '(jetbrains-idea)',
        title = '^win.*',
    },

    no_initial_focus = true,
})

hl.window_rule({
    name = 'intellij-round-window',
    match = {
        class = '(jetbrains-idea)',
        title = '^win.*',
    },

    rounding = 0,
})

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name = 'suppress-maximize-events',
    match = {
        class = '.*',
    },

    suppress_event = 'maximize',
})

hl.window_rule({
    -- Fix some dragging issues with XWayland.
    name = 'fix-xwayland-drags',
    match = {
        class = '^$',
        title = '^$',
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = 'move-hyprland-run',
    match = {
        class = 'hyprland-run',
    },

    move = '20 monitor_h-120',
    float = true,
})
