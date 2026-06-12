-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
local colors = require('themes.colors-matugen')

local general = {
    gaps_in = 4,
    gaps_out = 6,

    border_size = 2,

    col = {
        active_border = colors.primary,
        inactive_border = colors.on_primary,
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = true,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,

    layout = "dwindle",
}

local decoration = {
    rounding         = 5,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 0.99,

    shadow           = {
        enabled = true,
        range = 4,
        render_power = 3,
        color = 'rgba(1a1a1aee)'
    },

    blur             = {
        enabled = false,
        size = 3,
        passes = 1,
        vibrancy = 0.1696
    }
}

local dwindle = {
    preserve_split = true,
    force_split = 2,
}

local master = {
    new_status = 'master',
}

local group = {
    col = {
        border_active = colors.secondary,
        border_inactive = colors.on_secondary,
        border_locked_active = colors.tertiary,
        border_locked_inactive = colors.on_tertiary,
    },

    groupbar = {
        font_size = 0,
        height = 3,
        rounding = 10,
        rounding_power = 10,
        gradients = true,

        col = {
            active = colors.secondary,
            inactive = colors.on_secondary,
            locked_active = colors.tertiary,
            locked_inactive = colors.on_tertiary,
        },
    },
}

-- from ArchEclipse
local phi = 1.618
local phi_min = 0.618
local interval = phi * 4
local curve = 'ease'

hl.curve('default', { type = 'bezier', points = { { 0, 1 }, { 0, 1 } } })
hl.curve('wind', { type = 'bezier', points = { { 0.05, phi_min }, { 0.1, 1 } } })
hl.curve('winIn', { type = 'bezier', points = { { 0.1, 1.1 }, { 0.1, 1 } } })
hl.curve('winOut', { type = 'bezier', points = { { 0.3, 1 }, { 0, 1 } } })
hl.curve('linear', { type = 'bezier', points = { { 1, 1 }, { 1, 1 } } })
hl.curve('ease', { type = 'bezier', points = { { 0, 1 }, { phi_min, 1 } } })

hl.animation({ leaf = 'windowsIn', enabled = true, speed = interval, bezier = curve, style = 'slide' })
hl.animation({ leaf = 'windowsOut', enabled = true, speed = interval, bezier = curve, style = 'slide' })
hl.animation({ leaf = 'windowsMove', enabled = true, speed = interval, bezier = curve, style = 'slide' })
hl.animation({ leaf = 'workspaces', enabled = true, speed = interval, bezier = curve, style = 'slide' })
hl.animation({ leaf = 'layers', enabled = true, speed = interval, bezier = curve, style = 'slide' })
hl.animation({ leaf = 'specialWorkspace', enabled = true, speed = interval, bezier = curve, style = 'slidevert' })
hl.animation({ leaf = 'fadePopups', enabled = true, speed = interval, bezier = curve })


hl.config({
    general = general,
    decoration = decoration,
    animations = {
        enabled = true
    }
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = dwindle,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = master,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    group = group,
})
