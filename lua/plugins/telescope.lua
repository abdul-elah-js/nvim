local utils = require("utils.telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local tf_doc_actions = require("telescope._extensions.terraform_doc.actions")
local tf_doc_opts = require("telescope._extensions.terraform_doc.config").opts

local search_attach_mappings = function()
  actions.select_default:replace(tf_doc_actions.doc_view(tf_doc_opts))
  return true
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  cmd = "Telescope",
  version = false,
  opts = function()
    return {
      extensions = {
        terraform_doc = {
          search_attach_mappings = search_attach_mappings,
          latest_provider_symbol = "  ",
        }
      },
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 0
          }
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.preview_scrolling_down,
            ["<C-k>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }
  end,
  keys = {
    { "<leader><space>", ":Telescope find_files<CR>",                                                  desc = "Find Files" },
    { "<leader>/",       ":Telescope live_grep<CR>",                                                   desc = "Live Grep" },
    { "<leader>fa",      function() builtin.find_files({ hidden = true, no_ignore = true }) end,       desc = "Find Files (all)" },
    { "<leader>fA",      function() builtin.live_grep({ hidden = true, no_ignore = true }) end,        desc = "Live Grep (all)" },
    { "<leader>fg",      builtin.git_files,                                                            desc = "Git Files" },
    { "<leader>fG",      builtin.git_stash,                                                            desc = "Git Stash " },
    { "<leader>fk",      ":Telescope keymaps<CR>",                                                     desc = "Keymaps" },
    { '<leader>f"',      ":Telescope registers<CR>",                                                   desc = "Registers" },
    { '<leader>f:',      ":Telescope commands<CR>",                                                    desc = "Commands" },
    { '<leader>fh',      ":Telescope highlights<CR>",                                                  desc = "Highlights" },
    { "<leader>fc",      function() builtin.find_files({ hidden = true, cwd = "~/.config/nvim" }) end, desc = "Config" },
    {
      "<leader>fi",
      function()
        vim.ui.input({ prompt = 'Directory to search: ' }, function(input)
          if input then utils.find_files({ cwd = input }) end
        end)
      end,
      desc = "Find Files In "
    },
    {
      "<leader>fI",
      function()
        vim.ui.input({ prompt = 'Directory to grep: ' }, function(input)
          if input then
            require('telescope.builtin').live_grep({ cwd = input })
          end
        end)
      end,
      desc = "Live Grep In"
    }
  }
}
