-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

hl.on('hyprland.start', function()
    hl.exec_cmd('wl-paste --type text --watch cliphist store')
    hl.exec_cmd('wl-paste --type image --watch cliphist store')
    hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP')
    hl.exec_cmd('systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME')
    hl.exec_cmd('waybar & hyprpaper & hypridle & swaync & google-chrome-stable & spotify-launcher')
    hl.exec_cmd('openrgb -p ~/.config/OpenRGB/nsei.orp')
end)
