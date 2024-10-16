local M = {}

M.toggle_numbers = function()
	vim.o.number = not vim.o.number
	vim.notify("Toggled number")
end

M.toggle_relative_numbers = function()
	vim.o.relativenumber = not vim.o.relativenumber
	vim.notify("Toggled relative number")
end

M.toggle_wrap = function()
	vim.o.wrap = not vim.o.wrap
	vim.notify("Toggled wrap")
end

M.toggle_inlay_hints = function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	vim.notify("Toggled inlay hints")
end

M.toggle_diagnostics = function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
	vim.notify("Toggled diagnostics")
end

M.toggle_tscontext = function()
	vim.cmd("TSContextToggle")
	vim.notify("Toggled treesitter context")
end

M.lsp_info = function()
	vim.cmd("LspInfo")
end

M.lsp_start = function()
	vim.cmd("LspStart")
	vim.notify("Started LSP")
end

M.lsp_restart = function()
	vim.cmd("LspRestart")
	vim.notify("Restarted LSP")
end

M.lsp_stop = function()
	vim.cmd("LspStop")
	vim.notify("Stopped LSP")
end

M.lsp_install = function()
	vim.cmd("LspInstall")
end

M.lsp_uninstall = function()
	vim.cmd("LspUninstall")
end

M.lsp_log = function()
	vim.cmd("LspLog")
end

M.tscontext_toggle = function()
	vim.cmd("TSContextToggle")
	vim.notify("Treesitter context toggled")
end

M.toggle_gitsigns = function()
	vim.cmd("Gitsigns toggle_signs")
	vim.notify("Toggled Gitsigns")
end

M.toggle_git_blame = function()
	vim.cmd("Gitsigns toggle_current_line_blame")
	vim.notify("Toggled Gitsigns Line Blame")
end

M.toggle_git_line_highlight = function()
	vim.cmd("Gitsigns toggle_linehl")
	vim.notify("Toggled Gitsigns Line Highlight")
end

M.toggle_git_line_number_highlight = function()
	vim.cmd("Gitsigns toggle_numhl")
	vim.notify("Toggled Gitsigns Line Number Highlight")
end

M.toggle_git_word_diff = function()
	vim.cmd("Gitsigns toggle_word_diff")
	vim.notify("Toggled Gitsigns Word Diff")
end

M.toggle_virtual_text = function()
	local virtual_text = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not virtual_text })
	vim.notify("Toggled Virtual text")
end

return M
