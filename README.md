<h1 align="center">emoji.nvim 😀</h1>

<div align="center">
  <p>
    <img src="https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim"/>
    <img src="https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white" alt="Lua"/>
  </p>
</div>
<div align="center">
  <p>
    <img src="https://github.com/Allaman/emoji.nvim/actions/workflows/ci.yml/badge.svg" alt="CI"/>
    <!-- <img src="https://github.com/Allaman/emoji.nvim/actions/workflows/update-emojis.yml/badge.svg" alt="CI"/> -->
    <img src="https://img.shields.io/github/repo-size/Allaman/emoji.nvim" alt="size"/>
    <img src="https://img.shields.io/github/issues/Allaman/emoji.nvim.svg" alt="issues"/>
    <img src="https://img.shields.io/github/last-commit/Allaman/emoji.nvim" alt="last commit"/>
    <img src="https://img.shields.io/github/license/Allaman/emoji.nvim" alt="license"/>
    <img src="https://img.shields.io/github/v/release/Allaman/emoji.nvim?sort=semver" alt="release"/>
  </p>
</div>

## ❓ Why

Though there are a couple of plugins (see [Similar plugins and inspiration](#similar-plugins-and-inspiration)), they look a little unmaintained. So I decided to make a [15th plugin](https://xkcd.com/927/). 😉

## 💫 Features

- Automatic updates via GitHub actions.
- No dependencies (relies on `vim.ui.select`).
- Optional [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) integration.
- Optional [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) integration.

<details>
<summary>Some pics</summary

[![ui.png](https://s9.gifyu.com/images/SFndT.png)](https://gifyu.com/image/SFndT)
[![telescope.png](https://s9.gifyu.com/images/SFndw.png)](https://gifyu.com/image/SFndw)
[![cmp.png](https://s9.gifyu.com/images/SFnd3.png)](https://gifyu.com/image/SFnd3)

</details>

## 🔧 Installation

With [Lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "allaman/emoji.nvim",
  version = 1.0.0, -- optionally pin to a tag
  ft = "markdown", -- adjust to your needs
  dependencies = {
    -- optional for nvim-cmp integration
    "hrsh7th/nvim-cmp",
    -- optional for telescope integration
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    -- default is false
    enable_cmp_integration = true,
    -- optional if your plugin installation directory
    -- is not vim.fn.stdpath("data") .. "/lazy/
    plugin_path = vim.fn.expand("$HOME/plugins/"),
  },
}
```

For nvim-cmp integration add `emoji` to your list of sources:

```lua
    local sources = {
      { name = "nvim_lsp" },
      { name = "buffer", keyword_length = 5 },
      { name = "luasnip" },
      { name = "emoji" },
    }
```

Telescope integration should work out of the box if Telescope is installed.

## 💻 Use

1. `:InsertEmoji` respective `lua require("emoji").insert()`) or `:InsertEmojiByGroup` respective `lua require("emoji").insert_by_group()` allows you to select an emoji that is inserted at your cursor's current position.
2. `:Telescope emoji` does the same but invokes Telescope instead of `vim.ui.select`. (if telescope.nvim is installed).
3. While in insert mode typing `:` triggers the auto-completion of nvim-cmp. (if nvim-cmp integration is enabled and configured).

You can also create key bindings to your liking.

## 💡 Similar plugins and inspiration

- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji)
- [nerdy.nvim](https://github.com/2KAbhishek/nerdy.nvim)
- [nerdicons.nvim](https://github.com/nvimdev/nerdicons.nvim)
- [telescope-emoji](https://github.com/xiyaowong/telescope-emoji.nvim)
- [emoji_picker-nvim](https://github.com/WilsonOh/emoji_picker-nvim)

## ♥️ Credits

Thanks to [emojisource.app](https://emojisource.app/) that provides the emoji API used in GitHub Actions to automatically update emojis.
