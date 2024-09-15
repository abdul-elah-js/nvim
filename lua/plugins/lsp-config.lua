local format_code = function(args)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {
    clear = true,
  })
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client and client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, event = "LspAttach" })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

return {
  {
    "williamboman/mason.nvim", -- lsp servers package manager
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig", -- configurations bridge between mason and nvim-lspconfig
    opts = {
      ensure_installed = {
        "lua_ls",
        "ansiblels",
        "jsonls",
        "ts_ls",
        "terraformls",
        "tflint",
        "yamlls",
      },
    },
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    config = function()
      require("telescope").load_extension('terraform_doc')
    end,
    event = { "BufEnter *.tf" },
    keys = {
      { "<leader>Tt", ":Telescope terraform_doc<CR>",                            mode = { "n", "x" }, desc = "Terraform docs" },
      { "<leader>Tm", ":Telescope terraform_doc modules<CR>",                    mode = { "n", "x" }, desc = "Terraform modules" },
      { "<leader>Tg", ":Telescope terraform_doc full_name=hashicorp/google<CR>", mode = { "n", "x" }, desc = "Terraform modules" },
      { "<leader>Ta", ":Telescope terraform_doc full_name=hashicorp/aws<CR>",    mode = { "n", "x" }, desc = "Terraform modules" },
      {
        "<leader>Ts",
        function()
          local module_name = vim.fn.input("Module: ")
          return ":Telescope terraform_doc full_name=" .. module_name .. "<CR>"
        end,
        mode = { "n", "x" },
        desc = "Search module"
      }
    }
  },
  {
    "neovim/nvim-lspconfig", -- connect neovim to lsp server
    event = "VeryLazy",
    keys = {
      { "<leader>cf",  vim.lsp.buf.format,         desc = "Code Format" },
      { "K",           vim.lsp.buf.hover,          desc = "Show Hover Help" },
      { "<leader>K",   vim.lsp.buf.signature_help, desc = "Show Signature Help" },
      { "<leader>ca",  vim.lsp.buf.code_action,    desc = "Show Code Actions" },
      { "<leader>cd",  vim.lsp.buf.definition,     desc = "Go To Definition" },
      { "<leader>cI",  vim.lsp.buf.implementation, desc = "List Implementations" },
      { "<leader>cr",  vim.lsp.buf.rename,         desc = "Rename Symbol" },
      { "<leader>xo",  vim.diagnostic.open_float,  desc = "Open Diagnostic" },
      { "<leader>x]",  vim.diagnostic.goto_next,   desc = "Go To Next Diagnostic" },
      { "<leader>x[",  vim.diagnostic.goto_prev,   desc = "Go To Prev Diagnostic" },
      { "<leader>cLi", ":LspInfo<CR>",             desc = "Lsp Info" },
      { "<leader>cls", ":LspStart<CR>",            desc = "Lsp Start" },
      { "<leader>clp", ":LspStop<CR>",             desc = "Lsp Pause" },
      { "<leader>clr", ":LspRestart<CR>",          desc = "Lsp Restart" },
      { "<leader>cm",  ":Mason<CR>",               desc = "Mason" },
    },
    config = function()
      local lspconfig = require("lspconfig")

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 50,
        max_height = 10,
        focusable = true,
        focus = false,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        max_width = 50,
        max_height = 10,
        focusable = true,
        focus = false,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          format_code(ev)
        end,
      })

      -- LSPs
      lspconfig.ansiblels.setup({
        cmd = { "ansible-language-server", "--stdio" },
        filetypes = { "yaml.ansible" },
        root_dir = require("lspconfig.util").root_pattern("ansible.cfg", ".git", "playbooks/", "roles/"),
      })

      lspconfig.jsonls.setup({
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
      })

      lspconfig.ts_ls.setup({
        preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- Optional: Disable third-party checking for a faster startup
            },
            telemetry = {
              enable = false, -- Do not send telemetry data containing a randomized but unique identifier
            },
          },
        },
      })

      lspconfig.terraformls.setup({
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "hcl", "tf", "tfvars" },
        root_dir = require("lspconfig.util").root_pattern(".terraform", ".git"),
      })

      lspconfig.yamlls.setup({})

      lspconfig.intelephense.setup({
        cmd       = { "intelephense", "--stdio" },
        filetypes = { "php" },
        root_dir  = lspconfig.util.root_pattern("composer.json", ".git")
      })

      -- lspconfig.phpactor.setup({
      --   cmd = { "phpactor", "language-server" },
      --   filetypes = { "php", "blade" },
      --   root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
      --   init_options = {
      --     ["language_server_worse_reflection.inlay_hints.enable"] = true,
      --     ["language_server_worse_reflection.inlay_hints.params"] = true,
      --     ["language_server_worse_reflection.inlay_hints.types"] = true,
      --     ["language_server_configuration.auto_config"] = false,
      --     ["code_transform.import_globals"] = true,
      --     ["language_server_phpstan.enabled"] = false,
      --     ["language_server_psalm.enabled"] = false,
      --     ["language_server_phpstan.level"] = "7",
      --     ["language_server_phpstan.bin"] = "phpstan",
      --   },
      -- })
    end,
  },
}
