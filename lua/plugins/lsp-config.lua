local Opts = require("config.utils").opts
return {
	{
		"ANGkeith/telescope-terraform-doc.nvim",
		config = function()
			require("telescope").load_extension("terraform_doc")
		end,
		lazy = true,
		event = { "BufEnter *.tf" },
	},

	{
		"neovim/nvim-lspconfig", -- connect neovim to lsp server
		dependencies = {
			{
				"williamboman/mason.nvim", -- lsp servers package manager
				config = true,
			},
			{
				"williamboman/mason-lspconfig", -- configurations bridge between mason and nvim-lspconfig
			},
			{ "folke/neodev.nvim", opts = {} },
		},
		event = "VeryLazy",
		keys = {},
		opts = {
			diagnostics = {
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			},
			inlay_hints = {
				enabled = false,
				exclude = {},
			},
			codelens = {
				enabled = true,
			},
			document_highlight = {
				enabled = false,
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("iLspAttach", { clear = true }),
				callback = function(event)
					-- Keymaps
					local keymap = vim.keymap
					keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, Opts("[G]oto [D]efinition"))
					keymap.set("n", "gr", require("telescope.builtin").lsp_references, Opts("[G]oto [R]eferences"))
					keymap.set(
						"n",
						"gI",
						require("telescope.builtin").lsp_implementations,
						Opts("[G]oto [I]mplementation")
					)
					keymap.set(
						"n",
						"<leader>cD",
						require("telescope.builtin").lsp_type_definitions,
						Opts("Type [D]efinition")
					)
					keymap.set(
						"n",
						"<leader>cs",
						require("telescope.builtin").lsp_document_symbols,
						Opts("[D]ocument [S]ymbols")
					)
					keymap.set(
						"n",
						"<leader>cS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						Opts("[W]orkspace [S]ymbols")
					)
					keymap.set("n", "<leader>cr", vim.lsp.buf.rename, Opts("[R]e[n]ame"))
					keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, Opts("[C]ode [A]ction"))
					keymap.set("n", "K", vim.lsp.buf.hover, Opts("Hover Documentation"))
					keymap.set("n", "gD", vim.lsp.buf.declaration, Opts("[G]oto [D]eclaration"))
					keymap.set("n", "<leader>xl", vim.diagnostic.setloclist, Opts("Diagnostics List"))
					keymap.set("n", "]d", vim.diagnostic.goto_next, Opts("Next Diagnostic"))
					keymap.set("n", "[d", vim.diagnostic.goto_prev, Opts("Previous Diagnostic"))
					keymap.set("n", "<leader>xo", vim.diagnostic.open_float, Opts("Show Diagnostic"))

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup = vim.api.nvim_create_augroup("iLspHighlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("iLspDetach", { clear = true }),
							callback = function(inner_event)
								if vim.api.nvim_buf_is_valid(inner_event.buf) then
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({ group = "iLspHighlight", buffer = inner_event.buf })
								end
							end,
						})
					end

					-- inlay hints
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end)
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				ansiblels = {},
				jsonls = {},
				sqlls = {},
				ts_ls = {
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				eslint = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
				tailwindcss = {},
				html = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							codelens = {
								enable = false,
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false, -- Optional: Disable third-party checking for a faster startup
							},
							telemetry = {
								enable = false, -- Do not send telemetry data containing a randomized but unique identifier
							},
						},
					},
				},
				terraformls = {
					settings = {
						terraform = {
							logLevel = "error",
							fileWatcher = false,
						},
					},
				},
				yamlls = {
					single_file_support = true,
				},
				intelephense = {},
				dockerls = {},
				docker_compose_language_service = {},
			}

			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers or {}),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- only override explicit keys found in servers table
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			--
			--
			--
			--    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			-- 	border = "rounded",
			-- 	max_width = 50,
			-- 	max_height = 10,
			-- 	focusable = true,
			-- 	focus = false,
			-- })
			--
			-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			-- 	border = "rounded",
			-- 	max_width = 50,
			-- 	max_height = 10,
			-- 	focusable = true,
			-- 	focus = false,
			-- })
			--
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- local on_attach = function(client, bufnr)
			-- 	-- autoformat on save is handled by conform
			--
			-- 	if client.server_capabilities.renameProvider then
			-- 		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, Opts("Rename Symbol"))
			-- 	end
			--
			-- 	if client.server_capabilities.definitionProvider then
			-- 		vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, Opts("Go To Definition"))
			-- 	end
			--
			-- 	if client.server_capabilities.codeActionProvider then
			-- 		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, Opts("Code Action"))
			-- 	end
			--
			-- 	if client.server_capabilities.hoverProvider then
			-- 		vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, Opts("Hover"))
			-- 	end
			--
			-- 	if client.server_capabilities.signatureHelp then
			-- 		vim.keymap.set("n", "<leader>ck", vim.lsp.buf.signature_help, Opts("Signature Help"))
			-- 	end
			--
			-- 	if client.server_capabilities.implementationProvider then
			-- 		vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, Opts("Go To Implementation"))
			-- 	end
			--
			-- 	if client.server_capabilities.typeDefinitionProvider then
			-- 		vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, Opts("Go To Type Definition"))
			-- 	end
			--
			-- 	if client.server_capabilities.referencesProvider then
			-- 		vim.keymap.set("n", "<leader>cR", vim.lsp.buf.references, Opts("Show References"))
			-- 	end
			--
			-- 	if client.server_capabilities.inlayHintProvider then
			-- 		vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			-- 	end
			--
			-- 	if client.server_capabilities.completionProvider then
			-- 		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			-- 	end
			-- end

			-- lspconfig.ansiblels.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	cmd = { "ansible-language-server", "--stdio" },
			-- 	filetypes = { "yaml.ansible" },
			-- 	root_dir = lspconfig.util.root_pattern("ansible.cfg", ".git", "playbooks/", "roles/", "inventories/"),
			-- })
			--
			-- lspconfig.jsonls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	cmd = { "vscode-json-language-server", "--stdio" },
			-- 	filetypes = { "json", "jsonc" },
			-- })
			--
			-- lspconfig.sqlls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	root_dir = lspconfig.util.root_pattern(".git", "init.sql", "schema.sql", "sqls.config.json"),
			-- 	cmd = { "sql-language-server", "up", "--method", "stdio" },
			-- 	filetypes = { "sql" },
			-- })
			--
			-- lspconfig.ts_ls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		preferences = {
			-- 			importModuleSpecifierPreference = "non-relative",
			-- 		},
			-- 	},
			-- 	filetypes = {
			-- 		"javascript",
			-- 		"typescript",
			-- 		"javascriptreact",
			-- 		"typescriptreact",
			-- 	},
			-- })
			--
			-- lspconfig.lua_ls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		Lua = {
			-- 			runtime = {
			-- 				version = "LuaJIT",
			-- 			},
			-- 			codelens = {
			-- 				enable = false,
			-- 			},
			-- 			hint = {
			-- 				enable = true,
			-- 				setType = false,
			-- 				paramType = true,
			-- 			},
			-- 			diagnostics = {
			-- 				globals = { "vim" },
			-- 			},
			-- 			workspace = {
			-- 				library = vim.api.nvim_get_runtime_file("", true),
			-- 				checkThirdParty = false, -- Optional: Disable third-party checking for a faster startup
			-- 			},
			-- 			telemetry = {
			-- 				enable = false, -- Do not send telemetry data containing a randomized but unique identifier
			-- 			},
			-- 		},
			-- 	},
			-- })
			--
			-- lspconfig.terraformls.setup({
			-- 	on_attach = function(client, bufnr)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>cT",
			-- 			":Telescope terraform_doc full_name=hashicorp/google<CR>",
			-- 			Opts("Terraform Google Docs")
			-- 		)
			-- 		on_attach(client, bufnr)
			-- 	end,
			-- 	capabilities = capabilities,
			-- 	cmd = { "terraform-ls", "serve" },
			-- 	filetypes = { "terraform", "hcl", "tf", "tfvars" },
			-- 	root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
			-- 	settings = {
			-- 		terraform = {
			-- 			logLevel = "error",
			-- 			fileWatcher = false,
			-- 		},
			-- 	},
			-- })
			--
			-- lspconfig.yamlls.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	filetypes = { "yaml" },
			-- 	cmd = { "yaml-language-server", "--stdio" },
			-- 	root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
			-- 	single_file_support = true,
			-- })
			--
			-- lspconfig.intelephense.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	cmd = { "intelephense", "--stdio" },
			-- 	filetypes = { "php" },
			-- 	root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
			-- })
			--
			-- lspconfig.dockerls.setup({
			-- 	settings = {
			-- 		docker = {
			-- 			languageserver = {
			-- 				formatter = {
			-- 					ignoreMultilineInstructions = true,
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
			--
			-- lspconfig.docker_compose_language_service.setup({})

			return opts
		end,
	},
}
