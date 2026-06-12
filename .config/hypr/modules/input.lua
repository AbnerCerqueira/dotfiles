local input = {
    kb_layout = 'us, br',
    kb_variant = '',
    kb_model = '',
    kb_options = 'grp:shifts_toggle',

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    accel_profile = 'flat',

    touchpad = {
        natural_scroll = false
    }
}

local cursor = {
    no_break_fs_vrr = 1,
}

hl.config({
    input = input,
    cursor = cursor
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
