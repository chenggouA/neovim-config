return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    win = { border = "rounded" },
    layout = { spacing = 6, align = "center" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>f", group = "Find 🔍" },
      { "<leader>t", group = "Terminal 🖥️" },
      { "<leader>b", group = "Buffer 📄" },
      { "<leader>w", group = "Window ❌" },
      { "<leader>g", group = "Git ⑂" },
    })
  end,
}
