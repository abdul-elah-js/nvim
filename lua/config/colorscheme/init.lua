local colorscheme_group = vim.api.nvim_create_augroup("colorscheme_changed", {
  clear = true
})

local lualine_config = require("config.colorscheme.lualine")
local bufferline_config = require("config.colorscheme.bufferline")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = colorscheme_group,
  callback = function()
    local colorscheme = vim.g.colors_name
    -- lualine config
    if lualine_config[colorscheme] then
      lualine_config[colorscheme]()
    end
    -- bufferline config
    local bufferline_highlights
    if bufferline_config[colorscheme] then
      bufferline_highlights = bufferline_config[colorscheme]()
    else
      bufferline_highlights = {}
    end
    require("bufferline").setup({
      highlights = bufferline_highlights,
      options = {
        mode = "buffers",
        -- style_preset = bufferline.style_preset.default,
        color_icons = true,
        close_icon = "",
        show_buffer_icons = true,
        show_duplicate_prefix = true,
        separator_style = "thick",
        -- diagnostics = "nvim_lsp",
        indicator = {
          style = "icon",
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = false,
            padding = 1,
          },
        },
        diagnostics_indicator = function(count) -- diagnostics format
          return " " .. count
        end,
        -- exclude some buffer and file types
        custom_filter = function(buf_number)
          local buftype = vim.api.nvim_buf_get_option(buf_number, "buftype")
          local filetype = vim.api.nvim_buf_get_option(buf_number, "filetype")

          -- exclude list
          local excluded_filetypes = {
            ["terminal"] = true,
            ["TelescopePrompt"] = true,
            ["NvimTree"] = true,
            ["sagaoutline"] = true,
            ["sagafinder"] = true,
            ["starter"] = true,
          }

          local excluded_buftypes = {
            ["nofile"] = true,
            ["terminal"] = true,
          }

          return not excluded_buftypes[buftype] and not excluded_filetypes[filetype]
        end,
      },
    })
  end
})
