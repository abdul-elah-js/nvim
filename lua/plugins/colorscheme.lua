return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {
			style = "moon",
		},
		-- config = function()
		-- end
	},

	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},

	{
		"diegoulloao/neofusion.nvim",
		priority = 1000,
		config = true,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		},
	},

	{
		"shaunsingh/nord.nvim",
	},

	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "medium",
				transparent_background_level = 2,
			})
		end,
	},
}
