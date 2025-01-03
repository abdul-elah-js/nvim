return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	opts = function()
		local logo = [[
     ██████╗ ██╗  ██╗    ███████╗██╗   ██╗ ██████╗██╗  ██╗
    ██╔═══██╗██║  ██║    ██╔════╝██║   ██║██╔════╝██║ ██╔╝
   ██║   ██║███████║    █████╗  ██║   ██║██║     █████╔╝
   ██║   ██║██╔══██║    ██╔══╝  ██║   ██║██║     ██╔═██╗
    ╚██████╔╝██║  ██║    ██║     ╚██████╔╝╚██████╗██║  ██╗
     ╚═════╝ ╚═╝  ╚═╝    ╚═╝      ╚═════╝  ╚═════╝╚═╝  ╚═╝

       Another day to get through ..
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local projects_path = "/Users/abdulelah/Code"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          {
            action = function()
              vim.cmd('cd ' .. projects_path .. '/salesfine')
              require("oil").open_float('.')
            end,
            desc = " SalesFine (Cloud & Apps)",
            icon = "󰞵 ",
            key = "w"
          },
          {
            action = function()
              vim.cmd('cd ' .. projects_path .. '/solo')
              require("oil").open_float('.')
            end,
            desc = " Solo",
            icon = " ",
            key = "s"
          },
          {
            action = function()
              vim.cmd('cd /Users/abdulelah/.config/nvim/lua/')
              require("oil").open_float('.')
            end,
            desc = " Config",
            icon = "󰒓 ",
            key = "e"
          },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#c4a7e7" }) -- with rose-pine
		-- vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#7199EE" })

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
