return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    opts = {
      servers = {
        emmet_ls = {
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "typescript",
            "javascript",
            "markdown",
            "ejs",
          },
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true,
              },
            },
          },
        },
        intelephense = {
          filetypes = { "php" },
          settings = {
            intelephense = {
              root_pattern = { "composer.json", ".git" },
              format = {
                braces = "k&r",
              },
            },
          },
        },
      },
      autoformat = true,
    },
  },
}
