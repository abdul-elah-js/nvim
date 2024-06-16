local get_root_label = function()
  local root = vim.fn.getcwd() -- Get the current working directory
  return vim.fn.fnamemodify(root, ":t") -- Get the name of the directory
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 20,
    },
    enable_cursor_hijack = false,
  },
}
