local utils = require("emoji.utils")
local plugin_path = require("emoji.config").options.plugin_path

local emojis = require("emoji.emoji").load_emojis_from_json(plugin_path .. "emoji.nvim/lua/emoji/emojis.json")
local groups = require("emoji.emoji").get_groups(emojis)

local UI = {}

---creates a vim.ui.select window and inserts the choosen emoji at the current cursor
---@param e EmojiData
local function emoji_select(e)
  local emoji_options = {}
  -- Prepare the list of emoji options
  for _, emoji in pairs(e) do
    table.insert(emoji_options, emoji.character .. " : " .. emoji.unicode_name)
  end

  -- Show the selection UI
  vim.ui.select(emoji_options, {
    prompt = "Select an emoji:",
    kind = "emoji_select",
  }, function(choice, index)
    if choice then
      utils.insert_string_at_current_cursor(e[index].character)
    else
      print("No emoji selected.")
    end
  end)
end

---creates a vim.ui.select window with all emojis to select one
---pastes the selected emoji at the current cursor position
UI.select_and_insert_emoji = function()
  local emoji_options = {}
  for _, e in ipairs(emojis) do
    table.insert(emoji_options, e.character .. " " .. e.unicode_name)
  end

  vim.ui.select(emoji_options, {
    prompt = "Select an emoji:",
    kind = "emoji_select",
  }, function(choice, index)
    if choice then
      utils.insert_string_at_current_cursor(emojis[index].character)
    else
      print("No emoji selected.")
    end
  end)
end

---creates a vim.ui.select window with all emoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected emoji at the current cursor position
UI.select_and_insert_emoji_by_group = function()
  local group_options = {}
  for k, _ in pairs(groups) do
    table.insert(group_options, k)
  end

  vim.ui.select(group_options, {
    prompt = "Select an emoji group:",
    kind = "emoji_group_select",
  }, function(choice, index)
    if choice then
      local filtered_emojis = require("emoji.emoji").filter_emojis_by_group(emojis, group_options[index])
      emoji_select(filtered_emojis)
    else
      print("No emoji group selected.")
    end
  end)
end

return UI
