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
	opts = function()
		local actions = require("telescope.actions")
		return {
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
						["<C-j>"] = actions.preview_scrolling_down,
						["<C-k>"] = actions.preview_scrolling_up,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
					},
					n = {
						["q"] = actions.close,
						["<C-c>"] = actions.close,
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-l>"] = actions.preview_scrolling_right,
						["<C-h>"] = actions.preview_scrolling_left,
					},
				},
			},
		}
	end,
	keys = {
		{
			"<leader><space>",
			function()
				require("telescope.builtin").find_files({ hidden = true })
			end,
			desc = "Find Files",
		},
		{ "<leader>/", ":Telescope live_grep<CR>", desc = "Live Grep" },
		{
			"<leader>fa",
			function()
				require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
			end,
			desc = "Find Files (all)",
		},
		{
			"<leader>fA",
			function()
				require("telescope.builtin").live_grep({ hidden = true, no_ignore = true })
			end,
			desc = "Live Grep (all)",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Git Files",
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").git_stash()
			end,
			desc = "Git Stash",
		},
		{ "<leader>fk", ":Telescope keymaps<CR>", desc = "Keymaps" },
		{ '<leader>f"', ":Telescope registers<CR>", desc = "Registers" },
		{ "<leader>f:", ":Telescope command_history<CR>", desc = "Commands" },
		{ "<leader>fh", ":Telescope highlights<CR>", desc = "Highlights" },
		{
			"<leader>fc",
			function()
				require("telescope.builtin").find_files({ hidden = true, cwd = "~/.config/nvim/lua/config" })
			end,
			desc = "Config",
		},
		{
			"<leader>fp",
			function()
				require("telescope.builtin").find_files({ hidden = true, cwd = "~/.config/nvim/lua/plugins" })
			end,
			desc = "Plugins",
		},
		{
			"<leader>fr",
			":Telescope resume<CR>",
			desc = "Resume",
		},
		{
			"<leader>fI",
			function()
				vim.ui.input({ prompt = "Directory to grep: " }, function(input)
					if input then
						require("telescope.builtin").live_grep({ cwd = input })
					end
				end)
			end,
			desc = "Live Grep In",
		},
	},
}
