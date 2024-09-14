local keymap = vim.keymap

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- escape insert
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

-- config
keymap.set({ "n" }, "<leader>si", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts("Toggle inlay_hints"))
keymap.set({ "n" }, "<leader>sw", ":set wrap!<CR>", opts("Toggle Wrap"))
keymap.set({ "n" }, "<leader>sl", ":set number!<CR>", opts("Toggle Line Numbers"))
keymap.set({ "n" }, "<leader>sr", ":set relativenumber!<CR>", opts("Toggle Relative Line Numbers"))
keymap.set({ "n" }, "<leader>scr", vim.lsp.codelens.display, opts("Display Codelens"))
keymap.set({ "n" }, "<leader>scr", vim.lsp.codelens.refresh, opts("Clear Codelens"))
keymap.set({ "n" }, "<leader>scx", vim.lsp.codelens.clear, opts("Clear Codelens"))

-- Lazy
keymap.set({ "n" }, "<leader>l", ":Lazy<CR>", opts("Lazy"))

keymap.set({ "n" }, "<C-_>", ":ToggleTerm<CR>", opts("Toggle Terminal"))
keymap.set({ "n" }, "<C-/>", ":ToggleTerm<CR>", opts("Toggle Terminal"))

keymap.set({ "x" }, "<C-_>", "<C-\\><C-n>:ToggleTerm<CR>", opts("Toggle Terminal"))
keymap.set({ "x" }, "<C-/>", "<C-\\><C-n>:ToggleTerm<CR>", opts("Toggle Terminal"))

--
-- keymap.set("n", "P", ":set paste<CR>P:set nopaste<CR>", opts)
-- keymap.set("x", "p", ':<C-u> paste<CR>gv"_dp:set nopaste<CR>', opts)
-- keymap.set("x", "P", ':<C-u> paste<CR>gv"_dP:set nopaste<CR>', opts)
