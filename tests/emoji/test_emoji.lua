local new_set = MiniTest.new_set
local expect, eq, neq = MiniTest.expect, MiniTest.expect.equality, MiniTest.expect.no_equality

local T = new_set()
local utils = require("emoji.utils")

T["load emoji from json"] = function()
  local get = utils.load_from_json("tests/emoji/test_data/test.json")
  local want = {
    {
      character = "😀",
      code_point = "1F600",
      group = "smileys-emotion",
      slug = "grinning-face",
      subgroup = "face-smiling",
      unicode_name = "grinning face",
    },
    {
      character = "😃",
      code_point = "1F603",
      group = "flags",
      slug = "grinning-face-with-big-eyes",
      subgroup = "face-smiling",
      unicode_name = "grinning face with big eyes",
    },
  }
  eq(want, get)
end

-- TODO how to suppress error notification?
T["load non existe json"] = function()
  expect.error(utils.load_from_json("foobar.json"), nil)
end

-- FIXME does not "pass"
-- T["load malformed json"] = function()
--   expect.error(emoji.load_emojis_from_json("tests/emoji/test_data/broken.json"))
-- end

T["get emoji groups"] = function()
  local emojis = utils.load_from_json("tests/emoji/test_data/test.json")
  local get = utils.get_groups(emojis)
  local want = {
    flags = 1,
    ["smileys-emotion"] = 1,
  }
  eq(want, get)
end

T["filter emoji by group"] = function()
  local emojis = utils.load_from_json("tests/emoji/test_data/test.json")
  local get = utils.filter_by_group(emojis, "flags")
  local want = {
    {
      character = "😃",
      code_point = "1F603",
      group = "flags",
      slug = "grinning-face-with-big-eyes",
      subgroup = "face-smiling",
      unicode_name = "grinning face with big eyes",
    },
  }
  eq(want, get)
end

T["filter emoji with missing group"] = function()
  local emojis = utils.load_from_json("tests/emoji/test_data/test.json")
  local get = utils.filter_by_group(emojis, "foo")
  local want = {}
  eq(want, get)
end

return T
