local utils = require("config.utils")
local toggle = utils.toggle
local toggles = require("config.toggles")
local opts = utils.opts

local keymap = vim.keymap
local o = vim.o
local diagnostic = vim.diagnostic
local inlay_hint = vim.lsp.inlay_hint

-- Source nvim
keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>", opts("Reload Config"))

-- Escape Insert
keymap.set("i", "kj", "<Escape>", opts("Escape Insert"))
keymap.set("i", "jk", "<Escape>", opts("Escape Insert"))

-- TODO: fix cursor movement
keymap.set("c", "<C-h>", "<Left>", opts("Left"))
keymap.set("c", "<C-l>", "<Right>", opts("Right"))

-- move line/selection up/down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts("Move Line Upwards"))
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts("Move Line Downwards"))

keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", opts("Move Selection Upwards"))
keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", opts("Move Selection Downwards"))

-- search
keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts("Search & Replace"))

-- redo
keymap.set("n", "U", "<C-r>", opts("Redo"))

-- Oil
keymap.set("n", "-", require("oil").toggle_float, opts("Oil (Float)"))

-- indentation
keymap.set("x", "<", "<gv", opts("Indent Selection Left"))
keymap.set("x", ">", ">gv", opts("Indent Selection Right"))
keymap.set("n", "<", "<<", opts("Indent Line Left"))
keymap.set("n", ">", ">>", opts("Indent Line Right"))

-- registers
keymap.set({ "n", "x" }, '<leader>"', '"_', opts("Blackhole Register"))
keymap.set("x", "<leader>c", '"_c', opts("Change Without Yanking"))
keymap.set("x", "<leader>d", '"_d', opts("Delete Without Yanking"))
keymap.set("x", "<leader>p", '"_dP', opts("Paste Without Yanking"))

-- quit
keymap.set({ "n", "v" }, "<leader>qq", ":qa!<CR>", opts("Quit All (No Save)"))
keymap.set({ "n", "v" }, "<leader>qa", ":qall<CR>", opts("Quit All (Save)"))

-- Editor & LSP
-- keymap.set("n", "<C-t>ln", toggle("numbers", o.number), opts("Line Numbers"))
-- keymap.set("n", "<C-t>rn", toggle("relative numbers", o.relativenumber), opts("Relative Numbers"))
-- keymap.set("n", "<C-t>tw", toggle("text wrap", o.wrap), opts("Text Wrap"))
-- keymap.set("n", "<C-t>i", toggle("inlay hints", inlay_hint.is_enabled(), inlay_hint.enable), opts("Inlay Hints"))
-- keymap.set("n", "<C-t>x", toggle("diagnostics", diagnostic.is_enabled(), diagnostic.enable), opts("Diagnostics"))
keymap.set("n", "<C-t>tc", ":TSContextToggle<CR>", opts("TSContext Toggle"))

keymap.set("n", "<leader>d", ":NoiceDismiss<CR>", opts("Dismiss Notifications"))
keymap.set("n", "<leader>no", ":nohl<CR>", opts("No Search Highlights"))
keymap.set("n", "<leader>na", ":NoiceAll<CR>", opts("Notifications"))

-- Git
local g = require("gitsigns.config").config
-- keymap.set("n", "<leader>gs", toggle("Git Signs", g.signcolumn, ":Gitsigns toggle_signs"), opts("Signs"))
-- keymap.set("n", "<leader>gw", toggle("Git Word DIFF", g.word_diff, ":Gitsigns toggle_git_word_diff"), opts("Word DIFF"))
-- keymap.set(
-- 	"n",
-- 	"<leader>gb",
-- 	toggle("Git Blame", g.current_line_blame, ":Gitsigns toggle_current_line_blame"),
-- 	opts("Inline Blame")
-- )
-- keymap.set(
-- 	"n",
-- 	"<leader>gh",
-- 	toggle("Git Line Highlight", g.linehl, ":Gitsigns toggle_git_line_highlight"),
-- 	opts("Line Highlights")
-- )
-- keymap.set(
-- 	"n",
-- 	"<leader>glh",
-- 	toggle("Git Line Number Highlight", g.numhl, ":Gitsigns toggle_git_line_number_highlight"),
-- 	opts("Line Number Highlights")
-- )
--
-- -- Lsp
-- keymap.set("n", "<leader>ll", toggle(nil, nil, ":LspInfo"), opts("Log File"))
-- keymap.set("n", "<leader>ls", toggle(nil, nil, ":LspStart"), opts("Start"))
-- keymap.set("n", "<leader>lr", toggle(nil, nil, ":LspRestart"), opts("Restart"))
-- keymap.set("n", "<leader>lS", toggle(nil, nil, ":LspStop"), opts("Stop"))
-- keymap.set("n", "<leader>li", toggle(nil, nil, ":LspLog"), opts("Logs"))
-- keymap.set("n", "<leader>la", toggle(nil, nil, ":LspInstall"), opts("Install"))
-- keymap.set("n", "<leader>lu", toggle(nil, nil, ":LspUninstall"), opts("Uninstall"))

-- Lazy
keymap.set({ "n" }, "<leader>L", ":Lazy<CR>", opts("Lazy"))

-- Tabs
keymap.set({ "n" }, "<leader>T", ":tabnew<CR>", opts("New"))
keymap.set({ "n" }, "<leader>Tn", ":tabnext<CR>", opts("Next"))
keymap.set({ "n" }, "<leader>Tp", ":tabprevious<CR>", opts("Previous"))
keymap.set({ "n" }, "<leader>Tw", ":tabclose<CR>", opts("Close"))
keymap.set({ "n" }, "<leader>To", ":tabonly<CR>", opts("Close others"))

-- Tmux & NeoVim navigator
keymap.set({ "n", "v" }, "<C-h>", ":TmuxNavigateLeft<CR>", opts("Window Left"))
keymap.set({ "n", "v" }, "<C-j>", ":TmuxNavigateDown<CR>", opts("Window Down"))
keymap.set({ "n", "v" }, "<C-k>", ":TmuxNavigateUp<CR>", opts("Window Up"))
keymap.set({ "n", "v" }, "<C-l>", ":TmuxNavigateRight<CR>", opts("Window Right"))

-- Windows
keymap.set("n", "<leader>ws", ":split<CR>", opts("Horizontal split"))
keymap.set("n", "<leader>wv", ":vsplit<CR>", opts("Vertical split"))
keymap.set("n", "<leader>wc", "<C-w>c", opts("Close a window"))
keymap.set("n", "<leader>wd", "<C-w>c", opts("Close a window"))
keymap.set("n", "<leader>wo", "<C-w>o", opts("Close other windows"))
keymap.set("n", "<leader>wh", "<C-w>h", opts("Go to the left window"))
keymap.set("n", "<leader>wj", "<C-w>j", opts("Go to the bottom window"))
keymap.set("n", "<leader>wk", "<C-w>k", opts("Go to the upper window"))
keymap.set("n", "<leader>wl", "<C-w>l", opts("Go to the right window"))
keymap.set("n", "<leader>w=", "<C-w>=", opts("Equalize window split"))
keymap.set("n", "<C-w>d", ":close<CR>", opts("Close a window"))
