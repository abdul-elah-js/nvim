return {
  "akinsho/toggleterm.nvim",
  version = "*", -- Use for stable version
  lazy = false,
  keys = {
    { "<leader>tv", ":ToggleTerm direction=vertical<CR>",    desc = "terminal vertical" },
    { "<leader>th", ":ToggleTerm direction=horizontal<CR>",  desc = "terminal horizontal" },
    { "<leader>tf", ":ToggleTerm direction=float<CR>",       desc = "terminal float" },
    { "<leader>tH", ":ToggleTerm direction=float dir=~<CR>", desc = "terminal float (~)" },
    {
      "<C-_>",
      ":ToggleTerm direction=float<CR>",
      mode = { "n", "x" },
      desc = "Toggle Terminal",
    },
    {
      "<C-/>",
      ":ToggleTerm direction=float<CR>",
      mode = { "n", "x" },
      desc = "Toggle Terminal",
    },
    {
      "<C-_>",
      "<C-\\><C-n>:ToggleTerm<CR>",
      mode = "t",
      desc = "Toggle Terminal",
    },
    {
      "<C-/>",
      "<C-\\><C-n>:ToggleTerm<CR>",
      mode = "t",
      desc = "Toggle Terminal",
    },
    {
      "<C-q>",
      "<C-\\><C-n>",
      mode = "t",
      desc = "Toggle Terminal",
    },
  },
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-_>]],
      shade_terminals = false,
      start_in_insert = true,
      direction = "float",
      persist_mode = false,
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      autochdir = false,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    })
  end,
}
