return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>bd", ":Bdelete<CR>",               desc = "Delete Buffer" },
    { "<leader>bp", ":BufferLineTogglePin<CR>",   desc = "Pin/Unpin Buffer" },
    { "<Tab>",      ":BufferLineCycleNext<CR>",   desc = "Next Buffer" },
    { "<S-Tab>",    ":BufferLineCyclePrev<CR>",   desc = "Prev Buffer" },
    { "<C-Tab>",    ":BufferLineMoveNext<CR>",    desc = "Move Next" },
    { "<C-S-Tab>",  ":BufferLineMovePrev<CR>",    desc = "Move Prev" },
    { "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "Delete Others" },
    { "<leader>br", ":BufferLineCloseRight<CR>",  desc = "Delete Right" },
    { "<leader>bl", ":BufferLineCloseLeft<CR>",   desc = "Delete Left" },
    { "<leader>b0", ":BufferLineGoTo -1<CR>",     desc = "Focus Last Buffer" },
    { "<leader>b1", ":BufferLineGoTo 1<CR>",      desc = "Focus First Buffer" },
  },
  -- don't add any opts or config here, add in config.custom
}
