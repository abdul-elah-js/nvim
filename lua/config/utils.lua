local M = {}

M.default = function(value, default)
	if value == nil then
		return default
	end
	return value
end

--- Keymap opts and additional data
---@param desc any
---@param opts? { noremap: boolean, silent: boolean, buffer: number }
---@return table
M.opts = function(desc, opts)
	opts = opts or {}
	return vim.tbl_deep_extend(
		"force",
		{ noremap = M.default(opts.noremap, true), silent = M.default(opts.silent, true), desc = desc },
		opts.buffer and { buffer = opts.buffer } or {}
	)
end

-- TODO: add support for multiple lhs
--
---Keymap helper method
---@param modes ("n" | "v" | "c" | "i" | "t" | "x")[] | ("n" | "v" | "c" | "i" | "t" | "x")
---@param lhs string
---@param rhs string | function
---@param opts? vim.keymap.set.Opts | string
---@param notify? string
M.keymap = function(modes, lhs, rhs, opts, notify)
	modes = modes or { "n" }
	opts = type(opts) == "string" and { desc = " " .. opts, noremap = true, silent = true }
		or vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts)
	vim.keymap.set(modes, lhs, rhs, opts)

	if notify then
		vim.notify(notify)
	end
end

M.require = function(path)
	local status, module = pcall(require, path)
	if status then
		return module
	else
		return { colorscheme_overrides = {} }
	end
end

---Merge two tables
---@param base table
---@param overrides table
---@param behavior ("error" | "force" | "keep")
---@return table
M.merge = function(base, overrides, behavior)
	return vim.tbl_deep_extend(behavior or "force", {}, base, overrides)
end

M.get_path = function()
	local buffer_path = vim.api.nvim_buf_get_name(0)
	return buffer_path ~= "" and vim.fn.fnamemodify(buffer_path, ":p:h") or vim.fn.getcwd()
end

M.is_floating_window_open = function()
	print("I am called!")
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		vim.notify(vim.inspect(config))
		if config.relative ~= "" then
			return true
		end
	end
	return false
end

M.has_lsp_attached = function()
	return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil -- 0 refers to the current buffer
end

M.tbl_stringify = function(tbl, indent)
	indent = indent or 0
	local result = {}
	local padding = string.rep("  ", indent)

	for key, value in pairs(tbl) do
		local formatted_key = type(key) == "string" and ('"' .. key .. '"') or key
		if type(value) == "table" then
			table.insert(result, padding .. formatted_key .. " = " .. tbl_stringify(value, indent + 1))
		else
			local formatted_value = type(value) == "string" and ("" .. value .. "") or tostring(value)
			table.insert(result, padding .. formatted_key .. " = " .. formatted_value)
		end
	end
	return "{\n" .. table.concat(result, ",\n") .. "\n" .. padding .. "}"
end

---functional switch statement
---@param opts { [string | number]: function }
---@param default string | number
---@param selected string | number
---@return unknown
M.switch = function(opts, default, selected)
	if opts[selected] then
		return opts[selected]()
	else
		return opts[default](selected)
	end
end

return M
