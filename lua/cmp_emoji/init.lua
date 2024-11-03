local utils = require("emoji.utils")

local emoji_path = utils.get_emoji_data_path().filename
local emojis = utils.load_from_json(emoji_path)

local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  self.commit_items = nil
  self.insert_items = nil
  return self
end

source.get_trigger_characters = function()
  return { ":" }
end
source.get_keyword_pattern = function()
  return [=[\%([[:space:]"'`]\|^\)\zs:[[:alnum:]_\-\+]*:\?]=]
end

---creates the datastructure for cmp source
---example: { word = ":winkind-face:", label = "😉 :winking-face:", insertText = "😉", lterText = ":winking-face"}
---@return cmp_source|nil
local function create_cmp_items()
  ---@class cmp_source
  ---@field word string
  ---@field label string
  ---@field insertText string
  ---@field lterText string
  local cmp_items = {}
  for _, emoji in pairs(emojis) do
    table.insert(cmp_items, {
      word = string.format(":%s:", emoji.slug),
      label = string.format("%s :%s:", emoji.character, emoji.slug),
      insertText = string.format("%s ", emoji.character),
      lterText = emoji.slug,
    })
  end
  return cmp_items
end

source.complete = function(self, params, callback)
  -- Avoid unexpected completion.
  if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(params.context.cursor_before_line) then
    return callback()
  end

  if self:option(params).insert then
    if not self.insert_items then
      self.insert_items = vim.tbl_map(function(item)
        item.word = nil
        return item
      end, create_cmp_items())
    end
    callback(self.insert_items)
  else
    if not self.commit_items then
      self.commit_items = create_cmp_items()
    end
    callback(self.commit_items)
  end
end

source.option = function(_, params)
  return vim.tbl_extend("force", {
    insert = false,
  }, params.option)
end

return source
