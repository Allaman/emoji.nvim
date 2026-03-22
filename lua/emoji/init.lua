local utils = require("emoji.utils")
local config = require("emoji.config")
local data = require("emoji.data")
local ui = require("emoji.ui")

local Main = {}

function Main.setup(opts)
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
    require("cmp").register_source("emoji", require("cmp_emoji.init").new())
  end
end

Main.insert = function()
  ui.select_and_insert(data.emoji_items())
end
Main.insert_by_group = function()
  ui.select_and_insert_emoji_by_group(data.emoji_items(), data.emoji_groups())
end

Main.insert_kaomoji = function()
  ui.select_and_insert(data.kaomoji_items())
end

Main.insert_kaomoji_by_group = function()
  ui.select_and_insert_kaomoji_by_group(data.kaomoji_items(), data.kaomoji_groups())
end

return Main
