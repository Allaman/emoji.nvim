local M = {}

---info notification
---@param msg string
M.info = function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "emoji.nvim" })
end

---warning notification
---@param msg string
M.warn = function(msg)
  vim.notify(msg, vim.log.levels.WARN, { title = "emoji.nvim" })
end

---error notification
---@param msg string
M.error = function(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = "emoji.nvim" })
end

---returns OS dependant path separator
---@return string
M.path_separator = function()
  local is_windows = vim.fn.has("win32") == 1
  if is_windows == true then
    return "\\"
  else
    return "/"
  end
end

---checks if a module is available
---@param module string
---@return boolean
M.is_module_available = function(module)
  local ok = pcall(require, module)
  if not ok then
    return false
  end
  return true
end

--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.is_neovim_version_satisfied = function(version)
  return version <= tonumber(vim.version().minor)
end

M.insert_string_at_current_cursor = function(text)
  local buf = vim.api.nvim_get_current_buf()
  table.unpack = table.unpack or unpack -- 5.1 compatibility
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Adjust because Lua is 1-indexed but Neovim API expects 0-indexed
  vim.api.nvim_buf_set_text(buf, row, col, row, col, { text })
end

return M
