local utils = require("emoji.utils")

local UI = {}

---creates a vim.ui.select window with all emojis to select one
---pastes the selected emoji at the current cursor position
UI.select_and_insert = function(options)
  vim.ui.select(options, {
    prompt = "Select an entry:",
    kind = "emoji_select",
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice then
      utils.insert_string_at_current_cursor(choice.insert_text)
    else
      vim.notify("Nothing selected", vim.log.levels.INFO, { title = "emoji.nvim" })
    end
  end)
end

---Generic function to select and insert by group
---@param items table The emoji or kaomoji item list
---@param groups table The groups to choose from
local function select_and_insert_by_group(items, groups)
  vim.ui.select(groups, {
    prompt = "Select a group:",
    kind = "emoji_group_select",
  }, function(choice)
    if choice then
      local filtered_items = {}
      for _, item in ipairs(items) do
        if item.group == choice then
          table.insert(filtered_items, item)
        end
      end
      UI.select_and_insert(filtered_items)
    else
      vim.notify("Nothing selected", vim.log.levels.INFO, { title = "emoji.nvim" })
    end
  end)
end

---creates a vim.ui.select window with all emoji groups to select one
---creates another vim.ui.select window with emojis from the previous selected group
---pastes the selected emoji at the current cursor position
UI.select_and_insert_emoji_by_group = function(emojis, groups)
  select_and_insert_by_group(emojis, groups)
end

---creates a vim.ui.select window with all kaomoji groups to select one
---creates another vim.ui.select window with kaomojis from the previous selected group
---pastes the selected kaomoji at the current cursor position
UI.select_and_insert_kaomoji_by_group = function(kaomojis, groups)
  select_and_insert_by_group(kaomojis, groups)
end

return UI
