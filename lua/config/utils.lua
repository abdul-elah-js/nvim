local M = {}

M.default = function(value, default)
	if value == nil then
		return default
	end
	return value
end

M.normalize_key = function(key)
	return string.gsub(key, "%-", "_")
end

M.copy_path = function(p)
	local path = vim.fn.expand(p or "%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied path to clipboard")
end

M.require = function(path)
	local status, module = pcall(require, path)
	if status then
		return module
	else
		return { colorscheme_overrides = {} }
	end
end

M.merge = function(base, overrides)
	return vim.tbl_deep_extend("force", {}, base, overrides)
end

M.is_floating_window_open = function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			return true
		end
	end
	return false
end

M.has_lsp_attached = function()
	return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil -- 0 refers to the current buffer
end

M.opts = function(desc, notification, noremap, silent)
	if notification then
		vim.notify(notification)
	end
	return { noremap = M.default(noremap, true), silent = M.default(silent, true), desc = desc }
end

return M
