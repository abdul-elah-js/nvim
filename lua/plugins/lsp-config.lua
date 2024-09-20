local Opts = require("config.utils").opts
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
        "intelephense"
      },
    },
  },
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    config = function()
      require("telescope").load_extension('terraform_doc')
    end,
    lazy = true,
    event = { "BufEnter *.tf" },
  },
  {
    "neovim/nvim-lspconfig", -- connect neovim to lsp server
    event = "VeryLazy",
    keys = {
      { '<leader>xl', ':lua vim.diagnostic.setloclist()<CR>', desc = "Diagnostics List" },
      { '<leader>xn', ':lua vim.diagnostic.goto_next()<CR>',  desc = "Next Diagnostic" },
      { '<leader>xp', ':lua vim.diagnostic.goto_prev()<CR>',  desc = "Previous Diagnostic" },
      { '<leader>xo', ':lua vim.diagnostic.open_float()<CR>', desc = "Show Diagnostic" },

      { '<leader>ls', ':LspStart<CR>',                        desc = "Start" },
      { '<leader>lS', ':LspStop()<CR>',                       desc = "Stop" },
      { '<leader>lr', ':LspRestart<CR>',                      desc = "Restart" },
      { '<leader>ll', ':LspLog<CR>',                          desc = "Log" },
      { '<leader>li', ':LspInfo<CR>',                         desc = "Info" },
    },
    opts = function()
      return {
        diagnostics = {
          virtual_text = true,
          signs = true,
          update_in_insert = false,
          underline = true,
          severity_sort = true,
          float = {
            border = 'rounded',
            source = 'always',
          },
        },
        inlay_hints = {
          enabled = false,
          exclude = {}
        },
        codelens = {
          enabled = true
        },
        document_highlight = {
          enabled = false
        }
      }
    end,
    config = function(_, opts)
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

      -- if vim.fn.has("nvim-0.10") == "1" then
      --   if opts.inlay_hints.enabled then
      --
      --   end
      -- end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          local format_on_save_cmd_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_on_save_cmd_group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end

        if client.server_capabilities.documentFormattingProvider then
          vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.format({ async = true })<CR>", Opts("Format Code"))
        else
          vim.notify("Code Format is not supported by this client")
        end

        if client.server_capabilities.renameProvider then
          vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.rename()<CR>", Opts("Rename Symbol"))
        else
          vim.notify("Rename Symbol is not supported by this client")
        end

        if client.server_capabilities.definitionProvider then
          vim.keymap.set("n", "<leader>cd", ":lua vim.lsp.buf.definition()<CR>", Opts("Go To Definition"))
        else
          vim.notify("Go To Definition is not supported by this client")
        end

        if client.server_capabilities.declarationProvider then
          vim.keymap.set("n", "<leader>cD", ":lua vim.lsp.buf.declaration()<CR>", Opts("Go To Declaration"))
        else
          vim.notify("Go To Declaration is not supported by this client")
        end

        if client.server_capabilities.codeActionProvider then
          vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", Opts("Code Action"))
        else
          vim.notify("Code Action is not supported by this client")
        end

        if client.server_capabilities.hoverProvider then
          vim.keymap.set("n", "<leader>ch", ":lua vim.lsp.buf.hover()<CR>", Opts("Hover"))
        else
          vim.notify("Hover is not supported by this client")
        end

        if client.server_capabilities.signatureHelp then
          vim.keymap.set("n", "<leader>ck", ":lua vim.lsp.buf.signature_help()<CR>", Opts("Signature Help"))
        else
          vim.notify("Signature Help is not supported by this client")
        end

        if client.server_capabilities.implementationProvider then
          vim.keymap.set("n", "<leader>ci", ":lua vim.lsp.buf.implementation()<CR>", Opts("Go To Implementation"))
        else
          vim.notify("Go To Implementation is not supported by this client")
        end

        if client.server_capabilities.typeDefinitionProvider then
          vim.keymap.set("n", "<leader>ct", ":lua vim.lsp.buf.type_definition()<CR>", Opts("Go To Type Definition"))
        else
          vim.notify("Go To Type Definition is not supported by this client")
        end

        if client.server_capabilities.referencesProvider then
          vim.keymap.set("n", "<leader>cr", ":lua vim.lsp.buf.references()<CR>", Opts("Show References"))
        else
          vim.notify("References are not supported by this client")
        end

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client.server_capabilities.completionProvider then
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end

        -- if client.server_capabilities.dia
      end

      lspconfig.ansiblels.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "ansible-language-server", "--stdio" },
        filetypes = { "yaml.ansible" },
        root_dir = lspconfig.util.root_pattern("ansible.cfg", ".git", "playbooks/", "roles/"),
      }

      lspconfig.jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
      }

      lspconfig.ts_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        preferences = {
          importModuleSpecifierPreference = "non-relative",
        },
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      }

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
              version = "LuaJIT",
            },
            codelens = {
              enable = true
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true
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
            }
          }
        }
      }

      lspconfig.terraformls.setup {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_set_keymap("n", "<leader>cT", ":Telescope terraform_doc full_name=hashicorp/google<cr>",
            Opts("Terraform Google Docs"))
        end,
        capabilities = capabilities,
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "hcl", "tf", "tfvars" },
        root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
        settings = {
          terraform = {
            logLevel = "error",
            fileWatcher = false
          }
        }
      }

      lspconfig.yamlls.setup {
        on_attach = on_attach,
        capabilities = capabilities
      }

      lspconfig.intelephense.setup {
        on_attach    = on_attach,
        capabilities = capabilities,
        cmd          = { "intelephense", "--stdio" },
        filetypes    = { "php" },
        root_dir     = lspconfig.util.root_pattern("composer.json", ".git")
      }
    end
  }
}
