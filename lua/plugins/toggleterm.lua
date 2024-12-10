local utils = require("config.utils")
local opts = utils.opts

return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Use for stable version
	lazy = false,
	config = function()
		local keymap = vim.keymap
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-/>]],
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

		Terminal = require("toggleterm.terminal").Terminal
		Terminals = {}

		local configurations = {
			[0] = function(count)
				return { direction = "float", count = count }
			end,
			[1] = function()
				return { direction = "float", count = 1, dir = utils.get_path() }
			end,
			[2] = function()
				return { direction = "horizontal", count = 2 }
			end,
			[3] = function()
				return { direction = "vertical", count = 3 }
			end,
		}

		local get_or_create_terminal = function(count)
			if not Terminals[count] then
				Terminals[count] = Terminal:new(utils.switch(configurations, 0, count))
			end
			return Terminals[count]
		end

		local _lazy_git = function()
			require("toggleterm.terminal").Terminal
				:new({
					cmd = "lazygit",
					dir = vim.fn.getcwd(),
					direction = "float",
					float_opts = {
						border = "double",
					},
				})
				:toggle()
		end

		keymap.set("n", "<C-/>", function()
			get_or_create_terminal(vim.v.count):toggle()
		end, opts("Toggle Terminal"))
		keymap.set("n", "<leader><C-/>", function()
			Terminal:new({ direction = "float", dir = utils.get_path() }):toggle()
		end, opts("Toggle Terminal (CWD)"))
		keymap.set("n", "<leader>lg", _lazy_git, opts("LazyGit"))

		local _load_terminal_keymaps = function()
			keymap.set("t", "<Escape>", "<C-\\><C-n>", opts("Escape Terminal Mode"))
			keymap.set("t", "<C-q>", "<C-\\><C-n>", opts("Escape Terminal Mode"))
			keymap.set("t", "<C-h>", "<C-\\><C-n>:wincmd h<CR>", opts("Left Pane"))
			keymap.set("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", opts("Bottom Pane"))
			keymap.set("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", opts("Upper Pane"))
			keymap.set("t", "<C-l>", "<C-\\><C-n>:wincmd l<CR>", opts("Right Pane"))
		end

		vim.api.nvim_create_autocmd("TermOpen", {
			group = vim.api.nvim_create_augroup("iTermKeymaps", { clear = true }),
			pattern = "term://*",
			callback = _load_terminal_keymaps,
		})
	end,
}
