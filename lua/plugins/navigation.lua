-- 提升窗口与光标移动效率的插件
return {
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      -- 初始化 smart-splits
      require("smart-splits").setup()
      local ss = require("smart-splits")

      -- 使用 Ctrl+方向键在窗口之间切换
      vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
      vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
      vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
      vim.keymap.set("n", "<C-l>", ss.move_cursor_right)

      -- 使用 Alt+方向键调整当前窗口大小
      vim.keymap.set("n", "<A-h>", ss.resize_left)
      vim.keymap.set("n", "<A-j>", ss.resize_down)
      vim.keymap.set("n", "<A-k>", ss.resize_up)
      vim.keymap.set("n", "<A-l>", ss.resize_right)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope", -- 只有使用 Telescope 命令时才加载
    config = function()
      require("telescope").setup({})
    end,
  },
}
