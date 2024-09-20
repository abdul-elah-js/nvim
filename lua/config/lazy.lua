-- prepend mvim to the runtime
vim.opt.rtp:prepend("~/.config/nvim")

-- ensure lazy is installed first
local lazypath = vim.fn.stdpath("data") .. "/mlazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  print(out)
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.localmapleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.markdown_recommended_style = 0

-- solve reading terraform filetype as tf
vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

require("config.utils");
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    missing = true,
    colorscheme = {
      "rose-pine",
      "tokyonight",
      "catpuccin",
      "onedark",
      "neofusion",
      "everforest",
    },
  },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  ui = { border = "rounded" }
})
require("config.options")
require("config.keymaps")
require("colorscheme.init")
vim.cmd([[colorscheme rose-pine]])
