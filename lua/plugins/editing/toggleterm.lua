local utils = require("core.utils")
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = utils.get_preferred_shell(),
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local term1 = Terminal:new({ count = 1, direction = "horizontal" })
    local term2 = Terminal:new({ count = 2, direction = "horizontal" })
    local float_term = Terminal:new({ direction = "float" })

    require("core.keymaps.toggleterm").setup(term1, term2, float_term)
  end,
}
