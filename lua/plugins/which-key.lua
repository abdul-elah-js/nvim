return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "modern",
			layout = {
				spacing = 8,
			},
			spec = {},
		})

		wk.add({
			{ "<leader>f", group = "Find", icon = "  " },
			{ "<leader>f_", hidden = true },
			{ "<leader>c", group = "Code", icon = " 󰅭 " },
			{ "<leader>c_", hidden = true },
			{ "<leader>l", group = "Lsp", icon = "  " },
			{ "<leader>l_", hidden = true },
			{ "<C-t>", group = "Toggles", icon = "  " },
			{ "<leader>g", group = "Git", icon = "  " },
			{ "<leader>g_", hidden = true },
			{ "<leader>t", group = "Terminal", icon = "  " },
			{ "<leader>t_", hidden = true },
			{ "<leader>T", group = "Tabs", icon = " 󰓩 " },
			{ "<leader>T_", hidden = true },
			{ "<leader>q", group = "Quit", icon = " 󰩈 " },
			{ "<leader>q_", hidden = true },
			{ "<C-w>", group = "Windows", icon = "  " },
			{ "<leader>b", group = "Buffers", icon = "  " },
			{ "<leader>b_", hidden = true },
			{ "<leader>x", group = "Diagnostics & Trouble", icon = " 󰨮 " },
			{ "<leader>x_", hidden = true },
			{ "<leader>L", hidden = true, group = "Lazy", icon = " 󰒲 " },
			{ "<leader>e", hidden = true },
			{ '<leader>"', hidden = true },
			{ "<leader><space>", hidden = true },
			{ "<leader><C-/>", hidden = true },
			{ "<leader>/", hidden = true },
			{ "<leader>i", hidden = true },
			{ "<leader>o", hidden = true },
			{ "<leader>r", hidden = true },
			{ "<leader>d", hidden = true },
			{ "<leader>-", hidden = true },
		})
	end,
}
