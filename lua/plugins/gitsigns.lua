return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			watch_gitdir = {
				follow_files = true,
			},
		})
	end,
}
