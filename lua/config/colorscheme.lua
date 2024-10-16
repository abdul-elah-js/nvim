local utils = require("config.utils")

local M = {}

M.name = "nightfox"
M.safe_name = utils.normalize_key(M.name)

M.set_name = function(name)
	M.name = name or ""
	M.safe_name = utils.normalize_key(M.name)
end

M.apply = function(colorscheme)
	vim.cmd("colorscheme " .. colorscheme)
end

M.change = function(colorscheme)
	M.set_name(colorscheme)
	M.apply(colorscheme)
	vim.notify("Colorscheme changed to " .. colorscheme)

	require("lazy").setup("plugins")
end

return M
