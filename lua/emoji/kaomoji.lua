local utils = require("emoji.utils")

local M = {}

---creates normalized data structure for Kaomojis
---@param file_path string
---@return table<string><string>
M.normalized_data = function(file_path)
  ---@type table<string><string>
  local normalized_data = {}
  local data = utils.load_from_json(file_path)
  if data == nil then
    return normalized_data
  end
  for group, chars in pairs(data) do
    for _, char in pairs(chars) do
      table.insert(normalized_data, { group = group, character = char })
    end
  end
  return normalized_data
end

return M
