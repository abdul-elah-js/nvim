return {
	"saghen/blink.cmp",
	enabled = true,
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = { "accept", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			-- cmdline = {},
		},
		completion = {
			menu = {
				auto_show = true,
				enabled = true,
				min_width = 15,
				max_height = 10,
				winblend = 0,
				scrolloff = 2,
				scrollbar = true,
				border = "single",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
			documentation = {
				window = {
					border = "single",
					winblend = 0,
				},
				auto_show = true,
				auto_show_delay_ms = 400,
			},
			ghost_text = { enabled = true },
			keyword = { range = "full" },
			trigger = { show_on_keyword = true },
			accept = { auto_brackets = { enabled = true } },
			list = {
				selection = "auto_insert",
				cycle = { from_bottom = true, from_top = true },
			},
		},
		signature = {
			window = { border = "single" },
		},
	},
	opts_extend = { "sources.default" },
}
