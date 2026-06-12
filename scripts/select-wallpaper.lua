#!/usr/bin/env lua

local script_dir = arg[0]:match("(.*/)") or "./"
package.path = script_dir .. "?.lua;" .. script_dir .. "?/init.lua;" .. package.path

local path = require("lib.path")
local fs = require("lib.fs")

local image_extensions = {".jpg", ".jpeg", ".png"}

local files = fs.list_files(path.WALLPAPERS, image_extensions)

if #files == 0 then
    io.stderr:write("No wallpapers found in " .. path.WALLPAPERS .. "\n")
    os.exit(1)
end

local menu_items = table.concat(files, "\n")

local handle = io.popen('printf "%s" "' .. menu_items .. '" | rofi -dmenu -p "wallpapers"')
if not handle then
    io.stderr:write("Failed to open rofi\n")
    os.exit(1)
end

local selected = handle:read("*a")
handle:close()

selected = selected:gsub("^%s+", ""):gsub("%s+$", "")

if not selected or selected == "" then
    os.exit(0)
end

local selected_path = path.WALLPAPERS .. "/" .. selected

os.execute('hyprctl hyprpaper wallpaper ",' .. selected_path .. '" >/dev/null 2>&1')

local ok, err = fs.update_section_path(path.HYPR_PAPER, "wallpaper", selected_path)
if not ok then
    io.stderr:write("Failed to update hyprpaper.conf: " .. (err or "unknown") .. "\n")
end

ok, err = fs.update_section_path(path.HYPR_LOCK, "background", selected_path)
if not ok then
    io.stderr:write("Failed to update hyprlock.conf: " .. (err or "unknown") .. "\n")
end

os.execute('matugen --config "' ..
    path.MATUGEN .. '" --source-color-index 0 image "' .. selected_path .. '" >/dev/null 2>&1')
