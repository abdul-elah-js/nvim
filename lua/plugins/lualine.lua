-- require custom extensions
local extensions = require("lualine") -- replace root

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "folke/noice.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- require lazy extensions
    -- local lazy_status = require("lazy.status")
    local Util = require("lazyvim.util")

    -- custom setup
    require("lualine").setup({
      options = {
        theme = require("neofusion.lualine"),
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "packer", "help" },
        ignore_focus = {}, -- add filetypes inside
      },
      -- man:124 for sections doc
      sections = {
        lualine_a = { "mode" }, -- disable vim mode viewer
        lualine_b = {
          {
            "branch",
            icon = "", -- disable icon
            padding = { left = 1, right = 1 },
          },
        },
        lualine_c = {
          -- filetype icon
          {
            "filetype",
            icon_only = true,
            padding = { left = 2, right = 0 },
            color = "_lualine_c_filetype",
          },
          -- filename
          {
            "filename",
            file_status = true, -- display file status (read only, modified)
            path = 1, -- 0: just name, 1: relative path, 2: absolute path, 3: absolute path with ~ as home directory
            symbols = {
              unnamed = "",
              readonly = "",
              modified = "",
            },
            padding = { left = 1 },
            color = { gui = "bold" },
          },
        },
        lualine_x = {
          {
            "diff",
            colored = true,
            padding = { right = 2 },
            symbols = {
              added = "+",
              modified = "|",
              removed = "-",
            },
          },
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },
          -- {
          --   noice.api.statusline.mode.get,
          --   cond = noice.api.statusline.mode.has,
          --   color = { fg = "#ffffff" },
          -- },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = {
        "nvim-tree",
        "toggleterm",
        "mason",
        "fzf",
        "quickfix",
        "man",
        "lazy",
        -- custom extensions
        extensions.telescope,
        extensions.lspinfo,
        extensions.saga,
        extensions.btw,
      },
    })
  end,
}
