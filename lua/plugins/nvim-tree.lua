return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  keys = {
    { "<leader>e",  ":NvimTreeToggle<CR>", desc = "Toggle Tree" },
    { "<leader>Et", ":NvimTreeToggle<CR>", desc = "Toggle Tree" },
    { "<leader>Ef", ":NvimTreeFocus<CR>",  desc = "Focus Tree" },
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local opts = function(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true }
        end

        vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("set root"))
        vim.keymap.set("n", "I", api.node.show_info_popup, opts("show info"))
        vim.keymap.set("n", "/", api.node.run.cmd, opts("run command"))
        vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("parent close"))
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("open: vertical split"))
        vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("open: horizontal split"))
        vim.keymap.set("n", "a", api.fs.create, opts("create file or directory"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("open"))
        vim.keymap.set("n", "P", api.node.open.preview, opts("preview"))
        vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("open: no window picker"))
        vim.keymap.set("n", "r", api.fs.rename, opts("rename"))
        vim.keymap.set("n", "d", api.fs.remove, opts("delete"))
        vim.keymap.set("n", "p", api.fs.paste, opts("paste"))
        vim.keymap.set("n", "y", api.fs.copy.node, opts("copy"))
        vim.keymap.set("n", "Y", api.fs.copy.filename, opts("copy name"))
        vim.keymap.set("n", "Yf", api.fs.copy.absolute_path, opts("copy full path"))
        vim.keymap.set("n", "Yr", api.fs.copy.relative_path, opts("copy relative path"))
        vim.keymap.set("n", "x", api.fs.cut, opts("cut"))
        vim.keymap.set("n", "q", api.tree.close, opts("close"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("help"))
        vim.keymap.set("n", "[", api.node.navigate.parent, opts("parent directory"))
        vim.keymap.set("n", "s", api.node.run.system, opts("run system"))
        vim.keymap.set("n", "R", api.tree.reload, opts("refresh"))
        vim.keymap.set("n", "w", api.tree.collapse_all, opts("collapse"))
        vim.keymap.set("n", "e", api.tree.expand_all, opts("expand all"))
        vim.keymap.set("n", "h", api.tree.toggle_hidden_filter, opts("toggle filter: dotfiles"))
        vim.keymap.set("n", "i", api.tree.toggle_gitignore_filter, opts("toggle filter: git ignore"))
      end,
      renderer = {
        root_folder_label = ":t", -- hide root directory at the top
        indent_markers = {
          enable = true,      -- folder level guide
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          padding = " ",
          show = {
            hidden = true,
          },
          glyphs = {
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
            },
          },
        },
      },
      view = {
        width = function()
          local total_width = vim.fn.winwidth(0)
          local tree_width = math.floor(total_width * 0.45) -- Adjust 0.25 to your desired percentage (e.g., 25%)
          return tree_width
        end,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      actions = {
        open_file = {
          resize_window = false,
          quit_on_open = false,
          window_picker = {
            enable = false,
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      filters = {
        dotfiles = true,
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
    })
  end,
}
