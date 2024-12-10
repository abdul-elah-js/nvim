local Opts = require("config.utils").opts
return {
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
					print("how often am I running")
					-- Keymaps
					local keymap = vim.keymap
					keymap.set("n", "gd", builtin.lsp_definitions, Opts("Goto Definition"))
					keymap.set("n", "gr", builtin.lsp_references, Opts("Goto References"))
					keymap.set("n", "gI", builtin.lsp_implementations, Opts("Goto Implementation"))
					keymap.set("n", "<leader>cD", builtin.lsp_type_definitions, Opts("Type Definition"))
					keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, Opts("Document Symbols"))
					keymap.set("n", "<leader>cS", builtin.lsp_dynamic_workspace_symbols, Opts("Workspace Symbols"))
					keymap.set("n", "<leader>cr", vim.lsp.buf.rename, Opts("Rename"))
					keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, Opts("Code Action"))
					keymap.set("n", "K", vim.lsp.buf.hover, Opts("Hover Documentation"))
					keymap.set("n", "gD", vim.lsp.buf.declaration, Opts("Goto Declaration"))
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
			return opts
		end,
	},
}
