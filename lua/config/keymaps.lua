local utils = require("config.utils")
local toggles = require("config.toggles")
local opts = utils.opts

local keymap = vim.keymap

-- Source nvim
keymap.set({ "n" }, "<leader>r", ":source $MYVIMRC<CR>", opts("Reload Config"))

-- Escape Insert
keymap.set({ "i" }, "kj", "<Escape>", opts("Escape Insert"))
keymap.set({ "i" }, "jk", "<Escape>", opts("Escape Insert"))

keymap.set({ "c" }, "<C-h>", "<Left>", opts("Left"))
keymap.set({ "c" }, "<C-l>", "<Right>", opts("Right"))

-- run
keymap.set({ "n" }, "<leader>ry", utils.copy_path, opts("[R]un: Copy Absolute Path"))

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
keymap.set({ "n" }, "-", require("oil").toggle_float, opts("Oil (Float)"))
keymap.set({ "n" }, "<leader>-", ":Oil<CR>", opts("Oil (Buffer)"))

-- indentation
keymap.set({ "x" }, "<", "<gv", opts("Indent Selection Left"))
keymap.set({ "x" }, ">", ">gv", opts("Indent Selection Right"))
keymap.set({ "n" }, "<", "<<", opts("Indent Line Left"))
keymap.set({ "n" }, ">", ">>", opts("Indent Line Right"))

-- registers
keymap.set({ "n", "x" }, '<leader>"', '"_', opts("Blackhole Register"))
keymap.set({ "x" }, "<leader>c", '"_c', opts("Change Without Yanking"))
keymap.set({ "x" }, "<leader>d", '"_d', opts("Delete Without Yanking"))
keymap.set({ "x" }, "<leader>p", '"_dP', opts("Paste Without Yanking"))
keymap.set({ "n" }, "<leader>c", '"_c', opts("Change Without Yanking"), nil, false)
keymap.set({ "n" }, "<leader>d", '"_d', opts("Delete Without Yanking"), nil, false)

-- quit
keymap.set({ "n", "v" }, "<leader>qq", ":qa!<CR>", opts("Quit All (No Save)"))
keymap.set({ "n", "v" }, "<leader>qa", ":qall<CR>", opts("Quit All (Save)"))

-- toggles
keymap.set({ "n" }, "<leader>tn", toggles.toggle_numbers, opts("Line Numbers"))
keymap.set({ "n" }, "<leader>tr", toggles.toggle_relative_numbers, opts("Relative Numbers"))
keymap.set({ "n" }, "<leader>tw", toggles.toggle_wrap, opts("Wrap"))
keymap.set({ "n" }, "<leader>ti", toggles.toggle_inlay_hints, opts("Inlay Hints"))
keymap.set({ "n" }, "<leader>tx", toggles.toggle_diagnostics, opts("Diagnostics"))
keymap.set("n", "<leader>tI", toggles.toggle_virtual_text, opts("Toggle inline diagnostics"))

keymap.set({ "n" }, "<leader>tgs", toggles.toggle_gitsigns, opts("Toggle Signs"))
keymap.set({ "n" }, "<leader>tgb", toggles.toggle_git_blame, opts("Toggle Inline Blame"))
keymap.set({ "n" }, "<leader>tgl", toggles.toggle_git_line_highlight, opts("Toggle Line Highlight"))
keymap.set({ "n" }, "<leader>tgw", toggles.toggle_git_word_diff, opts("Toggle Word Diff Highlight"))
keymap.set({ "n" }, "<leader>tgn", toggles.toggle_git_line_number_highlight, opts("Toggle Line Number Highlight"))

keymap.set({ "n" }, "<leader>tc", ":TSContextToggle<CR>", opts("TSContext Toggle"))
keymap.set({ "n" }, "<leader>nd", ":NoiceDismiss<CR>", opts("Dismiss Notifications"))
keymap.set({ "n" }, "<leader>no", ":nohl<CR>", opts("No Search Highlights"))
keymap.set({ "n" }, "<leader>na", ":NoiceAll<CR>", opts("Notifications"))

-- Lsp
keymap.set({ "n" }, "<leader>ll", toggles.lsp_log, opts("Log File"))
keymap.set({ "n" }, "<leader>ls", toggles.lsp_start, opts("Start"))
keymap.set({ "n" }, "<leader>lr", toggles.lsp_restart, opts("Restart"))
keymap.set({ "n" }, "<leader>lx", toggles.lsp_stop, opts("Stop"))
keymap.set({ "n" }, "<leader>li", toggles.lsp_info, opts("Logs"))
keymap.set({ "n" }, "<leader>lI", toggles.lsp_install, opts("Install"))
keymap.set({ "n" }, "<leader>lU", toggles.lsp_uninstall, opts("Uninstall"))

-- Lazy
keymap.set({ "n" }, "<leader>L", ":Lazy<CR>", opts("Lazy"))

-- Terminal
keymap.set({ "n", "x" }, "<C-_>", ":ToggleTerm<CR>", opts("Toggle Terminal"))
keymap.set({ "n", "x" }, "<C-/>", ":ToggleTerm<CR>", opts("Toggle Terminal"))

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
