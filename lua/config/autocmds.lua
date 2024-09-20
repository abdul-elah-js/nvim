vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "norm zz"
});
