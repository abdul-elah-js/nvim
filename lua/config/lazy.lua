-- prepend mvim to the runtime
vim.opt.rtp:prepend("~/.config/nvim")

-- ensure lazy is installed first
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("config.utils")
require("config.options")
require("config.filetypes")
require("config.autocmds")
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = {
		missing = true,
		colorscheme = {
			"rose-pine",
			"tokyodark",
		},
	},
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false },
	ui = { border = "rounded" },
})
require("config.user_commands")
require("config.keymaps")
