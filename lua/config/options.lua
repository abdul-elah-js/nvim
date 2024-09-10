-- general settings
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search
opt.hlsearch = true

-- appearance settings
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cmdheight = 0

-- splits
opt.splitbelow = true
opt.splitright = true

-- performance
opt.timeoutlen = 500
opt.updatetime = 300

-- file encoding
opt.encoding = "utf-8"

vim.diagnostic.config({
  virtual_text = false,    -- Disable virtual text to avoid clutter
  signs = true,            -- Show signs in the sign column
  underline = true,        -- Underline the text with diagnostics
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true,    -- Sort diagnostics by severity
  float = {
    focusable = false,     -- Whether the float can be focused
    style = "minimal",     -- Minimal styling
    border = "rounded",    -- Border style: 'single', 'double', 'rounded', 'solid', or 'shadow'
    -- source = "always",      -- Show the source of the diagnostic (e.g., LSP)
    header = "",           -- Optional header for the floating window
    prefix = "",           -- Optional prefix for each diagnostic in the floating window
  },
})
