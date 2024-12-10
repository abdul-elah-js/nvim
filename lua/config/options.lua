-- general settings
local g = vim.g
local opt = vim.opt

-- globals
g.mapleader = " "
g.localmapleader = "\\"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.markdown_recommended_style = 0

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.conceallevel = 2
opt.swapfile = false
opt.laststatus = 0

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- search
opt.hlsearch = true
opt.incsearch = true

-- appearance settings
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.scrolloff = 999

-- splits
opt.splitbelow = true
opt.splitright = true

-- performance
opt.timeoutlen = 200
opt.updatetime = 300

-- file encoding
opt.encoding = "utf-8"
