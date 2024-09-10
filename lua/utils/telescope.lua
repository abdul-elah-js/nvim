local builtin = require("telescope.builtin")

local get_project_root_dir = function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    return git_root
  else
    return nil
  end
end

return {
  find_files = function(args)
    local opt = {
      cwd = get_project_root_dir()
    }
    if args.cwd then
      opt.cwd = args.cwd
    end
    if args.hidden then
      opt.hidden = args.hidden
    end
    if args.no_ignore then
      opt.no_ignore = args.no_ignore
    end
    builtin.find_files(opt)
  end,
  live_grep = function(args)
    local opt = {
      cwd = get_project_root_dir()
    }
    if args.cwd then
      opt.cwd = args.cwd
    end
    if args.hidden then
      opt.hidden = args.hidden
    end
    if args.no_ignore then
      opt.no_ignore = args.no_ignore
    end
    builtin.live_grep(opt)
  end,
  git_files = function(args)
    local opt = {
      show_untracked = true,
      use_git_root = true,
    }
    if opt.cwd then
      opt.cwd = args.cwd
    end
    if args.hidden then
      opt.hidden = args.hidden
    end
    if args.no_ignore then
      opt.no_ignore = args.no_ignore
    end
    builtin.git_files(opt)
  end
}
