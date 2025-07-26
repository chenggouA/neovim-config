local M = {}

function M.setup(ss)
  local map = vim.keymap.set
  map("n", "<C-h>", ss.move_cursor_left)
  map("n", "<C-j>", ss.move_cursor_down)
  map("n", "<C-k>", ss.move_cursor_up)
  map("n", "<C-l>", ss.move_cursor_right)

  map("n", "<A-h>", ss.resize_left)
  map("n", "<A-j>", ss.resize_down)
  map("n", "<A-k>", ss.resize_up)
  map("n", "<A-l>", ss.resize_right)
end

return M
