#!/usr/bin/env lua

local script_dir = arg[0]:match("(.*/)") or "./"
package.path = script_dir .. "?.lua;" .. script_dir .. "?/init.lua;" .. package.path

local path = require("lib.path")
local fs = require("lib.fs")

local script_extensions = { ".lua" }

local exclude = {
    ["select-script.lua"] = true,
    ["toggle-floating.lua"] = true,
    ["lib"] = true,
}

local all_files = fs.list_files(path.SCRIPTS, script_extensions)

local files = {}
for _, file in ipairs(all_files) do
    if not exclude[file] then
        files[#files + 1] = file
    end
end

if #files == 0 then
    io.stderr:write("No scripts found in " .. path.SCRIPTS .. "\n")
    os.exit(1)
end

local tmpfile = os.tmpname()
local f = io.open(tmpfile, "w")
f:write(table.concat(files, "\n"))
f:close()

local handle = io.popen('rofi -dmenu -p "scripts" < "' .. tmpfile .. '"')
if not handle then
    os.remove(tmpfile)
    io.stderr:write("Failed to open rofi\n")
    os.exit(1)
end

local selected = handle:read("*a")
handle:close()
os.remove(tmpfile)

selected = selected:gsub("^%s+", ""):gsub("%s+$", "")

if not selected or selected == "" then
    os.exit(0)
end

local script_path = path.SCRIPTS .. "/" .. selected
os.execute('"' .. script_path .. '"')
