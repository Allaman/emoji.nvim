" Title:        emoji.nvim
" Description:  A plugin that gives you emojis
" Last Change:  23 February 2024
" Maintainer:   Michael <https://github.com/allaman>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_emoji")
    finish
endif
let g:loaded_emoji = 1

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 InsertEmoji lua require("emoji").insert()
command! -nargs=0 InsertEmojiByGroup lua require("emoji").insert_by_group()
command! -nargs=0 InsertKaomoji lua require("emoji").insert_kaomoji()
command! -nargs=0 InsertKaomojiByGroup lua require("emoji").insert_kaomoji_by_group()
