local utils = require("config.utils")

local colorscheme = require("config.colorscheme").safe_name
local theme_config = utils.require("config.themes." .. colorscheme .. ".bufferline")

return {
	"akinsho/bufferline.nvim",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>bd", ":Bdelete<CR>", desc = "Delete Buffer" },
		{ "<leader>bp", ":BufferLineTogglePin<CR>", desc = "Pin/Unpin Buffer" },
		{ "<Tab>", ":BufferLineCycleNext<CR>", desc = "Next Buffer" },
		{ "<S-Tab>", ":BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
		{ "<C-Tab>", ":BufferLineMoveNext<CR>", desc = "Move Next" },
		{ "<C-S-Tab>", ":BufferLineMovePrev<CR>", desc = "Move Prev" },
		{ "<leader>bo", ":BufferLineCloseOthers<CR>", desc = "Delete Others" },
		{ "<leader>br", ":BufferLineCloseRight<CR>", desc = "Delete Right" },
		{ "<leader>bl", ":BufferLineCloseLeft<CR>", desc = "Delete Left" },
		{ "<leader>b0", ":BufferLineGoTo -1<CR>", desc = "Focus Last Buffer" },
		{ "<leader>b1", ":BufferLineGoTo 1<CR>", desc = "Focus First Buffer" },
	},
	config = function()
		require("bufferline").setup(utils.merge({
			options = {
				groups = {
					items = {
						require("bufferline.groups").builtin.pinned:with({ icon = "" }),
					},
				},
				mode = "buffers",
				-- style_preset = bufferline.style_preset.default,
				color_icons = true,
				close_icon = "",
				modified_icon = "●",
				show_buffer_icons = true,
				show_duplicate_prefix = true,
				separator_style = "thin",
				diagnostics = "nvim_lsp",
				indicator = {
					style = "icon",
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = false,
						padding = 2,
					},
				},
				diagnostics_indicator = function(count) -- diagnostics format
					return " " .. count
				end,
				-- exclude some buffer and file types
				custom_filter = function(buf_number)
					local buftype = vim.api.nvim_buf_get_option(buf_number, "buftype")
					local filetype = vim.api.nvim_buf_get_option(buf_number, "filetype")

					-- exclude list
					local excluded_filetypes = {
						["terminal"] = true,
						["TelescopePrompt"] = true,
						["NvimTree"] = true,
						["sagaoutline"] = true,
						["sagafinder"] = true,
						["starter"] = true,
					}

					local excluded_buftypes = {
						["nofile"] = true,
						["terminal"] = true,
					}

					return not excluded_buftypes[buftype] and not excluded_filetypes[filetype]
				end,
			},
		}, { options = theme_config.colorscheme_overrides }))
	end,
}
