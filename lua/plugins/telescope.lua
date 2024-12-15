local opts = require("config.utils").opts

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	cmd = "Telescope",
	version = false,
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local keymap = vim.keymap

		keymap.set("n", "<leader><space>", function()
			builtin.find_files({ hidden = true })
		end, opts("Find Files"))
		keymap.set("n", "<leader>/", function()
			builtin.live_grep({ hidden = true })
		end, opts("Live Grep"))
		keymap.set({ "n" }, "<leader>fg", function()
			require("telescope.builtin").git_files()
		end, opts("Git Files"))
		keymap.set({ "n" }, "<leader>fG", function()
			require("telescope.builtin").git_stash()
		end, opts("Git Stash"))
		keymap.set({ "n" }, "<leader>fk", ":Telescope keymaps<CR>", opts("Keymaps"))
		keymap.set({ "n" }, '<leader>f"', ":Telescope registers<CR>", opts("Registers"))
		keymap.set({ "n" }, "<leader>f:", ":Telescope command_history<CR>", opts("Commands"))
		keymap.set({ "n" }, "<leader>fh", ":Telescope highlights<CR>", opts("Highlights"))
		keymap.set({ "n" }, "<leader>fc", function()
			require("telescope.builtin").find_files({ hidden = true, cwd = "~/.config/nvim/lua/config" })
		end, opts("Config"))
		keymap.set({ "n" }, "<leader>fp", function()
			require("telescope.builtin").find_files({ hidden = true, cwd = "~/.config/nvim/lua/plugins" })
		end, opts("Plugins"))
		keymap.set({ "n" }, "<leader>fr", ":Telescope resume<CR>", opts("Resume"))

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					".git/",
				},
				layout_config = {
					horizontal = {
						preview_cutoff = 0,
					},
				},
				mappings = {
					i = {
						["<C-c>"] = actions.close,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
					},
					n = {
						["q"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
					},
				},
			},
			extensions = {
				quicknote = {
					defaultScope = "CWD",
				},
			},
		})
	end,
}
