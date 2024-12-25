return {
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		dependencies = {
			-- Sources for nvim-cmp
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions
			"hrsh7th/cmp-cmdline", -- Command-line completions
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"L3MON4D3/LuaSnip", -- Snippet engine
			"rafamadriz/friendly-snippets", -- A collection of useful snippets
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Load snippet support
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- Use LuaSnip for snippets
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Keybindings for completion
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Navigate to previous item
					["<C-n>"] = cmp.mapping.select_next_item(), -- Navigate to next item
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
					["<C-e>"] = cmp.mapping.abort(), -- Close the completion menu
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						entry_filter = function(entry) -- remove long text w no meaning
							local text = entry:get_insert_text()
							for seq in text:gmatch("[^%s]+") do
								if #seq >= 20 then
									return false
								end
								return true
							end
						end,
					}, -- LSP completion source
					{ name = "luasnip" }, -- Snippet completion source
					{ name = "buffer" }, -- Buffer completion source
					{ name = "path" }, -- Path completion source
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = require("lspkind").symbol_map[vim_item.kind] or vim_item.kind
						vim_item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							path = "[Path]",
						})[entry.source.name]
						-- print("Source is " .. entry.source.name) # Debug
						return vim_item
					end,
				},
			})

			-- Setup for cmdline
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
					["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
				}),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "default",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
}
