local utils = require("emoji.utils")

---@class EmojiData
---@field slug string
---@field character string
---@field unicode_name string
---@field code_point string
---@field group string
---@field subgroup string
local Emoji = {}

---load emoji data from JSON
---@param file_path string
---@return EmojiData
Emoji.load_emojis_from_json = function(file_path)
  local file, err = io.open(file_path, "r")
  if not file then
    utils.error("cannot open emoji data file at '" .. file_path .. "' with error: " .. err)
    return {}
  end

  local content = file:read("a")
  file:close()

  local emoji = vim.json.decode(content, {})
  if emoji == {} or emoji == nil then
    error("empty json decoded")
    return {}
  end
  return emoji
end

---filter emojis based on their group
---@param emojis EmojiData
---@param group string
---@return EmojiData
Emoji.filter_emojis_by_group = function(emojis, group)
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

---creates a list of unique emoji groups
---@param emojis EmojiData
---@return table<string><number>
Emoji.get_groups = function(emojis)
  local groups = {}
  for _, e in ipairs(emojis) do
    groups[e.group] = 1
  end
  return groups
end

return Emoji
