local utils = require("emoji.utils")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 45 },
    { width = 16 },
    { remaining = true },
  },
})

local make_display = function(entry)
  -- this defines how it is "rendered" im Telescope
  return displayer({
    entry.character .. " " .. entry.name,
    entry.group,
  })
end

function M.finder()
  local results = {}
  local emoji_path = utils.get_emoji_data_path().filename
  local emojis = utils.load_from_json(emoji_path)
  for _, e in ipairs(emojis) do
    table.insert(results, { name = e.unicodeName, character = e.character, group = e.group })
  end
  return finders.new_table({
    results = results,
    entry_maker = function(entry)
      return {
        -- this defines what terms can be searched in telescope
        ordinal = entry.name .. entry.group,

        display = make_display,
        value = entry,
        character = entry.character,
        group = entry.group,
        name = entry.name,
      }
    end,
  })
end

function M.telescope(opts)
  pickers
    .new(opts, {
      results_title = "Emoji.nvim",
      prompt_title = "Find Emojis",
      finder = M.finder(),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local e = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          utils.insert_string_at_current_cursor(e.character)
        end)
        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  exports = {
    emoji = M.telescope,
  },
})
