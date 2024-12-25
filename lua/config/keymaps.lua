local utils = require("config.utils")

local k = utils.keymap
local t = require("config.keymaps_functions")

k("n", "U", "<C-r>", "Redo")

k("i", "kj", "<Escape>", "Escape Insert Mode")
k("i", "jk", "<Escape>", "Escape Insert Mode")

k("n", "<leader>ll", ":LspLog<CR>", "LSP Log")
k("n", "<leader>ls", ":LspStart<CR>", "Start LSP")
k("n", "<leader>lr", ":LspRestart<CR>", "Restart LSP")
k("n", "<leader>lS", ":LspStop<CR>", "Stop LSP")
k("n", "<leader>li", ":LspInfo<CR>", "LSP Info")
k("n", "<leader>la", ":LspInstall<CR>", "Install LSP")
k("n", "<leader>ld", ":LspUninstall<CR>", "Uninstall LSP")

k("n", "<leader>L", ":Lazy<CR>", "Lazy Package Manager")
k("n", "<leader>r", ":source $MYVIMRC<CR>", "Reload Config")
k("n", "<leader>D", ":NoiceDismiss<CR>", "Dismiss Notifications")

k("n", "<leader>no", ":nohl<CR>", "Clear Highlights")
k("n", "<leader>na", ":NoiceAll<CR>", "Show Notifications")

k("n", "<leader>gs", t.gitsigns, "Toggle Git Signs")
k("n", "<leader>gw", t.word_diff, "Toggle Word Diff")
k("n", "<leader>gb", t.inline_blame, "Toggle Inline Blame")
k("n", "<leader>gh", t.ln, "Toggle Highlights")
k("n", "<leader>gn", t.numhl, "Toggle Line Numbers")
k("n", "<C-t>n", t.numbers, "Toggle Numbers")
k("n", "<C-t>r", t.relative_numbers, "Toggle Relative Numbers")
k("n", "<C-t>w", t.wrap, "Toggle Wrap")
k("n", "<C-t>x", t.diagnostic, "Toggle Diagnostics")
k("n", "<C-t>c", t.tscontext, "Toggle TS Context")

k("n", "<", "<<", "Indent Left")
k("n", ">", ">>", "Indent Right")
k("x", "<", "<gv", "Indent Selection Left")
k("x", ">", ">gv", "Indent Selection Right")

k("n", "<A-j>", ":m .+1<CR>==", "Move Line Up")
k("n", "<A-k>", ":m .-2<CR>==", "Move Line Down")
k("x", "<A-j>", ":m '>+1<CR>gv=gv", "Move Selection Up")
k("x", "<A-k>", ":m '<-2<CR>gv=gv", "Move Selection Down")

k("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and Replace")

k("n", "-", ':lua require("oil").toggle_float()<CR>', "Toggle Oil")

k("n", "<C-w>d", ":close<CR>", "Close Window")

k("n", "<leader>T", ":tabnew<CR>", "New Tab")
k("n", "<leader>Tn", ":tabnext<CR>", "Next Tab")
k("n", "<leader>Tp", ":tabprevious<CR>", "Previous Tab")
k("n", "<leader>Tw", ":tabclose<CR>", "Close Tab")
k("n", "<leader>To", ":tabonly<CR>", "Close Other Tabs")

k("x", "<leader>c", '"_c', "Change Without Copying")
k("x", "<leader>d", '"_d', "Delete Without Copying")
k("x", "<leader>p", '"_dP', "Paste Without Overwriting")
k("x", '<leader>"', '"_', "Use Blackhole Register")

k("n", "<leader>qq", ":qa!<CR>", "Quit All (Force)")
k("n", "<leader>qa", ":qall<CR>", "Quit All")

k("n", "<C-h>", ":TmuxNavigateLeft<CR>", "Navigate Left")
k("n", "<C-j>", ":TmuxNavigateDown<CR>", "Navigate Down")
k("n", "<C-k>", ":TmuxNavigateUp<CR>", "Navigate Up")
k("n", "<C-l>", ":TmuxNavigateRight<CR>", "Navigate Right")
