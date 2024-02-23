local M = {}

local defaults = { enable_cmp_integration = false, plugin_path = vim.fn.stdpath("data") .. "/lazy/" }

M.options = {}

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

M.setup()

return M
