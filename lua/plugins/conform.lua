local Opts = require("config.utils").opts
return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	event = { "BufWritePre" },
	lazy = false,
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				bash = { "bash-language-server" },
				php = { "php", "php-cs", "php-cs-fixer" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				vue = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				less = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
				jsonc = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				xml = { "xmlformat", "xmllint" },
				terraform = { "terraform_fmt" },
				tf = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
			formatters = {
				["php-cs-fixer"] = {
					command = "php-cs-fixer",
					args = {
						"fix",
						"--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
						"$FILENAME",
					},
					stdin = false,
				},
			},

			notify_on_error = true,
			notify_no_formatters = true,

			format_on_save = function(bufnr)
				local files_to_ignore = {}
				if vim.tbl_contains(files_to_ignore, vim.bo[bufnr].filetype) then
					return
				end

				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end

				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				if buf_name:match("/node_modules/") then
					return
				end

				return { timeout_ms = 500, lsp_format = "callback" }
			end,
		})
		vim.keymap.set("n", "<leader>cf", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 5000,
				async = true,
			})
		end, Opts("Format Buffer or Selection"))
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
