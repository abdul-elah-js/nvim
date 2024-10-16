return {
	"rcarriga/nvim-notify",
	enabled = true,
	opts = function()
		vim.notify = require("notify")
		require("telescope").load_extension("notify")
		return {
			background_colour = "#000000",
			render = "minimal",
			stages = "static",
			minimum_width = 18,
		}
	end,
}
