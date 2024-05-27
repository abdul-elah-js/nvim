vim.o.background = "dark"

return {
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    config = function()
      require("neofusion").setup({
        transparent_mode = true,
        terminal_colors = true,
        overrides = {
          -- Comment = { fg = "#000000" },
        },
      })
      vim.cmd([[ colorscheme neofusion ]])
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight",
      -- colorscheme = "catppuccin",
      colorscheme = "neofusion",
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
