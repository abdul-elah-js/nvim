local utils = require("config.utils")
local toggle_and_notify = utils.toggle_and_notify
local opts = utils.opts

local has_lsp_attached = function()
  return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil -- 0 refers to the current buffer
end

local nvim_tree_focus_or_toggle = require("config.custom").nvim_tree_focus_or_toggle

local keymap = vim.keymap

-- Escape Insert
keymap.set({ "i" }, "kj", "<Escape>", opts("Escape Insert"))
keymap.set({ "i" }, "jk", "<Escape>", opts("Escape Insert"))

-- move line/selection up/down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts("Move Line Upwards"))
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts("Move Line Downwards"))

keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", opts("Move Selection Upwards"))
keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", opts("Move Selection Downwards"))

-- redo
keymap.set("n", "U", "<C-r>", opts("Redo"))

-- indentation
keymap.set({ "x" }, "<", "<gv", opts("Indent Selection Left"))
keymap.set({ "x" }, ">", ">gv", opts("Indent Selection Right"))
keymap.set({ "n" }, "<", "<<", opts("Indent Line Left"))
keymap.set({ "n" }, ">", ">>", opts("Indent Line Right"))

-- mods
keymap.set({ "n", "x" }, "<leader>'", '"_', opts("Blackhole Register"))
keymap.set({ "n", "v" }, "<leader>d", '"_d', opts("Delete Without Yanking"))
keymap.set({ "v" }, "<leader>p", '"_dP', opts("Paste Without Yanking"))
keymap.set({ "n", "v" }, "<leader>qq", ":qa!<CR>", opts("Quit All (No Save)"))
keymap.set({ "n", "v" }, "<leader>qa", ":qall<CR>", opts("Quit All (Save)"))

-- switches
keymap.set({ "n" }, "<leader>sn", function()
  toggle_and_notify({ opts = "number", name = "Number" })
end, opts("Numbers"))

keymap.set({ "n" }, "<leader>sr", function()
  toggle_and_notify({ opts = "relativenumber", name = "Relative Number" })
end, opts("Relative Numbers"))

keymap.set({ "n" }, "<leader>sw", function()
  toggle_and_notify({ opts = "wrap", name = "Wrap" })
end, opts("Wrap"))

-- NOTE: vim.diagnostic.show(nil, 0) works only for current buffer
keymap.set({ "n" }, "<leader>si", function()
  toggle_and_notify({
    opts = nil,
    exec = { cmd = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, output = not vim.lsp.inlay_hint.is_enabled() },
    name = "Inlay Hints",
  })
end, opts("Inlay Hints"))

keymap.set({ "n" }, "<leader>sx", function()
  toggle_and_notify({
    opts = nil,
    exec = { cmd = function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, output = not vim.diagnostic.is_enabled() },
    name = "Diagnostics",
  })
end, opts("Diagnostics"))
keymap.set({ "n" }, "<leader>nd", ":NoiceDismiss<CR>", opts("Dismiss Notifications"))
keymap.set({ "n" }, "<leader>no", ":nohl<CR>", opts("No Search Highlights"))
keymap.set({ "n" }, "<leader>na", ":NoiceAll<CR>", opts("Notifications"))

-- Lazy
keymap.set({ "n" }, "<leader>l", ":Lazy<CR>", opts("Lazy"))

-- Terminal
keymap.set({ "n", "x" }, "<C-_>", ":ToggleTerm<CR>", opts("Toggle Terminal"))
keymap.set({ "n", "x" }, "<C-/>", ":ToggleTerm<CR>", opts("Toggle Terminal"))

-- NvimTree
keymap.set({ "n" }, "<leader>e", nvim_tree_focus_or_toggle, opts("Toggle/Focus"))
keymap.set({ "n" }, "<leader>es", ":NvimTreeFindFile<CR>", opts("Search"))

-- Tmux & NeoVim navigator
keymap.set({ "n", "v" }, "<C-h>", ":TmuxNavigateLeft<CR>", opts("Window Left"))
keymap.set({ "n", "v" }, "<C-j>", ":TmuxNavigateDown<CR>", opts("Window Down"))
keymap.set({ "n", "v" }, "<C-k>", ":TmuxNavigateUp<CR>", opts("Window Up"))
keymap.set({ "n", "v" }, "<C-l>", ":TmuxNavigateRight<CR>", opts("Window Right"))

-- Tabs
keymap.set({ "n" }, "<leader>T", ":tabnew<CR>", opts("New"))
keymap.set({ "n" }, "<leader>Tn", ":tabnext<CR>", opts("Next"))
keymap.set({ "n" }, "<leader>Tp", ":tabprevious<CR>", opts("Previous"))
keymap.set({ "n" }, "<leader>Tw", ":tabclose<CR>", opts("Close"))
keymap.set({ "n" }, "<leader>To", ":tabonly<CR>", opts("Close others"))

-- Windows
keymap.set('n', '<leader>ws', ':split<CR>', opts("Horizontal split"))
keymap.set('n', '<leader>wv', ':vsplit<CR>', opts("Vertical split"))
keymap.set('n', '<leader>wc', '<C-w>c', opts("Close a window"))
keymap.set('n', '<leader>wd', '<C-w>c', opts("Close a window"))
keymap.set('n', '<leader>wo', '<C-w>o', opts("Close other windows"))
keymap.set('n', '<leader>wh', '<C-w>h', opts("Go to the left window"))
keymap.set('n', '<leader>wj', '<C-w>j', opts("Go to the bottom window"))
keymap.set('n', '<leader>wk', '<C-w>k', opts("Go to the upper window"))
keymap.set('n', '<leader>wl', '<C-w>l', opts("Go to the right window"))
keymap.set('n', '<leader>w=', '<C-w>=', opts("Equalize window split"))
keymap.set("n", "<C-w>d", ":close<CR>", opts("Close a window"))
