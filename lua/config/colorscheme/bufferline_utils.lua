return {
  bufferline_setup = function(highlights)
    require("bufferline").setup({
      highlights = highlights,
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
}
