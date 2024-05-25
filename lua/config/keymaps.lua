-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "kj", "<Escape>", opts)
keymap.set("i", "jk", "<Escape>", opts)
keymap.set("n", "U", "<C-r>", opts)
keymap.set({ "v", "n" }, "<Tab>", ":BufferNext<CR>", opts)
keymap.set({ "v", "n" }, "<S-Tab>", ":BufferPrev<CR>", opts)
keymap.set({ "v", "n" }, "<leader>bd", ":BufferDelete<CR>", opts)
keymap.set({ "v", "n" }, "<leader>bo", ":BufferCloseAllButCurrent<CR>", opts)
keymap.set({ "n" }, "<leader>bn", ":enew<CR>", { noremap = true, silent = true, desc = "New empty buffer" })
keymap.set({ "v" }, "<", "<gv", opts)
keymap.set({ "v" }, ">", ">gv", opts)
keymap.set({ "n" }, "<", "<<", opts)
keymap.set({ "n" }, ">", ">>", opts)
keymap.set({ "n" }, "<leader>do", vim.diagnostic.open_float, opts)
keymap.set({ "n" }, "<leader>dn", vim.diagnostic.goto_next, opts)
keymap.set({ "n" }, "<leader>dp", vim.diagnostic.goto_prev, opts)
