return {
	"nvim-treesitter/nvim-treesitter", -- syntax highlighter
	build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")
    local parsers = require("nvim-treesitter.parsers")

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
      ensure_installed = {
        "bash",
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
        "terraform",
        "hcl",
        "python",
        "query",
        "regex",
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
