local k = require("config.utils").keymap
return {
	{
		"neovim/nvim-lspconfig", -- connect neovim to lsp server
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- lsp servers package manager
			{ "williamboman/mason-lspconfig" }, -- configurations bridge between mason and nvim-lspconfig
			{ "folke/neodev.nvim", opts = {} },
		},
		event = "VeryLazy",
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
			local builtin = require("telescope.builtin")
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("iLspAttach", { clear = true }),
				callback = function(event)
					-- Keymaps
					k("n", "gd", builtin.lsp_definitions, "To Definition")
					k("n", "gr", builtin.lsp_references, "To References")
					k("n", "gI", builtin.lsp_implementations, "To Implementation")
					k("n", "<leader>cD", builtin.lsp_type_definitions, "Type Definition")
					k("n", "<leader>cs", builtin.lsp_document_symbols, "Document Symbols")
					k("n", "<leader>cS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
					k("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
					k("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
					k("n", "K", vim.lsp.buf.hover, "Hover Documentation")
					k("n", "gD", vim.lsp.buf.declaration, "To Declaration")
					k("n", "<leader>xl", vim.diagnostic.setloclist, "Diagnostics List")
					k("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
					k("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
					k("n", "<leader>xo", vim.diagnostic.open_float, "Show Diagnostic")

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
						k("n", "<C-t>h", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Toggle Inlay Hints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities =
			-- vim.tbl_deep_extend("force", {}, capabilities, require("cmp_nvim_lsp").default_capabilities())

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
						-- server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.capabilities = vim.tbl_deep_extend(
							"force",
							{},
							require("blink.cmp").get_lsp_capabilities(
								server.capabilities or vim.lsp.protocol.make_client_capabilities()
							)
						)
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
			return opts
		end,
	},
}
