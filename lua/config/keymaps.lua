-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Escape insert mode
keymap.set("i", "kj", "<Escape>", opts)
keymap.set("i", "jk", "<Escape>", opts)
-- Undo
keymap.set("n", "U", "<C-r>", opts)
-- Buffers
keymap.set({ "v", "n" }, "<Tab>", ":BufferNext<CR>", opts)
keymap.set({ "v", "n" }, "<S-Tab>", ":BufferPrev<CR>", opts)
keymap.set({ "v", "n" }, "<leader>bd", ":BufferDelete<CR>", opts)
keymap.set({ "v", "n" }, "<leader>bo", ":BufferCloseAllButCurrent<CR>", opts)
-- Indentation
keymap.set({ "v" }, "<", "<gv", opts)
keymap.set({ "v" }, ">", ">gv", opts)
keymap.set({ "n" }, "<", "<<", opts)
keymap.set({ "n" }, ">", ">>", opts)
-- Windows navigation
keymap.set({ "n", "v" }, "<leader>wh", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Go to Left Window" })
keymap.set({ "n", "v" }, "<leader>wl", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Go to Right Window" })
keymap.set({ "n", "v" }, "<leader>wk", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Go to Upper Window" })
keymap.set({ "n", "v" }, "<leader>wj", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Go to Lower Window" })
-- Windows resize
keymap.set({ "n" }, "<leader>-Up", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set({ "n" }, "<leader>-Down", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set({ "n" }, "<leader>-Left", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set({ "n" }, "<leader>-Right", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Height" })
-- Terminal
local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
keymap.set({ "t" }, "<C-q>", "<c-\\><c-n>", { silent = true, noremap = true })
keymap.set({ "i" }, "<c-/>", lazyterm, { silent = true, noremap = true })
keymap.set({ "n" }, "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Terminal (Horizontal)" })
keymap.set({ "n" }, "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Terminal (Vertical)" })
-- line break
-- keymap.set({ "n" }, "<leader>nl", "<NL>", opts)
-- Diagnostics
keymap.set(
  { "n" },
  "<leader>do",
  vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Diagnostics Open Float" }
)
keymap.set(
  { "n" },
  "<leader>dn",
  vim.diagnostic.goto_next,
  { noremap = true, silent = true, desc = "Diagnostics GoTo Next" }
)
keymap.set(
  { "n" },
  "<leader>dp",
  vim.diagnostic.goto_prev,
  { noremap = true, silent = true, desc = "Diagnostics GoTo Previous" }
)
