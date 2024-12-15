return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "modern",
			delay = function(ctx)
				if ctx.mode ~= "n" then
					return 500
				end
				return 0
			end,
			layout = {
				spacing = 8,
			},
			spec = {},
		})

		wk.add({
			{ "<leader>f", group = "Find", icon = " " },
			{ "<leader>f_", hidden = true },
			{ "<leader>c", group = "Code", icon = " 󰅭" },
			{ "<leader>c_", hidden = true },
			{ "<leader>l", group = "Lsp", icon = " " },
			{ "<leader>l_", hidden = true },
			{ "<leader>g", group = "Git", icon = " " },
			{ "<leader>g_", hidden = true },
			{ "<leader>t", group = "Terminal", icon = "  " },
			{ "<leader>t_", hidden = true },
			{ "<leader>T", group = "Tabs", icon = " 󰓩" },
			{ "<leader>T_", hidden = true },
			{ "<leader>q", group = "Quit", icon = " 󰩈" },
			{ "<leader>q_", hidden = true },
			{ "<leader>b", group = "Buffers", icon = " " },
			{ "<leader>b_", hidden = true },
			{ "<leader>x", group = "Diagnostics & Trouble", icon = " 󰨮" },
			{ "<leader>x_", hidden = true },
			{ "<leader>n", group = "Notifications", icon = " 󰎟" },
			{ "<leader>n_", hidden = true },
			{ "<leader>L", group = "Lazy", icon = " 󰒲" },
			{ "<leader>L_", hidden = true },

			{ "<C-q>n", group = "New Note" },
			{ "<C-q>o", group = "Open Note" },
			{ "<C-q>l", group = "List Note" },
			{ "<C-q>d", group = "Delete Note" },

			{ '<leader>"', hidden = true }, -- Blackhole register
			{ "<leader><space>", hidden = true }, -- Telescope find_files
			{ "<leader>r", hidden = true }, -- Reload configurations
			{ "<leader>/", hidden = true }, -- Telescope live_grep
			{ "<leader>D", hidden = true }, -- Dismiss notifications
			{ "<leader>d", hidden = true }, -- Delete without copy

			{
				mode = { "v", "x" },
				{ "<leader>s", group = "Screenshot", icon = " 󰨵 " },
				{ "<leader>s_", hidden = true },
			},
		})
	end,
}
