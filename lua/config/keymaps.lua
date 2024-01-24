-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "kj", "<Escape>", opts)
keymap.set("i", "jk", "<Escape>", opts)
keymap.set({ "v", "n" }, "<S-Tab>", ":BufferPrevious<CR>", opts)
keymap.set({ "v", "n" }, "<Tab>", ":BufferNext<CR>", opts)
keymap.set({ "v", "n" }, "<leader>bd", ":BufferDelete<CR>", opts)
keymap.set({ "n", "v" }, ">", ">>", opts)
keymap.set({ "n", "v" }, "<", "<<", opts)
keymap.set({ "n", "v" }, "<leader>H", "<cmd>lua vim.diagnostics.open_float()<CR>", opts)
