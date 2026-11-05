local new_set = MiniTest.new_set
local eq = MiniTest.expect.equality

local T = new_set()
local kaomoji = require("emoji.kaomoji")

T["load kaomoji with and without keywords"] = function()
  local get = kaomoji.normalized_data("tests/emoji/test_data/kaomoji_test.json")
  local want = {
    { group = "Happy", character = "(^_^)", keywords = {} },
    { group = "Happy", character = "(＾▽＾)", keywords = { "happy", "smile" } },
    { group = "Happy", character = "(・ω・)", keywords = {} },
  }
  eq(want, get)
end

return T
