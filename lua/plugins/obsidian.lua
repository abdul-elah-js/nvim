return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	cmd = {
		"ObsidianNew",
		"ObsidianOpen",
		"ObsidianDailies",
		"ObsidianTomorrow",
		"ObsidianYesterday",
		"ObsidianTemplate",
		"ObsidianNewFromTemplate",
	},
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "work",
				path = "~/vaults/work",
			},
		},

		notes_subdir = "notes",
		log_level = vim.log.levels.INFO,

		daily_notes = {
			folder = "dailies",
			default_tags = { "dailies" },
			date_format = "%A %H:%M:%S %b %d %Y",
			time_format = "%H:%M",
			template = "work.md",
		},
		templates = {
			substitutions = {
				today = function()
					return os.date("%A %b %d %Y", os.time())
				end,
				yesterday = function()
					return os.date("%A %b %d %Y", os.time() - 86400)
				end,
				tomorrow = function()
					return os.date("%A %b %d %Y", os.time() + 86400)
				end,
			},
			folder = "templates",
			date_format = "%A %H:%M:%S %b %d %Y",
			time_format = "%H:%M",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<C-t>"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			["<CR>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		note_id_func = function(title)
			local suffix = ""
			if suffix ~= nil then
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return suffix .. "-" .. tostring(os.date("%A %H:%M:%S %b %d %Y"))
		end,
		ui = {
			enable = true, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			max_file_length = 5000, -- disable UI features for files with more than this many lines
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				-- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
				-- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				-- ["!"] = { char = "", hl_group = "ObsidianImportant" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				ObsidianImportant = { bold = true, fg = "#d73128" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},
		picker = {
			name = "telescope.nvim",
			note_mappings = {
				new = "<C-n>",
				insert_link = "<C-l>",
			},
			tag_mappings = {
				tag_note = "<C-x>",
				insert_tag = "<C-l>",
			},
		},
	},
	keys = {
		{ "<leader>oo", ":ObsidianOpen<CR>", desc = "Open" },
		{ "<leader>on", ":ObsidianNew <Left>", desc = "New" },
		{ "<leader>ox", ":ObsidianFollowLink hsplit<CR>", desc = "Open Horizontal" },
		{ "<leader>ov", ":ObsidianFollowLink vsplit<CR>", desc = "Open Vertical" },
		{ "<leader>oy", ":ObsidianYesterday<CR> <BAR> :ObsidianTemplate yesterday", desc = "Yesterday" },
		{ "<leader>ot", ":ObsidianTomorrow<CR> <BAR> :ObsidianTemplate tomorrow", desc = "Tomorrow" },
		{ "<leader>od", ":ObsidianDailies<CR>", desc = "Dailies" },
		{ "<leader>oc", ":ObsidianNewFromTemplate <Left>", desc = "From Template" },
	},
}
