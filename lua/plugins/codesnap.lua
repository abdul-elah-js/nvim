local path = "~/Pictures"
return {
	"mistricky/codesnap.nvim",
	build = "make",
	keys = {
		{ "<leader>sc", ":CodeSnap<CR>", mode = "x", desc = "Save selected code snapshot into clipboard" },
		{ "<leader>ss", ":CodeSnapSave<CR>", mode = "x", desc = "Save selected code snapshot in " .. path },
	},
	opts = {
		save_path = path,
		has_breadcrumps = true,
		bg_theme = "bamboo",
	},
}
