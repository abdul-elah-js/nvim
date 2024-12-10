local M = {}

---parse cmds by removing the colon or the <cmd> prefix
---@param cmd any
---@return unknown
M.parse_cmd = function(cmd)
	if cmd:sub(1, 1) == ":" then
		return cmd:sub(2)
	elseif string.lower(cmd:sub(1, 5)) == "<cmd>" then
		return cmd:sub(6)
	end
	return cmd
end

---Toggle settings on/off
---@param name? string
---@param current_state? any
---@param action? string | fun(new_state: any): nil
M.toggle = function(name, current_state, action)
	local new_state
	if current_state ~= nil then
		new_state = not current_state
	end
	if action and type(action) == "function" then
		action(new_state)
	elseif type(action) == "string" then
		vim.cmd(M.parse_cmd(action))
	else
		current_state = new_state
	end
	if name ~= nil then
		vim.notify(name .. " is " .. tostring(new_state))
	end
end

M.default = function(value, default)
	if value == nil then
		return default
	end
	return value
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

--- Keymap opts and additional data
---@param desc any
---@param opts? { notification?: string, noremap?: boolean, silent?: boolean, buffer: number }
---@return table
M.opts = function(desc, opts)
	if not opts then
		opts = {}
	end
	if opts.notification then
		vim.notify(opts.notification)
	end
	local resp = { noremap = M.default(opts.noremap, true), silent = M.default(opts.silent, true), desc = desc }
	if opts.buffer then
		resp["buffer"] = opts.buffer
	end
	return resp
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

M.get_path = function()
	local buffer_path = vim.api.nvim_buf_get_name(0)
	local dir = buffer_path ~= "" and vim.fn.fnamemodify(buffer_path, ":p:h") or vim.fn.getcwd()
	return dir
end

return M
