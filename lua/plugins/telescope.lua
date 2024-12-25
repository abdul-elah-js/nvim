local k = require("config.utils").keymap
local k_fn = require("config.keymaps_functions")

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
		local b = require("telescope.builtin")
		local actions = require("telescope.actions")

		k("n", "<leader><space>", k_fn.find_files, "Find Files")
		k("n", "<leader>/", k_fn.live_grep, "Live Grep")
		k("n", "<leader>fi", k_fn.find_files_in, "Find Files In")
		k("n", "<leader>fw", k_fn.live_grep_in, "Find Files In")
		k("n", "<leader>fc", k_fn.find_config, "Config")
		k("n", "<leader>fp", k_fn.find_plugins, "Plugins")
		k("n", "<leader>fP", k_fn.find_core_plugins, "Core Config")
		k("n", "<leader>f.", k_fn.find_cwd, "Live Grep [CWD]")
		k("n", "<leader>fg", b.git_files, "Git Files")
		k("n", "<leader>fG", b.git_stash, "Git Stash")
		k("n", "<leader>fH", b.help_tags, "Help Tags")
		k("n", "<leader>fm", b.man_pages, "Help Tags")
		k("n", "<leader>fk", b.keymaps, "Keymaps")
		k("n", '<leader>f"', b.registers, "Registers")
		k("n", "<leader>f:", b.command_history, "Commands")
		k("n", "<leader>fh", b.highlights, "Highlights")
		k("n", "<leader>fr", b.resume, "Resume")

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
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
	end,
}
