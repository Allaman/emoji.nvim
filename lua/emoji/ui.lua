local utils = require("emoji.utils")

local UI = {}

---creates a vim.ui.select window with all emojis to select one
---pastes the selected emoji at the current cursor position
UI.select_and_insert = function(options)
  vim.ui.select(options, {
    prompt = "Select an entry:",
    kind = "emoji_select",
  }, function(choice)
    if choice then
      -- HACK: find first space position to separate character from name
      local space_pos = string.find(choice, " ")
      local emoji = string.sub(choice, 1, space_pos - 1)
      utils.insert_string_at_current_cursor(emoji)
    else
      vim.notify("Nothing selected", vim.log.levels.INFO, { title = "emoji.nvim" })
    end
  end)
end

---Generic function to select and insert by group
---@param data table The emoji or kaomoji data
---@param groups table The groups to choose from
---@param create_options_fn function Function to create options from filtered data
local function select_and_insert_by_group(data, groups, create_options_fn)
  local group_options = {}
  for k, _ in pairs(groups) do
    table.insert(group_options, k)
  end
  vim.ui.select(group_options, {
    prompt = "Select a group:",
    kind = "emoji_group_select",
  }, function(choice, index)
    if choice then
      local filtered_data = utils.filter_by_group(data, group_options[index])
      local options = create_options_fn(filtered_data)
      UI.select_and_insert(options)
    else
      vim.notify("Nothing selected", vim.log.levels.INFO, { title = "emoji.nvim" })
    end
  end)
end

---creates a vim.ui.select window with all emoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected emoji at the current cursor position
UI.select_and_insert_emoji_by_group = function(emojis, groups)
  select_and_insert_by_group(emojis, groups, utils.create_emoji_options)
end

---creates a vim.ui.select window with all kaomoji groups to select one
---creates another vim.ui.select window with kaomojis from the previous selected group
---pastes the selected kaomoji at the current cursor position
UI.select_and_insert_kaomoji_by_group = function(kaomojis, groups)
  select_and_insert_by_group(kaomojis, groups, utils.create_kaomoji_options)
end

return UI
