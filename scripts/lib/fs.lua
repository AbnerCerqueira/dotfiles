local M = {}

-- Read all lines from file
--- @return table|nil, string|nil
function M.read_lines(filepath)
    local f, err = io.open(filepath, "r")
    if not f then
        return nil, err
    end
    local lines = {}
    for line in f:lines() do
        lines[#lines + 1] = line
    end
    f:close()
    return lines
end

function M.write_lines(filepath, lines)
    local f = io.open(filepath, "w")
    if not f then
        return false, "Could not open file for writing: " .. filepath
    end
    for _, line in ipairs(lines) do
        f:write(line .. "\n")
    end
    f:close()
    return true
end

--- List files in directory with extension filter
--- @param dir string
--- @param extensions table e.g. {".jpg", ".png"}
function M.list_files(dir, extensions)
    local files = {}
    local handle = io.popen('ls "' .. dir .. '" 2>/dev/null')
    if not handle then
        return files
    end

    for filename in handle:lines() do
        for _, ext in ipairs(extensions) do
            if filename:lower():match(ext:lower() .. "$") then
                files[#files + 1] = filename
                break
            end
        end
    end
    handle:close()
    return files
end

--- Find 'path' line within a specific section
--- @param lines table
--- @param section_name string e.g. "background", "wallpaper"
--- @return number|nil index or nil
function M.find_path_in_section(lines, section_name)
    local section_start = nil

    for i, line in ipairs(lines) do
        if line:match("^" .. section_name .. "%s*{") then
            section_start = i
            break
        end
    end

    if not section_start then
        return nil
    end

    for i = section_start + 1, #lines do
        if lines[i]:match("^%s*}") then
            return nil
        end
        if lines[i]:match("path%s*=") then
            return i
        end
    end

    return nil
end

function M.update_section_path(filepath, section_name, new_path)
    local lines, err = M.read_lines(filepath)
    if not lines then
        return false, err
    end

    local path_index = M.find_path_in_section(lines, section_name)

    if not path_index then
        return false, "Section '" .. section_name .. "' or path not found in " .. filepath
    end

    -- Preserve original indentation
    local indent = lines[path_index]:match("^(%s*)")
    lines[path_index] = indent .. "path = " .. new_path

    return M.write_lines(filepath, lines)
end

return M
