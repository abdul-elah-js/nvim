-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("i", "kj", "<Escape>", opts)
keymap("i", "jk", "<Escape>", opts)
keymap("v", "s", "c", opts)
keymap("n", "s", "cl", opts)
keymap({ "v", "n" }, "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap({ "v", "n" }, "<Tab>", ":BufferLineCycleNext<CR>", opts)
