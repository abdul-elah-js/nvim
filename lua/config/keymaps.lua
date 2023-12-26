-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "kj", "<Escape>", opts)
keymap.set("i", "jk", "<Escape>", opts)
-- keymap.set("v", "s", "c", opts)
-- keymap.set("n", "s", "cl", opts)
keymap.set({ "v", "n" }, "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap.set({ "v", "n" }, "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap.set({ "v", "n" }, "<leader>x", ":bd<CR>", opts)
keymap.set({ "n", "v" }, ">", ">>", opts)
keymap.set({ "n", "v" }, "<", "<<", opts)
-- keymap.set({ "n", "v" }, "<leader>th", ":ToggleTerm direction=horizontal", opts)
-- keymap.set({ "n", "v" }, "<leader>tf", ":ToggleTerm direction=float", opts)
