local utils = require("emoji.utils")
local config = require("emoji.config")

local Emoji = {}

function Emoji.setup(opts)
  if not utils.is_neovim_version_satisfied(9) then
    utils.error("Emoji needs Neovim >= 0.9.0")
    return
  end
  config.setup(opts)

  if config.options.enable_cmp_integration then
    if not utils.is_module_available("cmp") then
      utils.error("cannot load nvim-cmp for emoji completion")
      return
    end
    -- Inject emoji as a cmp source.
    local cmp = require("cmp")
    cmp.register_source("emoji", require("cmp_emoji.init").new())
    local sources = { { name = "emoji" } }
    cmp.setup.buffer({ sources = sources })
  end
end

Emoji.insert = function()
  require("emoji.ui").select_and_insert_emoji()
end
Emoji.insert_by_group = function()
  require("emoji.ui").select_and_insert_emoji_by_group()
end

return Emoji
