local k = require("config.utils").keymap
return {
	"roodolv/markdown-toggle.nvim",
	enabled = false,
	ft = { "markdown", "markdown.mdx" },
	config = function()
		local markdown_toggle = require("markdown-toggle")
		markdown_toggle.setup({
			use_default_keymaps = false,
			filetypes = { "markdown", "markdown.mdx" },
			list_table = { "-", "+", "*", "=" },
			cycle_list_table = true,
			enable_blankhead_skip = true,
			enable_unmarked_only = true,
			enable_inner_indent = true,
			enable_auto_samestate = true,
			box_table = { "x", "~", "!", ">" },
			cycle_box_table = true,
			heading_table = { "#", "##", "###", "####", "#####" },
			list_before_box = true,
			enable_autolist = true,
			enable_dot_repeat = true,
		})

		k({ "n", "i" }, "<C-x>", markdown_toggle.checkbox_cycle, "Toggle Checkbox")
	end,
}
