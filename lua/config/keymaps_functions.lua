local M = {}

local o = vim.o
local inlay_hint = vim.lsp.inlay_hint
local diagnostic = vim.diagnostic
local g = require("gitsigns.config").config
local t = require("telescope.builtin")

---@param name string
---@param state? boolean
M.notify = function(name, state)
	if state ~= nil then
		vim.notify(name .. " is " .. (state and "On" or "Off"))
	else
		vim.notify(name)
	end
end

M.numbers = function()
	o.number = not o.number
	M.notify("number", o.number)
end

M.relative_numbers = function()
	o.relativenumber = not o.relativenumber
	M.notify("relative number", o.relativenumber)
end

M.wrap = function()
	o.wrap = not o.wrap
	M.notify("Text Wrap", o.wrap)
end

M.inlay_hint = function()
	inlay_hint.enable(not inlay_hint.is_enabled())
	M.notify("Inlay Hints", inlay_hint.is_enabled())
end

M.diagnostic = function()
	diagnostic.enable(not diagnostic.is_enabled())
	M.notify("diagnostics", diagnostic.is_enabled())
end

M.tscontext = function()
	vim.cmd("TSContextToggle")
	M.notify("Toggled Treesitter Context")
end

M.lsp_info = function()
	vim.cmd("LspInfo")
end

M.lsp_start = function()
	vim.cmd("LspStart")
	M.notify("Started LSP")
end

M.lsp_restart = function()
	vim.cmd("LspRestart")
	M.notify("Restarted LSP")
end

M.lsp_stop = function()
	vim.cmd("LspStop")
	M.notify("Stopped LSP")
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

M.gitsigns = function()
	vim.cmd("Gitsigns toggle_signs")
	M.notify("Git Signs", g.signcolumn)
end

M.inline_blame = function()
	vim.cmd("Gitsigns toggle_current_line_blame")
	M.notify("Inline Blame", g.current_line_blame)
end

M.ln = function()
	vim.cmd("Gitsigns toggle_linehl")
	M.notify("Line Highlight", g.linehl)
end

M.numhl = function()
	vim.cmd("Gitsigns toggle_numhl")
	M.notify("Number Highlight", g.numhl)
end

M.word_diff = function()
	vim.cmd("Gitsigns toggle_word_diff")
	M.notify("Word Diff", g.word_diff)
end

M.find_plugins = function()
	t.find_files({
		hidden = true,
		cwd = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/plugins",
	})
end

M.find_config = function()
	t.find_files({
		hidden = true,
		cwd = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/config",
	})
end

M.find_cwd = function()
	t.live_grep({
		hidden = true,
		cwd = require("config.utils").get_path() .. "/",
	})
end

M.find_core_plugins = function()
	t.live_grep({
		hidden = true,
		cwd = vim.fn.stdpath("data") .. "/",
		glob_pattern = "*.lua",
	})
end

M.find_files = function()
	t.find_files({ hidden = true })
end

M.find_files_in = function()
	vim.fn.input({ prompt = " in: ", completion = "file" }, function(input)
		if input then
			t.find_files({
				hidden = true,
				cwd = input,
			})
		end
	end)
end

M.live_grep = function()
	t.live_grep({ hidden = true })
end

M.live_grep_in = function()
	vim.fn.input({ prompt = "", completion = "file" }, function(input)
		if input then
			t.live_grep({
				hidden = true,
				cwd = input,
			})
		end
	end)
end

return M
