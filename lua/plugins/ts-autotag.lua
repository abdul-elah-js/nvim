return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup({
      per_filetype = {
        ["html"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["tsx"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["jsx"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["typescriptreact"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["javascriptreact"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["typescript"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
        ["javascript"] = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true
        },
      }
    })
  end
}
