return {
  rose_pine = function()
    local highlights = require("rose-pine.plugins.toggleterm")
    require("toggleterm").setup({
      highlights = highlights
    })
  end
}
