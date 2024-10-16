local utils = require("config.utils")

local colorscheme = require("config.colorscheme").safe_name
local theme_config = utils.require("config.themes." .. colorscheme .. ".toggleterm")

return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Use for stable version
	lazy = false,
	keys = {
		{
			"<C-_>",
			":ToggleTerm direction=float<CR>",
			mode = { "n", "x" },
			desc = "Toggle Terminal",
		},
		{
			"<C-/>",
			":ToggleTerm direction=float<CR>",
			mode = { "n", "x" },
			desc = "Toggle Terminal",
		},
		{
			"<C-_>",
			"<C-\\><C-n>:ToggleTerm<CR>",
			mode = "t",
			desc = "Toggle Terminal",
		},
		{
			"<C-/>",
			"<C-\\><C-n>:ToggleTerm<CR>",
			mode = "t",
			desc = "Toggle Terminal",
		},
		{
			"<C-q>",
			"<C-\\><C-n>",
			mode = "t",
			desc = "Toggle Terminal",
		},
	},
	config = function()
		require("toggleterm").setup(utils.merge({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-_>]],
			shade_terminals = false,
			start_in_insert = true,
			direction = "float",
			persist_mode = false,
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = false,
			autochdir = false,
			float_opts = {
				border = "curved",
				winblend = 0,
			},
		}, theme_config.colorscheme_overrides))
	end,
}
