local M = {}

-- Execute hyprctl eval (wraps with hl.dispatch automatically)
function M.eval(cmd)
    if cmd:match("^hl%.dispatch") then
        os.execute("hyprctl eval '" .. cmd .. "' >/dev/null 2>&1")
    else
        os.execute("hyprctl eval 'hl.dispatch(" .. cmd .. ")' >/dev/null 2>&1")
    end
end

function M.get_active_window()
    local handle = io.popen("hyprctl activewindow -j 2>/dev/null")
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    return result
end

--- Get a field from active window (simple JSON parse)
function M.get_active_window_field(field)
    local json = M.get_active_window()
    if not json then
        return nil
    end
    local value = json:match('"' .. field .. '"%s*:%s*([^,}]+)')
    if value then
        value = value:gsub('^"', ''):gsub('"$', '')
        value = value:gsub('^%s+', ''):gsub('%s+$', '')
    end
    return value
end

function M.is_floating()
    local floating = M.get_active_window_field("floating")
    return floating == "true"
end

return M
