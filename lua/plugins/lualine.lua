local utils = require("config.utils")

local colorscheme = require("config.colorscheme").safe_name
local theme_config = utils.require("config.themes." .. colorscheme .. ".lualine")

return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		return utils.merge({
			options = {
				icons_enabled = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 2, right = 0 },
						color = "_lualine_c_filetype",
					},
					-- filename
					{
						"filename",
						file_status = true, -- display file status (read only, modified)
						path = 1, -- 0: just name, 1: relative path, 2: absolute path, 3: absolute path with ~ as home directory
						symbols = {
							unnamed = "",
							readonly = "",
							modified = "",
						},
						padding = { left = 1 },
					},
				},
				lualine_x = {
					{
						"macro-recording",
						fmt = function()
							local rec_reg = vim.fn.reg_recording()
							if rec_reg == "" then
								return ""
							else
								return "Recording @" .. rec_reg
							end
						end,
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		}, theme_config.colorscheme_overrides)
	end,
}
