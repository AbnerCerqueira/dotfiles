#!/usr/bin/env lua

-- Usage:
--   lua spotify.lua                    # Get current status
--   lua spotify.lua --action toggle    # Play/Pause
--   lua spotify.lua --action next      # Next track
--   lua spotify.lua --action previous  # Previous track

local PLAYER = "spotify"
local MAX_TEXT_LENGTH = 45

local function run_command(cmd)
    local handle = io.popen(cmd .. " 2>/dev/null")
    if not handle then
        return ""
    end
    local result = handle:read("*a")
    handle:close()
    return result:gsub("^%s+", ""):gsub("%s+$", "")
end

local function is_running()
    local players = run_command("playerctl -l")
    return players:find(PLAYER) ~= nil
end

local function get_metadata()
    local title = run_command("playerctl -p " .. PLAYER .. " metadata title")
    local artist = run_command("playerctl -p " .. PLAYER .. " metadata artist")
    local album = run_command("playerctl -p " .. PLAYER .. " metadata album")
    local status = run_command("playerctl -p " .. PLAYER .. " status")

    if status ~= "Playing" and status ~= "Paused" then
        status = "Stopped"
    end

    return { title = title, artist = artist, album = album, status = status }
end

local function execute_action(action)
    if not is_running() then return end

    if action == "toggle" then
        run_command("playerctl -p " .. PLAYER .. " play-pause")
    elseif action == "next" then
        run_command("playerctl -p " .. PLAYER .. " next")
    elseif action == "previous" then
        run_command("playerctl -p " .. PLAYER .. " previous")
    end
end

-- Escape special chars for JSON/Pango
local function escape_text(text)
    text = text:gsub('"', '\\"')
    text = text:gsub("<", "&lt;")
    text = text:gsub(">", "&gt;")
    return text
end

local function truncate(text, max_length)
    if #text <= max_length then
        return text
    end
    return text:sub(1, max_length - 3) .. "..."
end

local function get_output()
    if not is_running() then
        print('{"text": ""}')
        return
    end

    local meta = get_metadata()

    if meta.title == "" then
        print('{"text": ""}')
        return
    end

    local is_playing = meta.status == "Playing"
    local indicator = is_playing and "⏸" or "▶"
    local display = truncate(indicator .. " " .. meta.title .. " - " .. meta.artist, MAX_TEXT_LENGTH)

    display = escape_text(display)
    meta.title = escape_text(meta.title)
    meta.artist = escape_text(meta.artist)
    meta.album = escape_text(meta.album)

    local class = is_playing and "playing" or "paused"
    local alt = meta.status:lower()

    local tooltip = "Music: " .. meta.title ..
        "\\nArtist: " .. meta.artist ..
        (meta.album ~= "" and ("\\nAlbum: " .. meta.album) or "") ..
        "\\nStatus: " .. meta.status

    tooltip = escape_text(tooltip)

    local json = string.format(
        '{"text": "%s", "tooltip": "%s", "class": "%s", "alt": "%s"}',
        display, tooltip, class, alt
    )

    print(json)
end

local args = arg or {}
local action_index = nil

for i = 1, #args do
    if args[i] == "--action" then
        action_index = i
        break
    end
end

if action_index and args[action_index + 1] then
    execute_action(args[action_index + 1])
else
    get_output()
end
