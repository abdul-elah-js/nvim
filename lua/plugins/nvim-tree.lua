local WIDTH_RATIO = 0.3
local HEIGHT_RATIO = 0.8

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  enable = false,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  keys = {
    { "<leader>et", ":NvimTreeToggle<CR>",   desc = "Toggle" },
    { "<leader>ef", ":NvimTreeFocus<CR>",    desc = "Focus" },
    { "<leader>es", ":NvimTreeFindFile<CR>", desc = "Search" }
  },
  config = function()
    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local nvim_tree = require "nvim-tree"
        local api = require "nvim-tree.api"
        local view = require "nvim-tree.view"
        local opts = function(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true }
        end

        local augroup = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true });

        vim.api.nvim_create_autocmd({ "VimResized" }, {
          group = augroup,
          callback = function()
            if view.is_visible() then
              view.close()
              nvim_tree.open()
            end
          end
        })

        local edit_or_open = function()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            -- expand or collapse directory
            api.node.open.edit()
          else
            api.node.open.edit()
            api.tree.close()
          end
        end

        local open_vsplit = function()
          local node = api.tree.get_node_under_cursor()

          if node.nodes ~= nil then
            api.node.open.edit()
          else
            api.node.open.vertical()
          end

          api.tree.focus()
        end

        local git_add = function()
          local node = api.tree.get_node_under_cursor()
          local gs = node.git_status.file

          -- If the current node is a directory get children status
          if gs == nil then
            gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
          end

          -- If the file is untracked, unstaged or partially staged, we stage it
          if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
            vim.cmd("silent !git add " .. node.absolute_path)

            -- If the file is staged, we unstage
          elseif gs == "M " or gs == "A " then
            vim.cmd("silent !git restore --staged " .. node.absolute_path)
          end

          api.tree.reload()
        end

        vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("set root"))
        vim.keymap.set("n", "i", api.node.show_info_popup, opts("show info"))
        vim.keymap.set("n", "/", api.node.run.cmd, opts("run command"))
        vim.keymap.set("n", "<BS>", api.node.navigate.parent, opts("parent close"))
        vim.keymap.set("n", "L", open_vsplit, opts("open: vertical split"))
        vim.keymap.set("n", "l", edit_or_open, opts("edit or open"))
        vim.keymap.set("n", "H", api.tree.collapse_all, opts("collapse all"))
        vim.keymap.set("n", "h", api.tree.close, opts("open: vertical split"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("open: vertical split"))
        vim.keymap.set("n", "J", api.node.open.horizontal, opts("open: horizontal split"))
        vim.keymap.set("n", "a", api.fs.create, opts("create file or directory"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("open"))
        vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("open: no window picker"))
        vim.keymap.set("n", "P", api.node.open.preview, opts("preview"))
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
        vim.keymap.set("n", "S", api.node.run.system, opts("run system"))
        vim.keymap.set("n", "R", api.tree.reload, opts("refresh"))
        vim.keymap.set("n", "z", api.tree.collapse_all, opts("collapse"))
        vim.keymap.set("n", "e", api.tree.expand_all, opts("expand all"))
        vim.keymap.set("n", "<C-i>", api.tree.toggle_hidden_filter, opts("toggle filter: dotfiles"))
        vim.keymap.set("n", "<C-I>", api.tree.toggle_gitignore_filter, opts("toggle filter: git ignore"))
        vim.keymap.set("n", "ga", api.tree.toggle_gitignore_filter, opts("Git Add"))
      end,
      renderer = {
        root_folder_label = ":t", -- hide root directory at the top
        indent_markers = {
          enable = true,          -- folder level guide
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
        -- adaptive_size = true, -- left side tree
        float = { -- floating tree
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,

      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      actions = {
        open_file = {
          resize_window = false,
          quit_on_open = true,
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
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false
      }
    })
  end,
}
