local utils = require("config.utils")
local k = utils.keymap

return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Use for stable version
	lazy = false,
	config = function()
		require("toggleterm").setup({
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
		})

		k("n", "<leader>g.", function()
			require("toggleterm.terminal").Terminal:new({ cmd = "lazygit" }):toggle()
		end, "LazyGit")

		for i = 1, 9 do
			k("n", "<C-t>" .. i, function()
				local dir = vim.fn.getcwd()
				if i % 2 == 0 then
					dir = utils.get_path()
				end
				vim.cmd(tostring(i) .. "ToggleTerm direction=float dir=" .. dir .. " name=Terminal#" .. tostring(i))
			end, "Toggle Terminal #" .. tostring(i))
		end
	end,
}
