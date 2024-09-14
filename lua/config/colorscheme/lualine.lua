return {
  tokyonight = function()
    require("lualine").setup({
      options = { theme = "tokyonight" }
    })
  end,
  neofusion = function()
    require("lualine").setup({
      options = { theme = require("neofusion.lualine") }
    })
  end,
  everforest = function()
    require("lualine").setup({
      options = { theme = "everforest" }
    })
  end
}
