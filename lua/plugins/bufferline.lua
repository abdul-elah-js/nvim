-- local highlights = require("nord").bufferline.highlights({ italic = true, bold = true })
return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>bd", ":bp|bd #<CR>",               desc = "Delete Buffer" },
    { "<leader>bp", ":BufferLineTogglePin<CR>",   desc = "Pin/Unpin Buffer" },
    { "<Tab>",      ":BufferLineCycleNext<CR>",   desc = "Next Buffer" },
    { "<S-Tab>",    ":BufferLineCyclePrev<CR>",   desc = "Prev Buffer" },
    { "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "Delete Others" },
    { "<leader>br", ":BufferLineCloseRight<CR>",  desc = "Delete Right" },
    { "<leader>bl", ":BufferLineCloseLeft<CR>",   desc = "Delete Left" },
  },
}
