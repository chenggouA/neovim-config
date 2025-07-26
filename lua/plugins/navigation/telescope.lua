return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = require("core.keymaps.telescope").keys,
  cmd = "Telescope",
  opts = true,
}
