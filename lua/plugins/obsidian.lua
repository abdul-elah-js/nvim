return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
      -- {
      --   name = "no-vault",
      --   path = function()
      --     -- alternatively use the CWD:
      --     -- return assert(vim.fn.getcwd())
      --     return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
      --   end,
      --   overrides = {
      --     notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
      --     new_notes_location = "notes_subdir",
      --     templates = {
      --       folder = vim.NIL,
      --     },
      --     disable_frontmatter = true,
      --   },
      -- }
    },
    notes_subdir = "~/obsidian/notes",
    daily_notes = {
      folder = "dailies",
      alias_format = "%b %d %Y",
    },
    templates = {
      substitutions = {
        yesterday = function() return os.date("%b %d %Y", os.time() - 86400) end,
        tomorrow = function() return os.date("%b %d %Y", os.time() + 86400) end,
        default_id = function() return os.date("%b %d %Y", os.time() + 86400) end
      },
      folder = "/Users/abdulelah/obsidian/templates",
      date_format = "%b %d %Y",
      time_format = "%H:%M"
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<C-t>"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<CR>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
    ui = {
      enable = true,          -- set to false to disable all additional syntax features
      update_debounce = 200,  -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
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
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-n>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
  },
  keys = {
    { "<leader>oo", ":ObsidianOpen<CR>",              desc = "Open" },
    { "<leader>on", ":ObsidianNew<CR>",               desc = "New" },
    { "<leader>ox", ":ObsidianFollowLink hsplit<CR>", desc = "Open Horizontal" },
    { "<leader>ov", ":ObsidianFollowLink vsplit<CR>", desc = "Open Vertical" },
    { "<leader>oh", ":ObsidianYesterday<CR>",         desc = "Should've Done" },
    { "<leader>oj", ":ObsidianToday<CR>",             desc = "Today" },
    { "<leader>ol", ":ObsidianTomorrow<CR>",          desc = "Tomorrow" },
    { "<leader>od", ":ObsidianDailies<CR>",           desc = "Dailies" },
    { "<leader>oT", ":ObsidianTemplate<CR>",          desc = "Template" },
    { "<leader>oe", ":ObsidianNewFromTemplate<CR>",   desc = "New From Template" },
  }
}
