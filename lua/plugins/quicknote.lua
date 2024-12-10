local opts = require("config.utils").opts

return {
	"RutaTang/quicknote.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("quicknote").setup({
			mode = "portable",
			sign = "N",
			filetype = "md",
			git_branch_recognizable = true,
		})
		vim.keymap.set("n", "<leader>nn", ":lua require('quicknote').NewNoteAtCWD()<CR>", opts("New Note in CWD"))
		vim.keymap.set("n", "<leader>ne", ":lua require('quicknote').OpenNoteAtCWD()<CR>", opts("Open Note in CWD"))
		vim.keymap.set("n", "<leader>nl", ":lua require('quicknote').ListNotesForCWD()<CR>", opts("List Notes in CWD"))
		vim.keymap.set("n", "<leader>on", ":lua require('quicknote').ToggleNoteSigns()<CR>", opts("Toggle Notes Signs"))
	end,
}
