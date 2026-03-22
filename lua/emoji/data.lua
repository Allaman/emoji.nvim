local utils = require("emoji.utils")
local kaomoji = require("emoji.kaomoji")

local M = {}

local cache = {
  emojis = nil,
  kaomojis = nil,
}

local function load_emojis()
  if cache.emojis then
    return cache.emojis
  end

  local path = utils.get_emoji_data_path()
  if not path then
    cache.emojis = {}
    return cache.emojis
  end

  local data = utils.load_from_json(path.filename)
  local items = {}
  for _, e in ipairs(data) do
    if e.character ~= nil and e.unicodeName ~= nil then
      table.insert(items, {
        insert_text = e.character,
        label = e.character .. " " .. e.unicodeName,
        character = e.character,
        name = e.unicodeName,
        group = e.group,
        slug = e.slug,
      })
    end
  end

  cache.emojis = items
  return cache.emojis
end

local function load_kaomojis()
  if cache.kaomojis then
    return cache.kaomojis
  end

  local path = utils.get_kaomoji_data_path()
  if not path then
    cache.kaomojis = {}
    return cache.kaomojis
  end

  local data = kaomoji.normalized_data(path.filename)
  local items = {}
  for _, e in ipairs(data) do
    if e.character ~= nil and e.group ~= nil then
      table.insert(items, {
        insert_text = e.character,
        label = e.character .. " " .. e.group,
        character = e.character,
        group = e.group,
      })
    end
  end

  cache.kaomojis = items
  return cache.kaomojis
end

local function groups_for(items)
  local seen = {}
  local groups = {}
  for _, item in ipairs(items) do
    if item.group ~= nil and not seen[item.group] then
      seen[item.group] = true
      table.insert(groups, item.group)
    end
  end
  table.sort(groups)
  return groups
end

M.emoji_items = function()
  return load_emojis()
end

M.kaomoji_items = function()
  return load_kaomojis()
end

M.emoji_groups = function()
  return groups_for(load_emojis())
end

M.kaomoji_groups = function()
  return groups_for(load_kaomojis())
end

return M
