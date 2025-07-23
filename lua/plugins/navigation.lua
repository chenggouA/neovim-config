return {
{
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup()
    local ss = require("smart-splits")
    -- 快捷键：方向键切换窗口
    vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
    vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
    vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
    vim.keymap.set("n", "<C-l>", ss.move_cursor_right)

    -- 快捷键：Alt+方向键调整窗口大小
    vim.keymap.set("n", "<A-h>", ss.resize_left)
    vim.keymap.set("n", "<A-j>", ss.resize_down)
    vim.keymap.set("n", "<A-k>", ss.resize_up)
    vim.keymap.set("n", "<A-l>", ss.resize_right)
  end,
},





}
