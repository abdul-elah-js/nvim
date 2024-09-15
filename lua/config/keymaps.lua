local keymap = vim.keymap

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

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
keymap.set({ "n", "x" }, '<leader>"', '"_', opts("Blackhole Register"))
keymap.set({ "n", "v" }, "<leader>qq", ":qa!<CR>", opts("Quit All"))

-- tmux & NeoVim navigator
keymap.set({ "n", "v" }, "<C-h>", ":TmuxNavigateLeft<CR>", opts("Window Left"))
keymap.set({ "n", "v" }, "<C-j>", ":TmuxNavigateDown<CR>", opts("Window Down"))
keymap.set({ "n", "v" }, "<C-k>", ":TmuxNavigateUp<CR>", opts("Window Up"))
keymap.set({ "n", "v" }, "<C-l>", ":TmuxNavigateRight<CR>", opts("Window Right"))

keymap.set({ "n" }, "<leader>wk", ":resize -10", opts("- Height"))
keymap.set({ "n" }, "<leader>wj", ":resize +10", opts("+ Height"))
keymap.set({ "n" }, "<leader>wh", ":vertical resize -10", opts("- Width"))
keymap.set({ "n" }, "<leader>wl", ":vertical resize +10", opts("+ Height"))
keymap.set({ "n" }, "<leader>wd", ":close<CR>", opts("Close Window"))

keymap.set({ "n" }, "<C-u>", "<C-u>zz", opts("Scroll Up"))
keymap.set({ "n" }, "<C-d>", "<C-d>zz", opts("Scroll Down"))
keymap.set({ "n" }, "<C-y>", "<C-y>zz", opts("Scroll Up"))
keymap.set({ "n" }, "<C-e>", "<C-e>zz", opts("Scroll Down"))

-- config
keymap.set({ "n" }, "<leader>si", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts("Toggle inlay_hints"))
keymap.set({ "n" }, "<leader>sw", ":set wrap!<CR>", opts("Toggle Wrap"))
keymap.set({ "n" }, "<leader>sl", ":set number!<CR>", opts("Toggle Line Numbers"))
keymap.set({ "n" }, "<leader>sr", ":set relativenumber!<CR>", opts("Toggle Relative Line Numbers"))
keymap.set({ "n" }, "<leader>sq", ":NoiceDismiss<CR>", opts("Dismiss Notifications"))
keymap.set({ "n" }, "<leader>sx", ":nohl<CR>", opts("Remove Highlights"))
keymap.set({ "n" }, "<leader>st", ":TSContextToggle<CR>", opts("Toggle TSContext"))
keymap.set({ "n" }, "<leader>sCr", vim.lsp.codelens.display, opts("Display Codelens"))
keymap.set({ "n" }, "<leader>sCr", vim.lsp.codelens.refresh, opts("Clear Codelens"))
keymap.set({ "n" }, "<leader>sCx", vim.lsp.codelens.clear, opts("Clear Codelens"))

-- Lazy
keymap.set({ "n" }, "<leader>l", ":Lazy<CR>", opts("Lazy"))

-- Terminal
keymap.set({ "n", "x" }, "<C-_>", ":ToggleTerm<CR>", opts("Toggle Terminal"))
keymap.set({ "n", "x" }, "<C-/>", ":ToggleTerm<CR>", opts("Toggle Terminal"))
-- keymap.set({ "x" }, "<C-_>", "<C-\\><C-n>:ToggleTerm<CR>", opts("Toggle Terminal"))
-- keymap.set({ "x" }, "<C-/>", "<C-\\><C-n>:ToggleTerm<CR>", opts("Toggle Terminal"))

-- Buffers
keymap.set({ "n" }, "<leader>bd", ":Bdelete<CR>", opts("Delete Buffer"))
keymap.set({ "n" }, "<leader>bp", ":BufferLineTogglePin<CR>", opts("Pin/Unpin Buffer"))
keymap.set({ "n" }, "<Tab>", ":BufferLineCycleNext<CR>", opts("Next Buffer"))
keymap.set({ "n" }, "<S-Tab>", ":BufferLineCyclePrev<CR>", opts("Prev Buffer"))
keymap.set({ "n" }, "<leader>bo", ":BufferLineCloseOthers<CR>", opts("Delete Others"))
keymap.set({ "n" }, "<leader>br", ":BufferLineCloseRight<CR>", opts("Delete Right"))
keymap.set({ "n" }, "<leader>bl", ":BufferLineCloseLeft<CR>", opts("Delete Left"))
