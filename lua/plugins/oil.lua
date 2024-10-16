return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "echasnovski/mini.icons" },
	opts = {
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
			padding = 2,
			height = 0.8,
			width = 0.5,
			border = "rounded",
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
	},
}
