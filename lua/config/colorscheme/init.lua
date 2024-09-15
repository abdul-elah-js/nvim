local colorscheme_group = vim.api.nvim_create_augroup("colorscheme_changed", {
  clear = true
})

local lualine_config = require("config.colorscheme.lualine")
local bufferline_config = require("config.colorscheme.bufferline")
local toggleterm_config = require("config.colorscheme.toggleterm")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = colorscheme_group,
  callback = function()
    local colorscheme = vim.g.colors_name
    if colorscheme == 'rose-pine' then
      colorscheme = 'rose_pine'
    end
    -- lualine config
    if lualine_config[colorscheme] then
      lualine_config[colorscheme]()
    end

    -- bufferline config
    local bufferline_highlights = {}
    if bufferline_config[colorscheme] then
      bufferline_highlights = bufferline_config[colorscheme]()
    end
    require("config.colorscheme.bufferline_utils").bufferline_setup(bufferline_highlights)

    -- toggleterm
    if toggleterm_config[colorscheme] then
      toggleterm_config[colorscheme]()
    end
  end
})
