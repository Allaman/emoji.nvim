vim.api.nvim_create_user_command("EmojiInsert", function()
  require("emoji").insert()
end, {
  desc = "Insert an Emoji at the cursor's current position",
  nargs = 0,
})

vim.api.nvim_create_user_command("EmojiInsertByGroup", function()
  require("emoji").insert_by_group()
end, {
  desc = "Insert an Emoji, filtered by group, at the cursor's current position",
  nargs = 0,
})

vim.api.nvim_create_user_command("KaomojiInsert", function()
  require("emoji").insert_kaomoji()
end, {
  desc = "Insert a Kaomoji at the cursor's current position",
  nargs = 0,
})

vim.api.nvim_create_user_command("KaomojiInsertByGroup", function()
  require("emoji").insert_kaomoji_by_group()
end, {
  desc = "Insert an Kaomoji, filtered by group, at the cursor's current position",
  nargs = 0,
})
