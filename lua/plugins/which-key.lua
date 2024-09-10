return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    layout = {
      spacing = 7,
    },
    spec = {
      { "<leader>f", group = "Files" },
      { "<leader>c", group = "Code" },
      { "<leader>s", group = "Settings", icon = "" },
      { "<leader>t", group = "Terminal" },
      { "<leader>e", group = "Explorer", icon = "" },
      { "<leader>w", group = "Window", icon = "" },
      { "<leader>l", group = "Lazy" },
      { "<leader>b", group = "Buffers" },
      { '<leader>"', hidden = true, group = "Register", icon = "🕳️" },
      { "<leader>K", hidden = true },
      { "<leader>]", hidden = true },
      { "<leader>[", hidden = true },
      { "<leader>q", hidden = true },
    },
  },
}
