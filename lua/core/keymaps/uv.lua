local M = {}

M.keys = {
  { "<leader>ux", "<cmd>UVInit<CR>",        desc = "uv: init project" },
  { "<leader>ul", "<cmd>UVRunFile<CR>",     desc = "uv: run current file" },
  { "<leader>ue", "<cmd>UVRunSelection<CR>", mode = "v", desc = "uv: run selection" },
  { "<leader>up", "<cmd>UvPicker<CR>",      desc = "uv: command picker (含 venv)" },
}

return M
