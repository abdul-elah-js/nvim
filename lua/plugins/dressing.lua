return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			input = {
				enabled = true,
				title_pos = "center",
				max_width = { 70, 0.7 },
				min_width = { 30, 0.3 },
				relative = "editor",
			},
			mappings = {
				n = {
					["q"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<C-p>"] = "HistoryPrev",
					["<C-n>"] = "HistoryNext",
				},
			},
		})
	end,
}
