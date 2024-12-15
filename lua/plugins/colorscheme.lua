return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		config = function()
			require("tokyodark").setup({
				transparent_background = true,
				custom_highlights = function(_, p)
					return {
						Float = { bg = "NONE" },
						NormalFloat = { bg = "NONE" },
						Directory = { bg = "NONE" },
						WhichKey = { fg = p.red, underline = false },
						WhichKeyIcon = { fg = p.red, underline = false },
						WhichKeyGroup = { fg = p.blue },
						Function = { fg = p.blue },
					}
				end,
			})
			vim.cmd("colorscheme " .. "tokyodark")
		end,
	},
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	opts = {
	-- 		transparent = true,
	-- 	},
	-- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				styles = {
					transparency = true,
				},
				highlight_groups = {
					Comment = { bg = "NONE", fg = "subtle" },
					Cursor = { fg = "rose", bg = "rose" },
					Visual = { fg = "#e0def4", bg = "#524f67" },
					VisualNOS = { fg = "#e0def4", bg = "#524f67" },
					TelescopeBorder = { fg = "highlight_high", bg = "none" },
					TelescopeNormal = { bg = "none" },
					TelescopeResultsNormal = { fg = "subtle", bg = "none" },
					TelescopeSelection = { fg = "text", bg = "highlight_high" },
					TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
				},
			})
			vim.cmd([[colorscheme rose-pine]])
		end,
	},

	-- {
	-- 	"tiagovla/tokyodark.nvim",
	-- 	opts = {
	-- 		transparent_background = true,
	-- 	},
	-- },
	--
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "moon",
	-- 			transparent = true,
	-- 		})
	-- 		-- vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	--
	-- {
	-- 	"catppuccin/nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	name = "catppuccin",
	-- },
	--
	-- {
	-- 	"diegoulloao/neofusion.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		terminal_colors = true,
	-- 		undercurl = true,
	-- 		underline = true,
	-- 		bold = true,
	-- 		italic = {
	-- 			strings = true,
	-- 			emphasis = true,
	-- 			comments = true,
	-- 			operators = false,
	-- 			folds = true,
	-- 		},
	-- 		strikethrough = true,
	-- 		invert_selection = false,
	-- 		invert_signs = false,
	-- 		invert_tabline = false,
	-- 		invert_intend_guides = false,
	-- 		inverse = true,
	-- 		palette_overrides = {},
	-- 		overrides = {},
	-- 		dim_inactive = true,
	-- 		transparent_mode = true,
	-- 	},
	-- },
	--
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- },
	--
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	version = false,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "medium",
	-- 			transparent_background_level = 2,
	-- 		})
	-- 	end,
	-- },
	--
}
