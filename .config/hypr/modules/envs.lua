-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env('XCURSOR_SIZE', '24')
hl.env('HYPRCURSOR_SIZE', '24')
hl.env('GDK_SCALE', '1.25')

hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')
hl.env('XDG_SESSION_DESKTOP', 'Hyprland')
hl.env('XDG_SESSION_TYPE', 'wayland')

hl.env('QT_QPA_PLATFORM', 'wayland;xcb')
hl.env('QT_QPA_PLATFORMTHEME', 'qt6ct')

hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'wayland')
