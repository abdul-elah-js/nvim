local M = {
  default = function(value, default)
    if value == nil then return default end
    return value
  end,
  termcodes = function(rhs)
    vim.notify("Keys are pressed")
    return vim.api.nvim_replace_termcodes(rhs, true, true, true)
  end,
  is_floating_window_open = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        return true
      end
      return false
    end
    return false
  end,
  toggle_and_notify = function(args) -- opt = "", exec = { cmd = func(), output = bool }, name = ""
    local notification;
    if args.opt then
      vim.opt[args.opt] = not (vim.opt[args.opt]:get())
      if vim.opt[args.opt]:get() then
        notification = args.name .. " Enabled"
      else
        notification = args.name .. " Disabled"
      end
      vim.notify(notification)
    else
      args.exec.cmd()
      if args.exec.output then
        notification = args.name .. " Enabled"
      else
        notification = args.name .. " Disabled"
      end
      vim.notify(notification)
    end
  end
}

M.opts = function(desc, noremap, silent)
  return { noremap = M.default(noremap, true), silent = M.default(silent, true), desc = desc }
end

return M
