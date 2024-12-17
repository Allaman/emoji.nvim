local utils = require("emoji.utils")

vim.api.nvim_create_user_command("Emoji", function(opts)
  if #opts.fargs == 0 then
    require("emoji").insert()
    return
  end

  local subcommand = opts.fargs[1]

  if subcommand == "insert" then
    require("emoji").insert()
  elseif subcommand == "by-group" then
    require("emoji").insert_by_group()
  elseif subcommand == "kaomoji" then
    require("emoji").insert_kaomoji()
  elseif subcommand == "kaomoji-by-group" then
    require("emoji").insert_kaomoji_by_group()
  else
    utils.error("Unknown subcommand: " .. subcommand)
  end
end, {
  nargs = "*",
  complete = function(argLead)
    local subcommands = {
      "insert",
      "by-group",
      "kaomoji",
      "kaomoji-by-group",
    }

    local filtered = vim.tbl_filter(function(option)
      return vim.startswith(option, argLead)
    end, subcommands)

    return filtered
  end,
  desc = "Emoji.nvim",
})
