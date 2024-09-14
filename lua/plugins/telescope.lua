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
    {
      "<leader>/",
      function()
        utils.live_grep({ hidden = true, no_ignore = true })
      end,
      desc = "Live Grep (Root Dir)"
    },
    {
      "<leader>?",
      function()
        local cwd = vim.fn.input("Start searching from: ")
        utils.live_grep({ cwd = cwd, hidden = true, no_ignore = true })
      end,
      desc = "Live Grep (CWD)"
    },
    {
      "<leader>ff",
      function()
        utils.find_files({ hidden = true })
      end,
      desc = "Find Files (Root Dir)"
    },
    {
      "<leader><space>",
      function()
        utils.find_files({ hidden = true })
      end,
      desc = "Find Files (Root Dir)"
    },

    {
      "<leader>fF",
      function()
        local cwd = vim.fn.input("Start searching from:")
        utils.find_files({ cwd = cwd, hidden = true })
      end,
      desc = "Find Files (CWD)"
    },
    {
      "<leader>fg",
      function()
        utils.git_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find Git Files"
    },
    {
      "<leader>fG",
      function()
        local cwd = vim.fn.input("Start searching from: ")
        utils.git_files({ cwd = cwd, hidden = true, no_ignore = true })
      end,
      desc = "Find Git Files (CWD)"
    },
    {
      "<leader>fs",
      function()
        local path = vim.fn.input("Path: ")
        utils.find_files({ cwd = path, hidden = true, no_ignore = true })
      end,
      desc = "Search In Path"
    },
    {
      "<leader>fc",
      function()
        utils.find_files({ cwd = "~/.config/nvim/", hidden = true, ignored = true })
      end,
      desc = "Find Config"
    },
    {
      "<leader>f~",
      function()
        local cwd = vim.fn.input("Search in: ")
        utils.find_files({ cwd = cwd, hidden = true, ignored = true })
      end,
      desc = "Find Files In "
    },
    {
      "<leader>fw",
      function()
        utils.live_grep()
      end,
      desc = "Live Grep (Root Dir)"
    },
    {
      "<leader>fW",
      function()
        local cwd = vim.fn.input("Start searching from:")
        utils.live_grep({ cwd = cwd })
      end,
      desc = "Live Grep (CWD)"
    },
    { "<leader>fk", builtin.keymaps,         desc = "Find Keymaps" },
    { "<leader>f:", builtin.command_history, desc = "Find Command History" },
    { "<leader>fo", builtin.vim_options,     desc = "Find Config" },
    { '<leader>f"', builtin.registers,       desc = "Find Register" },
    { "<leader>fN", builtin.notify,          desc = "Find Notifications" },
    { "<leader>fr", builtin.resume,          desc = "Resume Picker" },
  },
}
