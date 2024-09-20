return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    layout = {
      spacing = 7,
    },
    spec = {
      { "<leader>f", group = "Find", icon = "" },
      { "<leader>c", group = "Code", icon = "󰅭" },
      { "<leader>cl", group = "Lsp", icon = "" },
      { "<leader>s", group = "Switches", icon = "󰺟" },
      { "<leader>o", group = "Obsidian", icon = "󱓧" },
      { "<leader>t", group = "Terminal", icon = "" },
      { "<leader>e", group = "Explorer", icon = "󱏒" },
      { "<leader>T", group = "Tabs", icon = "󰓩" },
      { "<leader>q", group = "Quit", icon = "󰩈" },
      { "<leader>w", group = "Windows", icon = "" },
      { "<leader>b", group = "Buffers", icon = "" },
      { "<leader>x", group = "Diagnostics", icon = "󰨮" },
      { "<leader>'", group = "Register", icon = "" },
      { "<leader>l", hidden = true, group = "Lazy", },
      { "<leader><space>", hidden = true },
      { "<leader>/", hidden = true }
    },
  },
}
