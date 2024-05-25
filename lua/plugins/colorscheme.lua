return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      -- colorscheme = "catppuccin",
      -- colorscheme = "neofusion",
    },
  },

  -- {
  --   "diegoulloao/neofusion.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("neofusion").setup({
  --       transparent_mode = true,
  --     })
  --   end,
  -- },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
