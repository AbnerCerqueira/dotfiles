local M = {}

local home = os.getenv("HOME")
M.HOME = home
M.DOTFILES = home .. "/dotfiles"
M.SCRIPTS = M.DOTFILES .. "/scripts"
M.HYPR = M.DOTFILES .. "/.config/hypr"
M.WALLPAPERS = M.DOTFILES .. "/wallpapers"
M.MATUGEN = M.DOTFILES .. "/.config/matugen/config.toml"

M.HYPR_LOCK = M.HYPR .. "/hyprlock.conf"
M.HYPR_PAPER = M.HYPR .. "/hyprpaper.conf"

return M
