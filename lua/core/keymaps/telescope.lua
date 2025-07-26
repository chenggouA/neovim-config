local M = {}

M.keys = {
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "查找文件" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "全局搜索" },
}

return M
