local k = require("config.utils").keymap

return {
	"RutaTang/quicknote.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	enabled = false,
	config = function()
		require("quicknote").setup({
			mode = "portable",
			sign = "N",
			filetype = "md",
			git_branch_recognizable = true,
		})
		require("telescope").load_extension("quicknote")
		k("n", "<C-q>ng", ":lua require('quicknote').NewNoteAtGlobal()<CR>", "New Note At Global")
		k("n", "<C-q>nn", ":lua require('quicknote').NewNoteAtCWD()<CR>", "New Note In CWD")
		k("n", "<C-q>n.", ":lua require('quicknote').NewNoteAtCurrentLine()<CR>", "New Note At Current Line")

		k("n", "<C-q>og", ":lua require('quicknote').OpenNoteAtGlobal()<CR>", "Open Note At Global")
		k("n", "<C-q>on", ":lua require('quicknote').OpenNoteAtCWD()<CR>", "Open Note In CWD")
		k("n", "<C-q>o.", ":lua require('quicknote').OpenNoteAtCurrentLine()<CR>", "Open Note At Current Line")

		k("n", "<C-q>dg", ":lua require('quicknote').DeleteNoteAtGlobal()<CR>", "Delete Note At Global")
		k("n", "<C-q>dn", ":lua require('quicknote').DeleteNoteAtCWD()<CR>", "Delete Note In CWD")
		k("n", "<C-q>d.", ":lua require('quicknote').DeleteNoteAtCurrentLine()<CR>", "Delete Note At Current Line")

		k("n", "<C-q>lh", ":lua require('quicknote').ListNotesForCWD()<CR>", "List Notes Here [CWD]")
		k("n", "<C-q>lg", ":lua require('quicknote').ListNotesForCWD()<CR>", "List Notes Global")

		k("n", "<C-q>t", ":lua require('quicknote').ToggleMode()<CR>", "Toggle Mode [Resident, Global]")
		k("n", "<C-t>q", ":lua require('quicknote').ToggleNoteSigns()<CR>", "Toggle Notes Signs")
	end,
}
