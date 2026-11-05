local utils = require("emoji.utils")

local M = {}

---creates normalized data structure for Kaomojis
---an entry is either a plain string or a table { character = string, keywords? = string[] }
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
      if type(char) == "table" then
        table.insert(normalized_data, { group = group, character = char.character, keywords = char.keywords or {} })
      else
        table.insert(normalized_data, { group = group, character = char, keywords = {} })
      end
    end
  end
  return normalized_data
end

return M
