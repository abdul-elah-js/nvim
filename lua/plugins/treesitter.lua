return {
  "nvim-treesitter/nvim-treesitter", -- syntax highlighter
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<BS>",      desc = "Decrement Selection", mode = "x" },
    { "<C-Space>", desc = "Increment Selection", mode = "x" },
  },
  config = function()
    local configs = require("nvim-treesitter.configs")
    ---@diagnostic disable-next-line: missing-fields
    configs.setup({
      highlight = {
        enable = true,
        disable = {}
      },
      indent = {
        enable = true,
        disable = {},
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      sync_install = true,
      auto_install = false,
      ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "diff",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "hcl",
        "php",
        "python",
        "query",
        "regex",
        "sql",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml"
      },
    })
  end,
}
