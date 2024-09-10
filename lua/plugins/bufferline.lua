-- local highlights = require("nord").bufferline.highlights({ italic = true, bold = true })

return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>bd", ":bp|bd #<CR>",               desc = "Delete Buffer" },
    { "<leader>bp", ":BufferLineTogglePin<CR>",   desc = "Pin/Unpin Buffer" },
    { "<Tab>",      ":BufferLineCycleNext<CR>",   desc = "Next Buffer" },
    { "<S-Tab>",    ":BufferLineCyclePrev<CR>",   desc = "Prev Buffer" },
    { "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "Delete Others" },
    { "<leader>br", ":BufferLineCloseRight<CR>",  desc = "Delete Right" },
    { "<leader>bl", ":BufferLineCloseLeft<CR>",   desc = "Delete Left" },
  },
  config = function()
    require("bufferline").setup({
      highlights = {
        fill = {
          fg = "#E2D9C6", -- Slightly brighter than the background for contrast
          bg = "#041924",
        },
        background = {
          fg = "#E2D9C6", -- Even brighter for better visibility of inactive buffers
          bg = "#041924",
        },
        tab = {
          fg = "#5C6370",
          bg = "#041924",
        },
        tab_selected = {
          fg = "#52b2c9", -- Bright and noticeable for selected tab
          bg = "#041924",
        },
        tab_separator = {
          fg = "#5C4A72",
          bg = "#041924",
        },
        tab_separator_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#C3A6FF",
          underline = true,
        },
        tab_close = {
          fg = "#5C6370",
          bg = "#041924",
        },
        close_button = {
          fg = "#5C6370",
          bg = "#041924",
        },
        close_button_visible = {
          fg = "#5C6370",
          bg = "#041924",
        },
        close_button_selected = {
          fg = "#52b2c9",
          bg = "#041924",
        },
        buffer_visible = {
          fg = "#5C6370",
          bg = "#041924",
        },
        buffer_selected = {
          fg = "#ffffff", -- Brighter color for the selected buffer
          bg = "#041924",
          bold = false,
          italic = true,
        },
        numbers = {
          fg = "#5C6370",
          bg = "#041924",
        },
        numbers_visible = {
          fg = "#5C6370",
          bg = "#041924",
        },
        numbers_selected = {
          fg = "#E2BFFF",
          bg = "#041924",
          bold = true,
          italic = true,
        },
        diagnostic = {
          fg = "#FF6B6B", -- Red for diagnostics (errors)
          bg = "#041924",
        },
        diagnostic_visible = {
          fg = "#FF6B6B",
          bg = "#041924",
        },
        diagnostic_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          bold = true,
          italic = true,
        },
        hint = {
          fg = "#6BE37F", -- Green for hints
          sp = "#6BE37F",
          bg = "#041924",
        },
        hint_visible = {
          fg = "#6BE37F",
          bg = "#041924",
        },
        hint_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#6BE37F",
          bold = true,
          italic = true,
        },
        hint_diagnostic = {
          fg = "#6BE37F",
          sp = "#6BE37F",
          bg = "#041924",
        },
        hint_diagnostic_visible = {
          fg = "#6BE37F",
          bg = "#041924",
        },
        hint_diagnostic_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#6BE37F",
          bold = true,
          italic = true,
        },
        info = {
          fg = "#A3BE8C", -- Softer green for informational text
          sp = "#A3BE8C",
          bg = "#041924",
        },
        info_visible = {
          fg = "#A3BE8C",
          bg = "#041924",
        },
        info_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#A3BE8C",
          bold = true,
          italic = true,
        },
        info_diagnostic = {
          fg = "#A3BE8C",
          sp = "#A3BE8C",
          bg = "#041924",
        },
        info_diagnostic_visible = {
          fg = "#A3BE8C",
          bg = "#041924",
        },
        info_diagnostic_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#A3BE8C",
          bold = true,
          italic = true,
        },
        warning = {
          fg = "#EBCB8B", -- Yellow for warnings
          sp = "#EBCB8B",
          bg = "#041924",
        },
        warning_visible = {
          fg = "#EBCB8B",
          bg = "#041924",
        },
        warning_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#EBCB8B",
          bold = true,
          italic = true,
        },
        warning_diagnostic = {
          fg = "#EBCB8B",
          sp = "#EBCB8B",
          bg = "#041924",
        },
        warning_diagnostic_visible = {
          fg = "#EBCB8B",
          bg = "#041924",
        },
        warning_diagnostic_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#EBCB8B",
          bold = true,
          italic = true,
        },
        error = {
          fg = "#D08770", -- Red/orange for errors
          sp = "#D08770",
          bg = "#041924",
        },
        error_visible = {
          fg = "#D08770",
          bg = "#041924",
        },
        error_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#D08770",
          bold = true,
          italic = true,
        },
        error_diagnostic = {
          fg = "#D08770",
          bg = "#041924",
          sp = "#D08770",
        },
        error_diagnostic_visible = {
          fg = "#D08770",
          bg = "#041924",
        },
        error_diagnostic_selected = {
          fg = "#52b2c9",
          bg = "#041924",
          sp = "#D08770",
          bold = true,
          italic = true,
        },
        modified = {
          fg = "#5C6370", -- Green to indicate modified files
          bg = "#041924",
        },
        modified_visible = {
          fg = "#5C6370",
          bg = "#041924",
        },
        modified_selected = {
          fg = "#ffffff",
          bg = "#041924",
        },
        duplicate_selected = {
          fg = "#ffffff", -- Light purple to indicate duplicates
          bg = "#041924",
          italic = true,
        },
        duplicate_visible = {
          fg = "#5C6370",
          bg = "#041924",
          italic = true,
        },
        duplicate = {
          fg = "#5C6370",
          bg = "#041924",
          italic = true,
        },
        separator_selected = {
          fg = "#52b2c9",
          bg = "#041924",
        },
        separator_visible = {
          fg = "#041924",
          bg = "#041924",
        },
        separator = {
          fg = "#041924",
          bg = "#041924",
        },
        indicator_visible = {
          fg = "#5C6370",
          bg = "#041924",
        },
        indicator_selected = {
          fg = "#52b2c9",
          bg = "#041924",
        },
        pick_selected = {
          fg = "#52b2c9", -- Gold to indicate pick mode
          bg = "#041924",
          bold = true,
          italic = true,
        },
        pick_visible = {
          fg = "#FFD700",
          bg = "#041924",
          bold = true,
          italic = true,
        },
      },
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
        diagnostics_indicator = function(count, level) -- diagnostics format
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
  end,
}
