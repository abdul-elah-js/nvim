return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,
			lsp_file_methods = {
				enabled = true,
				timeout = 1000,
				autosave_changes = true,
			},
			float = {
				padding = 4,
				max_width = 180,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			confirmation = {
				max_width = 0.6,
				min_width = 0.3,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			preview = {
				padding = 2,
				border = "rounded",
				update_on_cursor_moved = true,
			},
			ssh = {
				border = "rounded",
			},
			keymaps = {
				["?"] = "actions.show_help",
				["-"] = "actions.open_cwd",
				["<leader>-"] = "actions.parent",
				["<C-i>"] = "actions.toggle_hidden",
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
				["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
				["<C-b>"] = { "actions.preview_scroll_down", desc = "Scroll down" },
				["<C-f>"] = { "actions.preview_scroll_up", desc = "Scroll up" },
				["q"] = { "actions.close", desc = "Close" },
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
