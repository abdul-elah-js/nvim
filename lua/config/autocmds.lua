vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("iTermType", { clear = true }),
	pattern = "term://*",
	callback = function()
		vim.bo.filetype = "toggleterm"
	end,
})
