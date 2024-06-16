return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      vue = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      less = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      jsonc = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
    },
    -- format_on_save = {
    --   -- I recommend these options. See :help conform.format for details.
    --   lsp_fallback = true,
    --   timeout_ms = 500,
    -- },
  },
}
