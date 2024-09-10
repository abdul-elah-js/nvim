return {
  "christoomey/vim-tmux-navigator",
  config = function()
    -- disable default tmux mappings
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
