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

---load emoji data from JSON
---@param file_path string
---@return table
M.load_from_json = function(file_path)
  local file, err = io.open(file_path, "r")
  if not file then
    M.error("cannot open data file at '" .. file_path .. "' with error: " .. err)
    return {}
  end

  local content = file:read("a")
  file:close()

  local json_data = vim.json.decode(content, {})
  if json_data == {} or json_data == nil then
    error("empty json decoded")
    return {}
  end
  return json_data
end

---creates a list of unique emoji groups
---@param emojis EmojiData
---@return table<string><number>
M.get_groups = function(emojis)
  local groups = {}
  for _, e in ipairs(emojis) do
    groups[e.group] = 1
  end
  return groups
end

---filter emojis based on their group
---@param emojis EmojiData
---@param group string
---@return EmojiData
M.filter_by_group = function(emojis, group)
  ---@type EmojiData
  ---@diagnostic disable-next-line: missing-fields
  local filtered_emojis = {}
  for _, e in ipairs(emojis) do
    if e.group == group then
      table.insert(filtered_emojis, e)
    end
  end
  return filtered_emojis
end

M.insert_string_at_current_cursor = function(text)
  local buf = vim.api.nvim_get_current_buf()
  table.unpack = table.unpack or unpack -- 5.1 compatibility
  local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Adjust because Lua is 1-indexed but Neovim API expects 0-indexed
  vim.api.nvim_buf_set_text(buf, row, col, row, col, { text })
end

M.create_emoji_options = function(data)
  local options = {}
  for _, e in ipairs(data) do
    if e.unicodeName ~= nil then
      table.insert(options, e.character .. " " .. e.unicodeName)
    end
  end
  return options
end

M.create_kaomoji_options = function(data)
  local options = {}
  for _, e in ipairs(data) do
    if e.character ~= nil then
      table.insert(options, e.character .. " " .. e.group)
    end
  end
  return options
end

M.get_emoji_data_path = function()
  local plugin_path = require("emoji.config").options.plugin_path
  local emoji_path = require("emoji.config").paths.emoji
  local ok, path = pcall(require, "plenary.path")
  if not ok then
    error("failed to load plenary.nvim")
    return
  end
  return path:new(plugin_path, emoji_path)
end

M.get_kaomoji_data_path = function()
  local plugin_path = require("emoji.config").options.plugin_path
  local kaomoji_path = require("emoji.config").paths.kaomoji
  local ok, path = pcall(require, "plenary.path")
  if not ok then
    error("failed to load plenary.nvim")
    return
  end
  return path:new(plugin_path, kaomoji_path)
end

return M
