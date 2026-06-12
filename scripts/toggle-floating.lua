#!/usr/bin/env lua

local script_dir = arg[0]:match("(.*/)") or "./"
package.path = script_dir .. "?.lua;" .. script_dir .. "?/init.lua;" .. package.path

local hyprctl = require("lib.hyprctl")

local FLOAT_WIDTH = 1600
local FLOAT_HEIGHT = 900

if hyprctl.is_floating() then
    hyprctl.eval("hl.dsp.window.float()")
    os.exit(0)
end

hyprctl.eval("hl.dsp.window.float()")
hyprctl.eval(string.format(
    "hl.dsp.window.resize({ x = %d, y = %d })",
    FLOAT_WIDTH, FLOAT_HEIGHT
))
hyprctl.eval("hl.dsp.window.center()")
