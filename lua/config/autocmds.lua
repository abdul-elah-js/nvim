local k = require("config.utils").keymap

local _load_terminal_keymaps = function()
	vim.bo.filetype = "toggleterm"
	vim.keymap.set("t", "<Escape>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })
	vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })
	vim.keymap.set("t", "<C-h>", "<C-\\><C-n>:wincmd h<CR>", { desc = "Left Pane" })
	vim.keymap.set("t", "<C-j>", "<C-\\><C-n>:wincmd j<CR>", { desc = "Bottom Pane" })
	vim.keymap.set("t", "<C-k>", "<C-\\><C-n>:wincmd k<CR>", { desc = "Upper Pane" })
	vim.keymap.set("t", "<C-l>", "<C-\\><C-n>:wincmd l<CR>", { desc = "Right Pane" })
end

-- AutoCMDs

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("iTermKeymaps", { clear = true }),
	pattern = "term://*",
	callback = _load_terminal_keymaps,
})
