local M = {}

---@class EmojiConfig
---@field enable_cmp_integration? boolean
---@field plugin_path? string

---@type EmojiConfig
M.options = {
  enable_cmp_integration = false,
  plugin_path = vim.fn.stdpath("data") .. "/lazy/",
}

M.paths = {
  emoji = "emoji.nvim/lua/data/emojis.json",
  kaomoji = "emoji.nvim/lua/data/kaomojis.json",
}

---@param options? EmojiConfig
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.options, options or {})
end

return M
