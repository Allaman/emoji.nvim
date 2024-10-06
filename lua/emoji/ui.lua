local utils = require("emoji.utils")

local UI = {}

---creates a vim.ui.select window with all emojis to select one
---pastes the selected emoji at the current cursor position
UI.select_and_insert = function(emojis)
  local emoji_options = {}
  for _, e in ipairs(emojis) do
    -- handle emojis
    if e.unicodeName ~= nil then
      table.insert(emoji_options, e.character .. " " .. e.unicodeName)
    end
    -- handle kaomojis
    if e.group ~= nil then
      table.insert(emoji_options, e.character .. " " .. e.group)
    end
  end
  vim.ui.select(emoji_options, {
    prompt = "Select an entry:",
    kind = "emoji_select",
  }, function(choice, index)
    if choice then
      utils.insert_string_at_current_cursor(emojis[index].character)
    else
      vim.api.nvim_notify("Nothing selected", 0, {})
    end
  end)
end

---creates a vim.ui.select window with all emoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected emoji at the current cursor position
UI.select_and_insert_by_group = function(emojis, groups)
  local group_options = {}
  for k, _ in pairs(groups) do
    table.insert(group_options, k)
  end
  vim.ui.select(group_options, {
    prompt = "Select a group:",
    kind = "emoji_group_select",
  }, function(choice, index)
    if choice then
      local filtered = utils.filter_by_group(emojis, group_options[index])
      UI.select_and_insert(filtered)
    else
      vim.api.nvim_notify("Nothing selected", 0, {})
    end
  end)
end

return UI
