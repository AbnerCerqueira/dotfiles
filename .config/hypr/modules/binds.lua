local main_mod = 'SUPER' -- Sets "Windows" key as main modifier
local terminal = 'kitty'
local file_manager = 'nautilus'
local menu = 'rofi -show drun'

hl.bind(main_mod .. ' + return', hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. ' + Q', hl.dsp.window.close())
hl.bind(main_mod .. ' + SHIFT + DELETE', hl.dsp.exit())
hl.bind(main_mod .. ' + E', hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. ' + V', hl.dsp.exec_cmd('$HOME/dotfiles/scripts/toggle-floating.lua'))
hl.bind(main_mod .. ' + F', hl.dsp.window.fullscreen({ mode = 'maximized' }))
hl.bind(main_mod .. ' + SHIFT + F', hl.dsp.window.fullscreen({ mode = 'fullscreen' }))
hl.bind(main_mod .. ' + space', hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. ' + P', hl.dsp.window.pseudo())
hl.bind(main_mod .. ' + T', hl.dsp.layout('togglesplit'))
hl.bind(main_mod .. ' + n', hl.dsp.window.cycle_next())
hl.bind(main_mod .. ' + n', hl.dsp.window.bring_to_top())

hl.bind(main_mod .. ' + CTRL + SHIFT + S', hl.dsp.exec_cmd('hyprshot -m region --clipboard-only'))
hl.bind(main_mod .. ' + CTRL + SHIFT + C', hl.dsp.exec_cmd('hyprshot -m region'))
hl.bind(main_mod .. ' + CTRL + SHIFT + T', hl.dsp.exec_cmd('hyprshot -m output'))
hl.bind(main_mod .. ' + SHIFT + V', hl.dsp.exec_cmd('cliphist list | rofi -dmenu | cliphist decode | wl-copy'))
hl.bind(main_mod .. ' + SHIFT + L', hl.dsp.exec_cmd('hyprlock'))
hl.bind(main_mod .. ' + TAB', hl.dsp.exec_cmd('swaync-client -t sw'))
hl.bind(main_mod .. ' + SHIFT + W', hl.dsp.exec_cmd('$HOME/dotfiles/scripts/select-script.lua'))

-- groups
hl.bind(main_mod .. ' + G', hl.dsp.group.toggle())
hl.bind('ALT + H', hl.dsp.group.prev())
hl.bind('ALT + mouse_down', hl.dsp.group.prev())
hl.bind('ALT + L', hl.dsp.group.next())
hl.bind('ALT + mouse_up', hl.dsp.group.next())
hl.bind(main_mod .. ' + SHIFT + G', hl.dsp.group.lock())
hl.bind(main_mod .. ' + ALT + G', hl.dsp.window.move({ out_of_group = true }))

hl.bind(main_mod .. ' + ALT + CTRL + H', hl.dsp.window.move({ into_group = 'left' }))
hl.bind(main_mod .. ' + ALT + CTRL + L', hl.dsp.window.move({ into_group = 'right' }))
hl.bind(main_mod .. ' + ALT + CTRL + K', hl.dsp.window.move({ into_group = 'up' }))
hl.bind(main_mod .. ' + ALT + CTRL + J', hl.dsp.window.move({ into_group = 'down' }))

-- move focus with main_mod + vim keys
hl.bind(main_mod .. ' + h', hl.dsp.focus({ direction = 'left' }))
hl.bind(main_mod .. ' + l', hl.dsp.focus({ direction = 'right' }))
hl.bind(main_mod .. ' + k', hl.dsp.focus({ direction = 'up' }))
hl.bind(main_mod .. ' + j', hl.dsp.focus({ direction = 'down' }))

hl.bind(main_mod .. ' + CTRL + l', hl.dsp.window.move({ direction = 'right' }))
hl.bind(main_mod .. ' + CTRL + h', hl.dsp.window.move({ direction = 'left' }))
hl.bind(main_mod .. ' + CTRL + k', hl.dsp.window.move({ direction = 'up' }))
hl.bind(main_mod .. ' + CTRL + j', hl.dsp.window.move({ direction = 'down' }))

hl.bind(main_mod .. ' + ALT + h', hl.dsp.window.swap({ direction = 'left' }))
hl.bind(main_mod .. ' + ALT + l', hl.dsp.window.swap({ direction = 'right' }))
hl.bind(main_mod .. ' + ALT + k', hl.dsp.window.swap({ direction = 'up' }))
hl.bind(main_mod .. ' + ALT + j', hl.dsp.window.swap({ direction = 'down' }))

hl.bind(main_mod .. ' + m', hl.dsp.window.swap({ next = true }))

-- switch workspaces and move active window to a workspace.
for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. ' + ' .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

-- example special workspace (scratchpad)
hl.bind(main_mod .. ' + S', hl.dsp.workspace.toggle_special('magic'))
hl.bind(main_mod .. ' + SHIFT + S', hl.dsp.window.move({ workspace = 'special:magic' }))

-- scroll through existing workspaces with mainMod + scroll
hl.bind(main_mod .. ' + mouse_down', hl.dsp.focus({ workspace = 'e-1' }))
hl.bind(main_mod .. ' + mouse_up', hl.dsp.focus({ workspace = 'e+1' }))

-- move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- laptop multimedia keys for volume and LCD brightness
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'),
    { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
    { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
    { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
    { locked = true, repeating = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd('brightnessctl s 10%+'), { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl s 10%-s'), { locked = true, repeating = true })

-- requires playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd('playerctl next'), { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd('playerctl play-pause'), { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play-pause'), { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd('playerctl previous'), { locked = true })

-- will switch to a submap called resize
hl.bind('ALT + R', hl.dsp.submap('resize'))

hl.define_submap('resize', function()
    hl.bind('l', hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
    hl.bind('h', hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
    hl.bind('k', hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
    hl.bind('j', hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

    hl.bind(main_mod .. ' + h', hl.dsp.focus({ direction = 'left' }))
    hl.bind(main_mod .. ' + l', hl.dsp.focus({ direction = 'right' }))
    hl.bind(main_mod .. ' + k', hl.dsp.focus({ direction = 'up' }))
    hl.bind(main_mod .. ' + j', hl.dsp.focus({ direction = 'down' }))

    hl.bind(main_mod .. ' + T', hl.dsp.layout('togglesplit'))
    hl.bind('escape', hl.dsp.submap('reset'))
end)
