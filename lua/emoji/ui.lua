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
      vim.api.nvim_notify("Nothing selected", 0, {})
    end
  end)
end

---creates a vim.ui.select window with all emoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected emoji at the current cursor position
UI.select_and_insert_emoji_by_group = function(emojis, groups)
  local group_options = {}
  for k, _ in pairs(groups) do
    table.insert(group_options, k)
  end
  vim.ui.select(group_options, {
    prompt = "Select a group:",
    kind = "emoji_group_select",
  }, function(choice, index)
    if choice then
      local filtered_emojis = utils.filter_by_group(emojis, group_options[index])
      local options = utils.create_emoji_options(filtered_emojis)
      UI.select_and_insert(options)
    else
      vim.api.nvim_notify("Nothing selected", 0, {})
    end
  end)
end

---creates a vim.ui.select window with all kaomoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected kaomoji at the current cursor position
UI.select_and_insert_kaomoji_by_group = function(kaomojis, groups)
  local group_options = {}
  for k, _ in pairs(groups) do
    table.insert(group_options, k)
  end
  vim.ui.select(group_options, {
    prompt = "Select a group:",
    kind = "emoji_group_select",
  }, function(choice, index)
    if choice then
      local filtered_kaomojis = utils.filter_by_group(kaomojis, group_options[index])
      local options = utils.create_kaomoji_options(filtered_kaomojis)
      UI.select_and_insert(options)
    else
      vim.api.nvim_notify("Nothing selected", 0, {})
    end
  end)
end

return UI
